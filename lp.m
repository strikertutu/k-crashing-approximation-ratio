%% LP algorithm
function [x,min_pay]=lp(G,D)
%% find path
[all_paths,all_edgepaths,~,L,~]=find_path(G);
%% number of x
E=height(G.Edges);
%% "lay down" B
B=full(adjacency(G,'weighted'));
B=B';
B=B(1:end);
B(B==0) = [];
%% "lay down" A
G2 = G;
G2.Edges.Weight=G2.Edges.A;
A=full(adjacency(G2,'weighted'));
A=A';
A=A(1:end);
A(A==0) = [];
%% "lay down" C
G2.Edges.Weight=G2.Edges.C;
C=full(adjacency(G2,'weighted'));
C=C';
C=C(1:end);
C(C==0) = [];
%% creat A_lin
A_lin=zeros(2*E + length(all_paths), E);
% a<x<b
A_lin(1:E,1:E)=eye(E,E);
A_lin(1+E:2*E,1:E)=-eye(E,E);
% p<L-D
for i=2*E+1:length(A_lin)
    A_lin(i,cell2mat(all_edgepaths(i-2*E)))=1;
end
%% creat b_lin
b_lin=zeros(length(A_lin),1);
% a<x<b
b_lin(1:2*E,1)=[B';-A'];
% p<L-D
b_lin(1+2*E:length(A_lin),1)=L-D;
%% creat c_lin
c_lin=C;
%% solve LP
% options=optimset('Display','off');
% x = linprog(-c_lin,A_lin,b_lin,[],[],[],[],options);
f=-c_lin;
intcon=1:E;
options=optimoptions('intlinprog','Display','off');
x = intlinprog(f,intcon,A_lin,b_lin,[],[],[],[],[],options);
%disp(size(x));
if(~isempty(x))
    min_pay = c_lin*B' - c_lin*x;
else
    min_pay = 0;
end
end
