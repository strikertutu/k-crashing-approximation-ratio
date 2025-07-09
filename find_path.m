function [all_paths,all_edgepaths,all_path_lengths,max_path_length,isCP]=find_path(G)
%% find s,t
[s,t]=find_st(G);
%% find all path and its length
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
max_path_length=max(all_path_lengths);
%% create is-critical-path mark
isCP=zeros(length(all_paths),1);
isCP(max_path_length==all_path_lengths)=1;
end