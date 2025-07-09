%% clear
clear;clc;
rng(42);
%% parameters
D=2;            % days to squeeze
Vs=330;          % number of nodes(6 times)
Lr=0;           % rate that a path would be adjust to "L" path, set it to 0
L1r=10;         % rate that a path would be adjust to "L-1" path
patience=10;    % times try to adjust
b_min=10;       % b min
b_max=50;      % original b max, which would be break if adjust
c_min=1;        % c min
c_max=10;      % c max
Vt = 600; 
V = Vt;

step = 30;
%% LOOP
batchsize = 50;
abnormal1 = zeros(3,0);
abnormal2 = zeros(3,0);
times1 = zeros((Vt-Vs)/step+1,batchsize,2);
times2 = zeros((Vt-Vs)/step+1,batchsize,2);
iter = 1;
res1_mean = zeros((Vt-Vs)/step+1,2);
res1_median = zeros((Vt-Vs)/step+1,2);
for j = 1:(Vt-Vs)/step+1
    i = (Vt-Vs)/step+1-j+1;
    disp(V);  
    E1 = V*V*0.1;
    E2 = 20*V;

    %dense graph
    k = 1;
    while k <= batchsize
        disp(["dense iteration:",iter])
        GenStart = tic;
        G=create_dag9(V,b_min,b_max,c_min,c_max,Lr,L1r,E1);
        GenTime = toc(GenStart);
        disp(["Generate time:",GenTime]);

        tic;
        [~, min_pay]=lp3(G,D);
        LPTime = toc;
        disp(["LP time:",LPTime]);

        if min_pay == 0
            disp("No solution")
            continue;
        end

        tic;
        greed = 0;
        G1 = G;
        for days=1:D
            [mf,G1,cut_s,cut_t]=greedy2(G1);
            greed = greed + mf;
        end

        GreedyTime = toc;
        disp(["Greedy time:",GreedyTime]); 

        if min_pay<greed
            disp('|LP| < |Greedy| !!!!!');
            temp = zeros(3,1);
            temp(1,1) = greed;
            temp(2,1) = min_pay;
            temp(3,1) = greed/min_pay;
            disp(greed);
            disp(min_pay);
            abnormal1 = [abnormal1,temp];
        end

        iter = iter+1;
        times1(i,k,1) = LPTime;
        times1(i,k,2) = GreedyTime;
        k = k+1;
    end
    res1_mean(i,1) = mean(times1(i,:,1));
    res1_mean(i,2) = mean(times1(i,:,2));
    writematrix(res1_mean, 'res1_mean.xlsx');
    res1_median(i,1) = median(times1(i,:,1));
    res1_median(i,2) = median(times1(i,:,2));
    writematrix(res1_median, 'res1_median.xlsx');

    %sparse graph
    k = 1;
    while k <= batchsize
        disp(["sparse iteration:",iter])
        GenStart = tic;
        G=create_dag9(V,b_min,b_max,c_min,c_max,Lr,L1r,E2);
        GenTime = toc(GenStart);
        disp(["Generate time:",GenTime]);
    
        tic;
        [~, min_pay]=lp3(G,D);
        LPTime = toc;
        disp(["LP time:",LPTime]);

        if min_pay == 0
            disp("No solution")
            continue;
        end
    
        tic;
        greed = 0;
        G1 = G;
        for days=1:D
            [mf,G1,cut_s,cut_t]=greedy2(G1);
            greed = greed + mf;
        end
        
        GreedyTime = toc;
        disp(["Greedy time:",GreedyTime]);

        if min_pay<greed
            disp('|LP| < |Greedy| !!!!!');
            temp = zeros(3,1);
            temp(1,1) = greed;
            temp(2,1) = min_pay;
            temp(3,1) = greed/min_pay;
            disp(greed);
            disp(min_pay);
            abnormal2 = [abnormal2,temp];
        end
        
        iter = iter+1;
        times2(i,k,1) = LPTime;
        times2(i,k,2) = GreedyTime;
        k = k+1;
    end
    res2_mean(i,1) = mean(times2(i,:,1));
    res2_mean(i,2) = mean(times2(i,:,2));
    writematrix(res2_mean, 'res2_mean.xlsx');
    res2_median(i,1) = median(times2(i,:,1));
    res2_median(i,2) = median(times2(i,:,2));
    writematrix(res2_median, 'res2_median.xlsx');
    V=V-step;  
end
save('times1.mat', 'times1');
save('times2.mat', 'times2');

% data
x = linspace(Vs,Vt,(Vt-Vs)/step+1);
y = res1_mean(:,1);
x2 = x;
y2 = res1_mean(:,2);
% plotting
figure;
plot(x, y, '-o', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
hold on;
plot(x2, y2, '-s', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% legend
legend('LP', 'KD', 'Location', 'best');

% axis
title('Time used on different scalces');
xlabel('Number of nodes ');
ylabel('Time used(s)');
grid on;

% data
x = linspace(Vs,Vt,(Vt-Vs)/step+1);
y = res2_mean(:,1);
x2 = x;
y2 = res2_mean(:,2);
% plotting
figure;
plot(x, y, '-o', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
hold on;
plot(x2, y2, '-s', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% legend
legend('LP', 'KD', 'Location', 'best');

% axis
title('Time used on different scalces');
xlabel('Number of nodes ');
ylabel('Time used(s)');
grid on;

if(~isempty(abnormal1))
    writematrix(abnormal1, 'abnormal1.xlsx');
    [F, X] = ecdf(abnormal1); % 计算累积分布函数值和对应的X值
     
    figure;
    plot(X, F, 'LineWidth', 2); % 绘制累积概率图
    xlabel('Approximation Ratio');
    ylabel('Cumulative Distribution');
end

if(~isempty(abnormal2))
    writematrix(abnormal2, 'abnormal1.xlsx');
    [F, X] = ecdf(abnormal2); % 计算累积分布函数值和对应的X值
     
    figure;
    plot(X, F, 'LineWidth', 2); % 绘制累积概率图
    xlabel('Approximation Ratio');
    ylabel('Cumulative Distribution');
end