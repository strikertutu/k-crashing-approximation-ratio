function res = findMaxPathLength(G,node1,node2)
    G.Edges.Weight = -G.Edges.Weight;
    [path,distance] = shortestpath(G,node1,node2);
    res = -distance;
end