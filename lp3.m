%% LP algorithm
function [x,min_pay]=lp3(G,D)
%% find path
%[all_paths,all_edgepaths,~,L,~]=find_path(G);
E=height(G.Edges);
V=height(G.Nodes);
MaxLength = findMaxPathLength(G,1,V);
edges = G.Edges.EndNodes;
%% number of x

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
A_lin=zeros(3*E+2, E+V);
% a<x<b
A_lin(1:E,1:E)=eye(E,E);
A_lin(1+E:2*E,1:E)=-eye(E,E);
% p<L-D

%% creat b_lin
b_lin=zeros(length(A_lin),1);
% a<x<b
b_lin(1:2*E,1)=[B';-A'];
% p<L-D
%b_lin(1+2*E:length(A_lin),1)=L-D;
%Nodes
for i=2*E+1:3*E
    num_edge = i-2*E;
    st = edges(num_edge,1);
    ed = edges(num_edge,2);
    A_lin(i,E+ed) = -1;
    A_lin(i,E+st) = 1;
    A_lin(i,num_edge) = 1;
end

A_lin(3*E+1,E+1) = -1;
A_lin(3*E+2,E+V) = 1;
b_lin(3*E+1,1)=0;
b_lin(3*E+2,1)=MaxLength-D;
%% creat c_lin
c_lin=C;
%% solve LP
% options=optimset('Display','off');
% x = linprog(-c_lin,A_lin,b_lin,[],[],[],[],options);
f=-c_lin;
f = [f zeros(1,V)];
intcon=1:(E+V);

%%create x0
tv = zeros(1,V-1);
G2.Edges.Weight = -G.Edges.Weight;
for i = 1:V-1
    [~,tv(i)] = shortestpath(G2,1,i+1);
    tv(i) = -tv(i);
end
tv(V-1) = MaxLength-D;
%disp(size(B'))
x0 = [A,0,tv]';

%disp(tv)
options=optimoptions('intlinprog','Display','none');
x = intlinprog(f,intcon,A_lin,b_lin,[],[],[],[],x0,options);
%disp(size(x));
if(~isempty(x))
    min_pay = c_lin*B' - c_lin*x(1:E);
else
    min_pay = 0;
    %disp("empty x")
end
end