function save_graph(G,filename)
writetable(G.Edges,strcat('data/',filename,'.txt'));
end
