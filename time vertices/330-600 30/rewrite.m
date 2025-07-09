Vt = 590;
Vs = 50;
step = 60;

for j = 1:(Vt-Vs)/step+1
    i = (Vt-Vs)/step+1-j+1;
    load('times.mat')
    res2_mean(i,1) = mean(times2(i,:,1));
    res2_mean(i,2) = mean(times2(i,:,2));
    writematrix(res2_mean, 'res2_mean.xlsx');
end