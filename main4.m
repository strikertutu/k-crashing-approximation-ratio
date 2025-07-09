%% clear
clear;clc;
rng(42);
%% parameters
D=2;            % days to squeeze
Vs=295;          % number of nodes(6 times)
Lr=0;           % rate that a path would be adjust to "L" path, set it to 0
L1r=10;         % rate that a path would be adjust to "L-1" path
patience=10;    % times try to adjust
b_min=10;       % b min
b_max=20;      % original b max, which would be break if adjust
c_min=1;        % c min
c_max=10;      % c max
Vt = 300;
V = Vt;
step = 1;
%% LOOP
batchsize = 10;
abnormal = zeros(0,0);
times = zeros((Vt-Vs)/step+1,batchsize,2);
iter = 1;
res1 = zeros((Vt-Vs)/step+1,2);
res2 = zeros((Vt-Vs)/step+1,2);
for j = 1:(Vt-Vs)/step+1
    i = (Vt-Vs)/step+1-j+1;
    disp(V);  
    for k = 1:batchsize
        disp(["iteration:",iter])
        GenStart = tic;
        G=create_dag6(V,b_min,b_max,c_min,c_max,Lr,L1r,patience);
        GenTime = toc(GenStart);
        disp(["Generate time:",GenTime]);
    
        tic;
        [~, min_pay]=lp2(G,D);
        LPTime = toc;
        disp(["LP time:",LPTime]);
    
        tic;
        greed = 0;
        G1 = G;
        for days=1:D
            [mf,G1,cut_s,cut_t]=greedy2(G1);
            greed = greed + mf;
        end
        
        GreedyTime = toc;
        disp(["Greedy time:",GreedyTime]);
        
        iter = iter+1;
        times(i,k,1) = LPTime;
        times(i,k,2) = GreedyTime;
    end
    res1(i,1) = mean(times(i,:,1));
    res1(i,2) = mean(times(i,:,2));
    writematrix(res1, 'res1.xlsx');
    res2(i,1) = median(times(i,:,1));
    res2(i,2) = median(times(i,:,2));
    writematrix(res2, 'res2.xlsx');
    V=V-step;  
end
save('times.mat', 'times');

% data
x = linspace(Vs,Vt,(Vt-Vs)/step+1);
y = res1(:,1);
x2 = x;
y2 = res1(:,2);
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