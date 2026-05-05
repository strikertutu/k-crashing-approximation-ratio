%% create a directed acyclic graph G with A,B,C
function G = create_dag10(V,b_min,b_max,c_min,c_max,Lr,L1r,edgenum)
%% create original graph
%tic;
levelrate = 50; %50 out of 100
shortrate = 10; %10 out of 100

d=zeros(1,V);
d(1) = 0;
d(2) = 2;
for i = 3:V
    rand1 = randi([1,100]);
    if(rand1<=levelrate)
        d(i) = d(i-1) + randi([2,10]);
    else
        d(i) = d(i-1);
    end
end
d(V) = d(V-1)+randi([2,10]);
%disp(size(d));
%disp(d(V));

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
    if B(i,j)==0 && d(i)~=d(j)
        % generate b
        B(i,j)=d(j)-d(i);
        
        %shorten
        rand2 = randi([1,100]);
        if(rand2<=shortrate && B(i,j)>2)
            B(i,j)=B(i,j)-1;
        end

        k=k+1;
    end
end

for i=2:V
    if sum(B(:,i))==0
        B(1,i)=d(i)-d(1);

        %shorten
        rand2 = randi([1,100]);
        if(rand2<=shortrate && B(i,j)>2)
            B(i,j)=B(i,j)-1;
        end
    end
end

for i=2:V-1
    if sum(B(i,:))==0
        B(i,V)=d(V)-d(i);

        %shorten
        rand2 = randi([1,100]);
        if(rand2>=shortrate && B(i,j)>2)
            B(i,j)=B(i,j)-1;
        end
    end
end
G=digraph(B);
%E=height(G.Edges);

%OrgTime = toc;
%disp("orginal time:");    
%disp(OrgTime);


%% add a, c, strabc, index to G
E=height(G.Edges);
for i=1:E
    %G.Edges.A(i)=G.Edges.Weight(i)-G.Edges.Weight(i)+1;
    G.Edges.A(i)=G.Edges.Weight(i)-1;
    G.Edges.B(i)=G.Edges.Weight(i);
    G.Edges.C(i)=randi([c_min,c_max]);
    G.Edges.strABC(i)=convertCharsToStrings([num2str(i),':[',num2str(G.Edges.A(i)),',',num2str(G.Edges.B(i)),'](',num2str(G.Edges.C(i)),')']);
    G.Edges.index(i)=i;
end
end