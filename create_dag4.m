%% create a directed acyclic graph G with A,B,C
function G = create_dag4(V,b_min,b_max,c_min,c_max,Lr,L1r,patience)
%% create original graph
%tic;

B=zeros(V,V);
for k=1:V*4
    % randomly create i<j
    i=randi([1,V-1]);
    j=randi([i+1,V]);
    % connect i to j
    if B(i,j)==0
        % generate b
        B(i,j)=randi([b_min,b_max]);
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

%% find s,t
% tic;

s=zeros(1,V);
t=zeros(1,V);
for i=1:V
    if sum(B(:,i))==0 && sum(B(i,:))~=0
        s(i)=i;
    end
    if sum(B(i,:))==0 && sum(B(:,i))~=0
        t(i)=i;
    end
end
s(s==0)=[];
t(t==0)=[];

% STTime = toc;
% disp("ST time:");    
% disp(STTime);

%% find all path and its length
%tic;

all_paths={};
all_edgepaths={};
all_path_lengths=[];
for i=1:length(s)
    for j=1:length(t)
        [paths,edgepaths] = allpaths(G,s(i),t(j));
        all_paths=[all_paths;paths];
        all_edgepaths=[all_edgepaths;edgepaths];
        for k=1:size(edgepaths,1)
            path_length=sum(G.Edges.Weight(cell2mat(edgepaths(k))));
            all_path_lengths=[all_path_lengths;path_length];
        end
    end
end
%% find max path length
%disp(height(all_paths));
max_path_length=max(all_path_lengths);

%LengthTime = toc;
%disp("Length time:");    
%disp(LengthTime);

%% create A_lin
%tic;

A_lin=zeros(height(all_paths),E);
for i=1:height(all_paths)
    A_lin(i,cell2mat(all_edgepaths(i)))=1;
end
%% create b_lin
b_lin=max_path_length*ones(height(all_paths),1);
%% create Aeq, beq

Aeq=[];
beq=[];
for i=1:height(all_paths)
    if all_path_lengths(i)<max_path_length
        ri=randi(100);
        if ri<=Lr
            Aeq=[Aeq;A_lin(i,:)];
            beq=[beq;max_path_length];
        elseif ri<=L1r
            Aeq=[Aeq;A_lin(i,:)];
            beq=[beq;max_path_length-1];
        end
    else
        Aeq=[Aeq;A_lin(i,:)];
        beq=[beq;max_path_length];
    end
end
%CreateTime = toc;
%disp("Create time:");    
%disp(CreateTime);

%% slove x
%tic;

% f=ones(1,E);
f=randi(10,[1,E]);
lb=ones(E,1)*b_min;
intcon=1:E;
options=optimoptions('intlinprog','Display','off');
x = intlinprog(f,intcon,A_lin,b_lin,Aeq,beq,lb,[],[],options);

%SolveTime = toc;
%disp("Solve time:");    
%disp(SolveTime);
%% update graph.Weight
if ~isempty(x)
    G.Edges.Weight=x;
    % disp('Adjust Successed');
else
    % disp('Adjust Failed');
end
%% update all_path_length
for i=1:length(all_edgepaths)
    all_path_lengths(i)=sum(G.Edges.Weight(cell2mat(all_edgepaths(i))));
end
%% delete useless edge
%is_P_U=zeros(length(all_path_lengths),1); % is path usefull
%is_P_U(all_path_lengths==max_path_length)=1;
%is_P_U(all_path_lengths==max_path_length-1)=1;
%is_E_U=zeros(height(G.Edges),1); % is edge usefull
%all_usefull_edges=all_edgepaths(is_P_U==1);
%all_usefull_edges=all_edgepaths();
%for i=1:length(all_usefull_edges)
    %is_E_U(cell2mat(all_usefull_edges(i)))=1;
%end
%tmp=find(is_E_U==0);
%tmp=tmp';
%G=rmedge(G,tmp);
%% add a, c, strabc, index to G
E=height(G.Edges);
for i=1:E
    G.Edges.A(i)=randi(floor(G.Edges.Weight(i)/2));
    G.Edges.B(i)=G.Edges.Weight(i);
    G.Edges.C(i)=randi([c_min,c_max]);
    G.Edges.strABC(i)=convertCharsToStrings([num2str(i),':[',num2str(G.Edges.A(i)),',',num2str(G.Edges.B(i)),'](',num2str(G.Edges.C(i)),')']);
    G.Edges.index(i)=i;
end
end

