%% clear
clear;clc;
%% parameters
D=3;            % days to squeeze
V=10;            % number of nodes
Lr=0;           % rate that a path would be adjust to "L" path, set it to 0
L1r=10;         % rate that a path would be adjust to "L-1" path
patience=10;    % times try to adjust
b_min=100;       % b min
b_max=300;      % original b max, which would be break if adjust
c_min=10;        % c min
c_max=100;      % c max
%% LOOP
iter=0;
maxnum = 100;
res = zeros(1,maxnum);
while iter<maxnum
    G=create_dag2(V,b_min,b_max,c_min,c_max,Lr,L1r,patience,D);
    [x, min_pay]=lp2(G,D);
    [mf,G_new,cut_s,cut_t]=greedy(G);
    [mf_2,G_new2,cut_s_2,cut_t_2]=greedy2(G_new);
    [mf_3,~,cut_s_3,cut_t_3]=greedy2(G_new2);
    res(iter+1) = (mf+mf_2+mf_3)/min_pay;
    if min_pay<mf+mf_2+mf_3
        disp('|LP| < |Greedy| !!!!!');
        disp((mf+mf_2+mf_3)/min_pay);
        %save_graph(G,'fanli');
        %fig1=print_graph(G,0,1);
        %fig2=print_lp(G,x,2);
        %fig3=print_greedy(G,cut_s,cut_t,3);
        %fig4=print_greedy(G_new,cut_s_2,cut_t_2,4);
        % print_fig(fig1,fig2,fig3,fig4);
        %break;
    end
    iter=iter+1;
    disp(iter);  
end
%histogram(res);
