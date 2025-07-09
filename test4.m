if(size(abnormal1))
    writematrix(abnormal1(3,:), 'abnormal1.xlsx');
    disp(max(abnormal1(3,:)))
    [F, X] = ecdf(abnormal1(3,:)); % 计算累积分布函数值和对应的X值
     
    figure;
    plot(X, F, 'LineWidth', 2); % 绘制累积概率图
    xlabel('Approximation Ratio');
    ylabel('Cumulative Distribution');
end