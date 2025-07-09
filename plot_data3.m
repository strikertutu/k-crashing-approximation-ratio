% data
x = linspace(Vs,Vt,(Vt-Vs)/step+1);
y = res1_mean(:,1);
x2 = x;
y2 = res1_mean(:,2);
% plotting
figure;
plot(x, y, '-o', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
hold on;
plot(x2, y2, '-s', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% legend
legend('LP', 'KD', 'Location', 'best');

% axis
title('Time used on different scalces');
xlabel('Number of nodes ');
ylabel('Time used(s)');
grid on;

% data
x = linspace(Vs,Vt,(Vt-Vs)/step+1);
y = res2_mean(:,1);
x2 = x;
y2 = res2_mean(:,2);
% plotting
figure;
plot(x, y, '-o', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
hold on;
plot(x2, y2, '-s', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% legend
legend('LP', 'KD', 'Location', 'best');

% axis
title('Time used on different scalces');
xlabel('Number of nodes ');
ylabel('Time used(s)');
grid on;

% data
x = linspace(Vs,Vt,(Vt-Vs)/step+1);
y = res1_median(:,1);
x2 = x;
y2 = res1_median(:,2);
% plotting
figure;
plot(x, y, '-o', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
hold on;
plot(x2, y2, '-s', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% legend
legend('LP', 'KD', 'Location', 'best');

% axis
title('Time used on different scalces');
xlabel('Number of nodes ');
ylabel('Time used(s)');
grid on;

% data
x = linspace(Vs,Vt,(Vt-Vs)/step+1);
y = res2_median(:,1);
x2 = x;
y2 = res2_median(:,2);
% plotting
figure;
plot(x, y, '-o', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'b');
hold on;
plot(x2, y2, '-s', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'r');

% legend
legend('LP', 'KD', 'Location', 'best');

% axis
title('Time used on different scalces');
xlabel('Number of nodes ');
ylabel('Time used(s)');
grid on;