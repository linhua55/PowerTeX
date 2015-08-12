% 异步电机定子电动势和气隙磁通计算

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

% 定子绕组参数
N_s = 125; % 定子绕组匝数
k_N_s = 0.92; % 定子绕组基波系数

% 忽略定子漏阻抗
E_g_1 = U_N;
Phi_m_1 = E_g_1/(4.44*f_N*N_s*k_N_s); 

% 考虑定子漏阻抗 空载
E_g_2 = Z_m/(Z_s+Z_m) * U_N;
E_g_2_mag = abs(E_g_2);
Phi_m_2 = E_g_2_mag/(4.44*f_N*N_s*k_N_s); 

% 考虑定子漏阻抗 额定负载
E_g_3 = (Z_rm)/(Z_s+Z_rm) * U_N;
E_g_3_mag = abs(E_g_3);
Phi_m_3 = E_g_3_mag/(4.44*f_N*N_s*k_N_s); 