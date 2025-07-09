%% create a directed acyclic graph G with A,B,C
function G = create_dag6(V,b_min,b_max,c_min,c_max,Lr,L1r,patience)
%% create original graph
%tic;
num_edge = 0;
B=zeros(V,V);
for k=1:V^2
    % randomly create i<j
    i=randi([1,V-1]);
    j=randi([i+1,V]);
    % connect i to j
    if B(i,j)==0
        % generate b
        B(i,j)=randi([b_min,b_max]);
        num_edge = num_edge+1;
    end
    if num_edge>=35000
        break
    end
end
for i=2:V-1
    if sum(B(:,i))==0 && sum(B(i,:))~=0
        B(1,i)=randi([b_min,b_max]);
    end
    if sum(B(i,:))==0 && sum(B(:,i))~=0
        B(i,V)=randi([b_min,b_max]);
    end
end
G=digraph(B);
E=height(G.Edges);

%OrgTime = toc;
%disp("orginal time:");    
%disp(OrgTime);


%% add a, c, strabc, index to G
E=height(G.Edges);
for i=1:E
    G.Edges.A(i)=G.Edges.Weight(i)-G.Edges.Weight(i)+1;
    G.Edges.B(i)=G.Edges.Weight(i);
    G.Edges.C(i)=randi([c_min,c_max]);
    G.Edges.strABC(i)=convertCharsToStrings([num2str(i),':[',num2str(G.Edges.A(i)),',',num2str(G.Edges.B(i)),'](',num2str(G.Edges.C(i)),')']);
    G.Edges.index(i)=i;
end
end

