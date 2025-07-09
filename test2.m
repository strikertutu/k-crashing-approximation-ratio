%% clear
clear;clc;
rng(42)
%% parameters
D=10;            % days to squeeze
V=25;            % number of nodes
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
    G=create_dag7(V,b_min,b_max,c_min,c_max,Lr,L1r,patience);
    
    [x, min_pay]=lp(G,D);
    [x2, min_pay2]=lp3(G,D);
    greed1 = 0;
    G1 = G;
    for i=1:D
        [mf,G1,cut_s,cut_t]=greedy(G1);
        %cuts_s{i} = cut_s;
        %cuts_t{i} = cut_t;
        %Gs{i} = G1;
        greed1 = greed1 + mf;
    end
    
    greed2=0;
    G2 = G;
    for i=1:D
        [mf,G2,cut_s,cut_t]=greedy2(G2);
        %cuts_s{i} = cut_s;
        %cuts_t{i} = cut_t;
        %Gs{i} = G1;
        greed2 = greed2 + mf;
    end

    if(greed1~=greed2)
        disp("unmatch");
        disp(greed1);
        disp(greed2);
    end

     if(min_pay~=min_pay2)
        disp("unmatch");
        disp(min_pay);
        disp(min_pay2);
    end


    % if(min_pay == 0)
    %     disp("Not solvable");
    %     continue
    % end
    iter = iter+1;
    disp(iter);
end

%histogram(res);
