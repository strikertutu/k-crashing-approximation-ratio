function criticalEdges = findCriticalEdges(G)
    n = numnodes(G);
    earliest = zeros(n, 1);

    order = toposort(G);
    for u = order
        succ = successors(G, u);
        for v = succ'
            edge_idx = findedge(G, u, v);
            weight = G.Edges.Weight(edge_idx);
            if earliest(v) < earliest(u) + weight
                earliest(v) = earliest(u) + weight;
            end
        end
    end
    

    latest = repmat(max(earliest), n, 1);
    

    for u = order(end:-1:1)
        preds = predecessors(G, u);
        for v = preds'
            edge_idx = findedge(G, v, u);
            weight = G.Edges.Weight(edge_idx);
            if latest(v) > latest(u) - weight
                latest(v) = latest(u) - weight;
            end
        end
    end
    

    criticalEdges = zeros(numedges(G), 1);
    
    % check if critical
    for k = 1:numedges(G)
        u = G.Edges.EndNodes(k, 1);
        v = G.Edges.EndNodes(k, 2);
        weight = G.Edges.Weight(k);
        
        if (earliest(u) + weight == earliest(v)) && (latest(u) + weight == latest(v))
            criticalEdges(k) = 1;
        end
    end
end