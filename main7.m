%% clear
clear;clc;
rng(42);
%% parameters
D=2;            % days to squeeze
V=20;        % number of nodes(6 times)
Lr=0;           % rate that a path would be adjust to "L" path, set it to 0
L1r=10;         % rate that a path would be adjust to "L-1" path
patience=10;    % times try to adjust
b_min=10;       % b min
b_max=50;      % original b max, which would be break if adjust
c_min=1;        % c min
c_max=10;      % c max



%% LOOP
maxnum = 1000;
abnormal1 = zeros(3,0);
iter = 1;
for i = 1:maxnum
        IterStart = tic;
        
        % GenStart = tic;
        G=create_dag8(V,b_min,b_max,c_min,c_max,Lr,L1r);
        % GenTime = toc(GenStart);
        % disp(["Generate time:",GenTime]);

        % tic;
        [~, min_pay]=lp3(G,D);
        % LPTime = toc;
        % disp(["LP time:",LPTime]);

        if min_pay == 0
            %disp("Not solvable")
            continue;
        end
        
        % tic;
        greed = 0;
        G1 = G;
        for days=1:D
            [mf,G1,cut_s,cut_t]=greedy2(G1);
            greed = greed + mf;
        end

        % GreedyTime = toc;
        % disp(["Greedy time:",GreedyTime]); 

        if min_pay<greed
            disp('|LP| < |Greedy| !!!!!');
            temp = zeros(3,1);
            temp(1,1) = greed;
            temp(2,1) = min_pay;
            temp(3,1) = greed/min_pay;
            disp(greed);
            disp(min_pay);
            disp(greed/min_pay);
            abnormal1 = [abnormal1,temp];
        end
        disp(iter)
        iter = iter+1;
        IterTime = toc(IterStart);
        %disp(["Iter time:",IterTime]);
end

if(size(abnormal1))
    writematrix(abnormal1(3,:), 'abnormal1.xlsx');
    [F, X] = ecdf(abnormal1(3,:)); % 计算累积分布函数值和对应的X值
    disp(max(abnormal1(3,:)))
    figure;
    plot(X, F, 'LineWidth', 2); % 绘制累积概率图
    xlabel('Approximation Ratio');
    ylabel('Cumulative Distribution');
end