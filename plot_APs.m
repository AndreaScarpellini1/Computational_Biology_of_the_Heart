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
for index=1:5
    M10(index) =load(['ORm_Output\',list(index).name]);
end

for index=6:10
    M1(index-5) =load(['ORm_Output\',list(index).name]);
end

for index=11:15
    M2(index-10) =load(['ORm_Output\',list(index).name]);
end
for index=16:20
    M3(index-15) =load(['ORm_Output\',list(index).name]);
end
for index=21:25
    M4(index-20) =load(['ORm_Output\',list(index).name]);
end
for index=26:30
    M5(index-25) =load(['ORm_Output\',list(index).name]);
end
for index=31:35
    M6(index-30) =load(['ORm_Output\',list(index).name]);
end
for index=36:40
    M7(index-35) =load(['ORm_Output\',list(index).name]);
end
for index=41:45
    M8(index-40) =load(['ORm_Output\',list(index).name]);
end
for index=46:50
    M9(index-45) =load(['ORm_Output\',list(index).name]);
end

%% PLOT NO DRUG ACTION POTENTIALS 
M_list={M1,M2,M3,M4,M5,M6,M7,M8,M9,M10};
for  i=1:1:10

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
