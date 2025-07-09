function G=read_graph(filename)
T=readtable(strcat('data/',filename,'.txt'));
T=table([T.EndNodes_1 T.EndNodes_2],T.Weight,T.A,T.B,T.C,...
    string(T.strABC),T.index,'VariableNames',...
    {'EndNodes','Weight','A','B','C','strABC','index'});
G=digraph(T);
end
