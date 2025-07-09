Vt = 590;
Vs = 50;
step = 60;
font_size = 20;

% data
res1_mean = xlsread("res1_mean.xlsx");
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
legend('Linear Programming', 'Algorithm KD', 'Location', 'best');

% axis
%title('Time used on different scalces');
xlabel('Number of nodes ');
ylabel('Time used(s)');
set(gca, 'FontSize', font_size); 
set(gca, 'FontName', 'Times New Roman');
grid on;

% data
res2_mean = xlsread("res2_mean.xlsx");
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
legend('Linear Programming', 'Algorithm KD', 'Location', 'best');

% axis
%title('Time used on different scalces');
xlabel('Number of nodes ');
ylabel('Time used(s)');
set(gca, 'FontSize', font_size); 
set(gca, 'FontName', 'Times New Roman');
grid on;

% data
res1_median = xlsread("res1_median.xlsx");
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
legend('Linear Programming', 'Algorithm KD', 'Location', 'best');

% axis
%title('Time used on different scalces');
xlabel('Number of nodes ');
ylabel('Time used(s)');
set(gca, 'FontSize', font_size); 
set(gca, 'FontName', 'Times New Roman');
grid on;

% data
res2_median = xlsread("res2_median.xlsx");
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
legend('Linear Programming', 'Algorithm KD', 'Location', 'best');

% axis
%title('Time used on different scalces');
xlabel('Number of nodes ');
ylabel('Time used(s)');
set(gca, 'FontSize', font_size); 
set(gca, 'FontName', 'Times New Roman');
grid on;