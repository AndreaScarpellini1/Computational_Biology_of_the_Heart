clc
close all 
clear 
%% AP without drugs 
load mask.mat
%% Import output 
list = dir('ORm_Output');
list(1)=[];
list(1)=[];

for i=1:50
    M_list(i)=load(['ORm_Output\',list(i).name]);
end
for i=1:50  
    M_list(i).('name')=list(i).name;
end
%% PLOT NO DRUG ACTION POTENTIALS 
for  i=5:5:50
    plot(M_list(i).t,M_list(i).y(:,1))
    hold on
    grid on 
    box  on 
    title("no drug influenced APs")
end 

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
