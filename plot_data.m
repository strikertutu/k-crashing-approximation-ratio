data=xlsread('k2_v10_10000.xlsx'); 
[F, X] = ecdf(data); % 计算累积分布函数值和对应的X值
figure;
plot(X, F, 'LineWidth', 2); % 绘制累积概率图
xlim([1 1.2])
xlabel('Approximation Ratio');
ylabel('Cumulative Distribution');

data2=xlsread('k10_v10_10000.xlsx'); 
[F2, X2] = ecdf(data2); % 计算累积分布函数值和对应的X值
figure;
plot(X2, F2, 'LineWidth', 2); % 绘制累积概率图
xlim([1 1.2])
xlabel('Approximation Ratio');
ylabel('Cumulative Distribution');

data3=xlsread(['k30_v10_10000.xlsx']); 
[F3, X3] = ecdf(data3); % 计算累积分布函数值和对应的X值
figure;
plot(X3, F3, 'LineWidth', 2); % 绘制累积概率图
xlim([1 1.2])
xlabel('Approximation Ratio');
ylabel('Cumulative Distribution');