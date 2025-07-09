% data
x = linspace(Es,Et,(Et-Es)/step+1);
y = res1(:,1);
x2 = x;
y2 = res1(:,2);
% plotting
figure;
plot(x, y, '-o', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
hold on;
plot(x2, y2, '-s', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% legend
legend('LP', 'KD', 'Location', 'best');

% axis
title('Time used on different scalces');
xlabel('Number of edges ');
ylabel('Time used(s)');
grid on;

% data
x = linspace(Es,Et,(Et-Es)/step+1);
y = res2(:,1);
x2 = x;
y2 = res2(:,2);
% plotting
figure;
plot(x, y, '-o', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
hold on;
plot(x2, y2, '-s', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% legend
legend('LP', 'KD', 'Location', 'best');

% axis
title('Time used on different scalces');
xlabel('Number of edges ');
ylabel('Time used(s)');
grid on;