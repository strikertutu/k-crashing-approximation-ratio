%% create a directed acyclic graph G with A,B,C
function G = create_dag7(V,b_min,b_max,c_min,c_max,Lr,L1r,edgenum)
%% create original graph
%tic;

B=zeros(V,V);
k = 1;
while k<edgenum
    % randomly create i<j
    i=randi([1,V-1]);
    j=randi([i+1,V]);
    % connect i to j
    while(B(i,j)~=0) 
        while(B(i,j)~=0)
            j = j+1;
            if(j>V)
                j = j - 1;
                break
            end
        end
        if(B(i,j)==0)
            break
        end
        i = i+1;
        if(i == V) 
            i = 1;
        end
        j = i+1;
    end
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

%OrgTime = toc;
%disp("orginal time:");    
%disp(OrgTime);


%% add a, c, strabc, index to G
E=height(G.Edges);
for i=1:E
    %G.Edges.A(i)=G.Edges.Weight(i)-G.Edges.Weight(i)+1;
    G.Edges.A(i)=1;
    G.Edges.B(i)=G.Edges.Weight(i);
    G.Edges.C(i)=randi([c_min,c_max]);
    G.Edges.strABC(i)=convertCharsToStrings([num2str(i),':[',num2str(G.Edges.A(i)),',',num2str(G.Edges.B(i)),'](',num2str(G.Edges.C(i)),')']);
    G.Edges.index(i)=i;
end
end