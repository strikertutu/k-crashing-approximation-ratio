function fig=print_greedy(G,cut_s,cut_t,fn)
%% plot greedy
fig=figure(fn);
[s,t]=find_st(G);
[all_paths,~,~,~,isCP]=find_path(G);
H=plot(G,'Layout','force','EdgeLabel',G.Edges.strABC);
box off
set(gca,'Visible','off')
set(gcf,'color','w');
highlight(H,s,'NodeColor','red')
highlight(H,t,'NodeColor','green')
for i=1:length(isCP)
    if isCP(i)==1
        highlight(H,cell2mat(all_paths(i)),'LineWidth',2);
    end
end
for i=1:length(cut_s)
    highlight(H,[cut_s(i),cut_t(i)],'EdgeColor','r','LineWidth',2);
end
end
