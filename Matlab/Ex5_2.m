% 异步电机降压调速计算

clc; clear;

% 异步电机参数 注意转子侧参数为折算到定子侧之后的参数
U_N  = 380;   % 额定电压 
n_N  = 960;   % 额定转速
f_N  = 50;    % 额定频率
R_s  = 0.35;  % 定子电阻
L_ls = 0.006; % 定子漏感
R_r  = 0.5;   % 转子电阻
L_lr = 0.007; % 转子漏感
L_m  = 0.26;  % 定转子互感

% 根据额定转速求极对数和同步转速
omega_1 = 2*pi*f_N; % 额定角频率
p = floor(60*f_N/n_N); % 极对数
n_1 = 60*f_N/p; % 同步转速

s_N = (n_1-n_N)/n_1; % 额定转差率

% 电机阻抗参数
X_ls = omega_1 * L_ls; % 定子漏抗 
Z_s = R_s + 1i*X_ls; % 定子阻抗
X_lr = omega_1 * L_lr; % 转子漏抗
Z_r = R_r/s_N + 1i*X_lr; % 转子阻抗
X_m = omega_1 * L_m;     % 互感电抗
Z_m = 1i*X_m; % 互感阻抗
Z_rm = (Z_r * Z_m)/(Z_r + Z_m); % 转子与互感并联后阻抗
Z = Z_s + Z_rm; % 异步电机总阻抗

% U = (1/2)*U_N情况
U_1_2 = (1/2) * U_N;
U_2_3 = (2/3) * U_N;

% 临界转差率 临界转矩 (忽略励磁支路)
s_m = R_r / (sqrt(R_s^2 + omega_1^2*(L_ls+L_lr)^2)); % 临界转差率
T_em_1_2 = 3*p*U_1_2^2 / (2*omega_1*(R_s+sqrt(R_s^2+omega_1^2*(L_ls+L_lr)^2))); % 临界转矩
T_em_2_3 = 3*p*U_2_3^2 / (2*omega_1*(R_s+sqrt(R_s^2+omega_1^2*(L_ls+L_lr)^2))); % 临界转矩

% 机械特性曲线
s_tran = 0:0.001:1;
T_tran = 3*p*U_N^2*R_r.*s_tran ./ (omega_1*((s_tran*R_s+R_r).^2+s_tran.^2*omega_1^2*(L_ls+L_lr)^2));
T_tran_1_2 = 3*p*U_1_2^2*R_r.*s_tran ./ (omega_1*((s_tran*R_s+R_r).^2+s_tran.^2*omega_1^2*(L_ls+L_lr)^2));
T_tran_2_3 = 3*p*U_2_3^2*R_r.*s_tran ./ (omega_1*((s_tran*R_s+R_r).^2+s_tran.^2*omega_1^2*(L_ls+L_lr)^2));

hf1 = figure(1);
set(hf1,'Position',[50 50 400 250]);

h = plot(T_tran,1-s_tran,T_tran_1_2,1-s_tran,'r',T_tran_2_3,1-s_tran,'g');
set(gca,'FontSize',12); % 字号设置
set(gca,'FontName','Times New Roman'); % 字体设置
set(h,'LineWidth',2); % 线宽设置
xlabel('电磁转矩{\it T_e}(N·m)','FontSize',12,'FontName','Times New Roman');
set(gca,'YLim',[0,1.05]);
ylabel('转速{\it n}(p.u.)','FontSize',12,'FontName','Times New Roman');
l = legend('$U=U_N$','$U=\frac{1}{2}U_N$','$\it U=\frac{2}{3}U_N$'); % 图例设置
set(l,'Interpreter','latex','Location','Southeast'); % 图例位置+LaTeX
