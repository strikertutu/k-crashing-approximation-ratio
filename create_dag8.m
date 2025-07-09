%% create a directed acyclic graph G with A,B,C
function G = create_dag8(V,b_min,b_max,c_min,c_max,Lr,L1r)
%% create original graph
%tic;

B=zeros(V,V);
k = 1;
for k=1:V^2
    % randomly create i<j
    i=randi([1,V-1]);
    j=randi([i+1,V]);
    % connect i to j
    if B(i,j)==0
        % generate b
        B(i,j)=randi([b_min,b_max]);
        k=k+1;
    end
end
for i=2:V
    if sum(B(:,i))==0
        B(1,i)=randi([b_min,b_max]);
    end
end

for i=2:V-1
    if sum(B(i,:))==0
        B(i,V)=randi([b_min,b_max]);
    end
end
G=digraph(B);
E=height(G.Edges);

G2=G;
tv = zeros(1,V);
G2.Edges.Weight = -G.Edges.Weight;
for i = 2:V
    [~,tv(i)] = shortestpath(G2,1,i);
    tv(i) = -tv(i);
end

% for i=1:E
%     r = randi([1,100]);
%     if(r <= L1r)
%         G.Edges.Weight(i) = tv(G.Edges.EndNodes(i,2))-tv(G.Edges.EndNodes(i,1))-1;
%     else
%         G.Edges.Weight(i) = tv(G.Edges.EndNodes(i,2))-tv(G.Edges.EndNodes(i,1));
%     end
% end

for i=1:E
    G.Edges.Weight(i) = tv(G.Edges.EndNodes(i,2))-tv(G.Edges.EndNodes(i,1));
end

%% add a, c, strabc, index to G
E=height(G.Edges);
for i=1:E
    %G.Edges.A(i)=G.Edges.Weight(i)-G.Edges.Weight(i)+1;
    G.Edges.A(i)=randi([1,G.Edges.Weight(i)]);
    G.Edges.B(i)=G.Edges.Weight(i);
    G.Edges.C(i)=randi([c_min,c_max]);
    G.Edges.strABC(i)=convertCharsToStrings([num2str(i),':[',num2str(G.Edges.A(i)),',',num2str(G.Edges.B(i)),'](',num2str(G.Edges.C(i)),')']);
    G.Edges.index(i)=i;
end
end