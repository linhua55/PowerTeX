clc; clear;

% 系统参数
i_ref = 0; % 电流参考值
V_DC = 1200; % 直流电压
V_s = 400; % 直流反电势
Ts = 1e-5; % 采样时间
R = (5+0.88)*1e-3; % 直流电阻

% 控制器参数
kp = 0.138;
ki = 1.176;

open('Exp3_1_SimModel');

%% 初始化阶段 0-1s
set_param('Exp3_1_SimModel','SaveFinalState','on', ...
    'LoadInitialState','off', ...
    'FinalStateName','xFinal_0', ...
    'SaveCompleteFinalSimState','on',...
    'StartTime','0','StopTime','1');

sim('Exp3_1_SimModel');
I_rslt = I_load;

%% 第1阶段 1s时刻更改i_ref值 1-1.5s
% 更新系统参数
i_ref = 1000;

set_param('Exp3_1_SimModel',...
    'StartTime','1','StopTime','1.5',...
    'LoadInitialState','on',...
    'InitialState','xFinal_0',...
    'FinalStateName','xFinal_1');

sim('Exp3_1_SimModel');
I_rslt = [I_rslt;I_load];