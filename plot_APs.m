clc
close all 
clear 
%% AP without drugs 

load mask.mat

%% Import output 
list = dir('ORm_Output');
list(1)=[];
list(1)=[];

%% Separating the models 

for index=1:4
    M1(index) =load(['ORm_Output\',list(index).name]);
end
%%
for index=9:12
    M2(index) =load(['ORm_Output\',list(index).name]);
end
%%
for index=13:16
    M3(index) =load(['ORm_Output\',list(index).name]);
end
for index=17:20
    M4(index) =load(['ORm_Output\',list(index).name]);
end
for index=21:24
    M5(index) =load(['ORm_Output\',list(index).name]);
end
for index=25:28
    M6(index) =load(['ORm_Output\',list(index).name]);
end
for index=29:32
    M7(index) =load(['ORm_Output\',list(index).name]);
end
for index=33:36
    M8(index) =load(['ORm_Output\',list(index).name]);
end
for index=37:40
    M9(index) =load(['ORm_Output\',list(index).name]);
end

%%
BCL = 800;  %BCL in ms 
Nstim=500;  %Number of stimulus
cont=0;
settings.minIsqIni=Nstim*BCL/(1000*60);
settings.BCL=BCL;
[t,y,currents]=main2019_ORd_MMChA(gAmps(1,:),settings,[],[],1);
%% PLOT DIFFERENT MODELS
title_name={'Model 1','Model 2','Model 3','Model 4','Moel 5',...
            'Model 6','Model 7','Model 8','Model 9','Moel 10'};

plot(M1(1).t,M1(1).y(:,1),LineWidth=1)
title("Model 1")
grid on 
hold on 
box on 
plot(M1(1).t,M1(2).y(:,1),LineWidth=1)
plot(M1(1).t,M1(3).y(:,1),LineWidth=1)
plot(M1(1).t,M1(4).y(:,1),LineWidth=1)
plot(t,y(:,1),LineWidth=1)
legend('1','2','10','100','Normal');
