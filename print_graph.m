function fig=print_graph(G,hcp,fn)
%% find st
[s,t]=find_st(G);
%% find path
[all_paths,~,~,max_path_length,isCP]=find_path(G);
%% print graph with critical path
fig=figure(fn);
H=plot(G,'Layout','force','EdgeLabel',G.Edges.strABC);
box off
set(gca,'Visible','off')
set(gcf,'color','w');
highlight(H,s,'NodeColor','red')
highlight(H,t,'NodeColor','green')
if hcp>=1
    for i=1:length(isCP)
        if isCP(i)==1
            highlight(H,cell2mat(all_paths(i)),'LineWidth',2);
        end
    end
end
