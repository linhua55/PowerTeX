clc; clear;

% 系统参数
L = 690e-6;
R = 5e-3;
V_DC = 1200;
V_s = 400;
m = 0.68;
t_int = 0.01;

% 稳态初值
V_t = m * V_DC / 2;
i_0 = (V_t - V_s) / R;

% 第一阶段
t_1 = 0.2;
t = 0:t_int:t_1;
[t_12, y_12] = ode45(@(t,y) sphbc(t, y, L, m, V_DC, V_s, R), t, i_0);

t_rslt = t_12;
I_rslt = y_12;

% 第二阶段
m = 0.685;

t_2 = 0.7;
t = t_1:t_int:t_2;
[t_23, y_23] = ode45(@(t,y) sphbc(t, y, L, m, V_DC, V_s, R), t, y_12(end));

t_rslt = [t_rslt; t_23(2:end)];
I_rslt = [I_rslt; y_23(2:end)];

% 第三阶段
V_s = 415;

t_3 = 1.5;
t = t_2:t_int:t_3;
[t_34, y_34] = ode45(@(t,y) sphbc(t, y, L, m, V_DC, V_s, R), t, y_23(end));

t_rslt = [t_rslt; t_34(2:end)];
I_rslt = [I_rslt; y_34(2:end)];

% 第四阶段
V_DC = 605 * 2;

t_4 = 2;
t = t_3:t_int:t_4;
[t_45, y_45] = ode45(@(t,y) sphbc(t, y, L, m, V_DC, V_s, R), t, y_34(end));

t_rslt = [t_rslt; t_45(2:end)];
I_rslt = [I_rslt; y_45(2:end)];

hf1 = figure(1);
set(hf1,'Position',[50 50 400 250]);

h = plot(t_rslt, I_rslt);
set(gca,'FontSize',12); % 字号设置
set(gca,'FontName','Arial'); % 字体设置
set(h,'LineWidth',2); % 线宽设置
xlabel('时间{\it t}(s)','FontSize',12,'FontName','Times New Roman');
ylabel('电流{\it i}(A)','FontSize',12,'FontName','Times New Roman');