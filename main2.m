%% clear
clear;clc;
rng("shuffle")
%% parameters
D=10;            % days to squeeze
V=100;            % number of nodes
Lr=0;           % rate that a path would be adjust to "L" path, set it to 0
L1r=10;         % rate that a path would be adjust to "L-1" path
patience=10;    % times try to adjust
b_min=10;       % b min
b_max=20;      % original b max, which would be break if adjust
c_min=1;        % c min
c_max=10;      % c max
%% LOOP
iter=0;
maxnum = 10000;
res = zeros(1,maxnum);
abnormal = zeros(0,0);
while iter<maxnum
    % GenStart = tic;
    G=create_dag5(V,b_min,b_max,c_min,c_max,Lr,L1r,patience);
    % GenTime = toc(GenStart);
    % disp("Generate time:");
    % disp(GenTime);

    % tic;
    [x, min_pay]=lp2(G,D);
    % LPTime = toc;
    % disp("LP time:");
    % disp(LPTime);

    if(min_pay == 0)
        disp("Not solvable");
        continue
    end

    % tic;
    greed = 0;
    %cuts_s = cell(D);
    %cuts_t = cell(D);
    %Gs=cell(D);
    G1 = G;
    for i=1:D
        [mf,G1,cut_s,cut_t]=greedy2(G1);
        %cuts_s{i} = cut_s;
        %cuts_t{i} = cut_t;
        %Gs{i} = G1;
        greed = greed + mf;
    end
    
    % GreedyTime = toc;
    % disp("Greedy time:");
    % disp(GreedyTime)

    res(iter+1) = greed/min_pay;


    if min_pay<greed
        disp('|LP| < |Greedy| !!!!!');
        temp = greed/min_pay;
        disp(temp);
        abnormal = [abnormal,temp];
        %save_graph(G,'fanli');
        % fig1=print_graph(G,0,1);
        % fig2=print_lp(G,x,2);
        % fig3=print_greedy(Gs{1},cuts_s{1},cuts_t{1},3);
        % fig4=print_greedy(Gs{2},cuts_s{2},cuts_t{2},4);
        % waitfor(gcf);
        %print_fig(fig1,fig2,fig3,fig4);
        %break;
    end
    iter=iter+1;
    disp(iter);  
end
if(size(abnormal))
    writematrix(abnormal, 'abnormal.xlsx');
    [F, X] = ecdf(abnormal); % 计算累积分布函数值和对应的X值
     
    figure;
    plot(X, F, 'LineWidth', 2); % 绘制累积概率图
    xlabel('Approximation Ratio');
    ylabel('Cumulative Distribution');
end
%histogram(res);
