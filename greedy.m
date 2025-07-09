%% greedy algorithm
function [mf,G_new,cut_s,cut_t]=greedy(G)
E=height(G.Edges);
%% find all path and its length
[all_paths,all_edgepaths,~,~,isCP]=find_path(G);
%% create on-critical-path mark
onCP=zeros(E,1);
for i=1:length(all_paths)
    if isCP(i)==1
        onCP(cell2mat(all_edgepaths(i)))=1;
    end
end
%% create graph that only contains L path
G_L=digraph();
G_L=addedge(G_L, G.Edges(find(1==onCP),:));
%% calculate maxflow and find mincut
% find st
[s,t]=find_st(G);
% use C as weight
G_L.Edges.Weight=G_L.Edges.C;
for i=1:height(G_L.Edges.Weight)
    if G_L.Edges.A(i)==G_L.Edges.B(i)
        G_L.Edges.Weight(i)=inf;
    end
end
% add supper s,t
G_s=G_L;
for i=1:length(s)
    G_s = addedge(G_s,1+height(G_L.Nodes),s(i),inf);
end
for i=1:length(t)
    G_s = addedge(G_s,t(i),2+height(G_L.Nodes),inf);
end
% calculate maxflow
[mf,~,cs,ct] = maxflow(G_s,1+height(G_L.Nodes),2+height(G_L.Nodes));
% find mincut
C_s=full(adjacency(G_s,'weighted'));
cut_s=[];
cut_t=[];
for i=1:length(cs)
    for j=1:length(ct)
        if C_s(cs(i),ct(j))>0
            cut_s=[cut_s;cs(i)];
            cut_t=[cut_t;ct(j)];
        end
    end
end
%% update a,c
G_new=G;
for i=1:length(cut_s)
    for j=1:height(G.Edges)
        if sum([cut_s(i),cut_t(i)]==G.Edges.EndNodes(j,:))==2
            G_new.Edges.B(j)=G.Edges.B(j)-1;
            G_new.Edges.Weight(j)=G_new.Edges.B(j);
            tmp=convertStringsToChars(G_new.Edges.strABC(j));
            G_new.Edges.strABC(j)=strcat(convertCharsToStrings(tmp(tmp=='　')),num2str(j),':[',string(G_new.Edges.A(j)),',',string(G_new.Edges.B(j)),'](',string(G_new.Edges.C(j)),')');
            if G_new.Edges.B(j)==G_new.Edges.A(j)
                G_new.Edges.C(j)=inf;
            end
            break;
        end
    end
end
end