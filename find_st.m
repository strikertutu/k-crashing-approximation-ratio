function [s,t]=find_st(G)
V=height(G.Nodes);
s=zeros(1,V);
t=zeros(1,V);
B=full(adjacency(G,'weighted'));
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
end