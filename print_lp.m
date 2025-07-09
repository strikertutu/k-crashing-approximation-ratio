function fig=print_lp(G,x,fn)
squeeze_edge=G.Edges.Weight-x;
[s,t]=find_st(G);
fig=figure(fn);
H=plot(G,'Layout','force','EdgeLabel',G.Edges.strABC);
box off
set(gca,'Visible','off')
set(gcf,'color','w');
highlight(H,s,'NodeColor','red')
highlight(H,t,'NodeColor','green')
for i=1:length(squeeze_edge)
    if squeeze_edge(i)==1
        highlight(H,G.Edges.EndNodes(i,1),G.Edges.EndNodes(i,2),'EdgeColor','g','LineWidth',2);
    elseif squeeze_edge(i)==2
        highlight(H,G.Edges.EndNodes(i,1),G.Edges.EndNodes(i,2),'EdgeColor','y','LineWidth',2);
    end
end
end