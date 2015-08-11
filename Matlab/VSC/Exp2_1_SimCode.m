clc; clear;

% 系统参数
m = 0.68; % 调制参数
V_DC = 1200; % 直流电压
V_s = 400; % 直流反电势
Ts = 1e-5; % 采样时间
R = 5e-3; % 直流电阻

open('Exp2_1_SimModel');

% 初始化进入稳态阶段 0-1.2s
set_param('Exp2_1_SimModel','SaveFinalState','on', ...
    'LoadInitialState','off', ...
    'FinalStateName','xFinal_0', ...
    'SaveCompleteFinalSimState','on',...
    'StartTime','0','StopTime','1.2');

sim('Exp2_1_SimModel');
I_rslt = I_load;

%% 第1阶段 1.2s时刻更改m值 1.2-1.7s
% 更新系统参数
m = 0.685;

set_param('Exp2_1_SimModel',...
    'StartTime','1.2','StopTime','1.7',...
    'LoadInitialState','on',...
    'InitialState','xFinal_0',...
    'FinalStateName','xFinal_1');

sim('Exp2_1_SimModel');
I_rslt = [I_rslt;I_load];

%% 第2阶段 1.7s时刻更改V_s值 等效更改m值 1.7-2.5s
m = 0.68 - 0.025;

set_param('Exp2_1_SimModel',...
    'StartTime','1.7','StopTime','2.5',...
    'LoadInitialState','on',...
    'InitialState','xFinal_1',...
    'FinalStateName','xFinal_2');

sim('Exp2_1_SimModel');
I_rslt = [I_rslt;I_load];

%% 第3阶段 2.5s时刻更改V_DC值 2.5-3s
V_DC = 1210;

set_param('Exp2_1_SimModel',...
    'StartTime','2.5','StopTime','3',...
    'LoadInitialState','on',...
    'InitialState','xFinal_2',...
    'FinalStateName','xFinal_3');

sim('Exp2_1_SimModel');
I_rslt = [I_rslt;I_load];