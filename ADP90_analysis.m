clc
clear 
close all
%% Import Data 
list = dir('ORm_Output');
list(1)=[];
list(1)=[];

for i=1:50
    M_list(i)=load(['ORm_Output\',list(i).name]);
end
for i=1:50  
    M_list(i).('name')=list(i).name;
end

%we eliminate the sub #1
M_list(6:1:10)=[];
%% measurement of ADP 90
for i =1:1:45
    ADP_90(i,:)=measure_adp90(M_list(i).y(:,1),0);
end
%% BOXPLOTs
ADP_90_N=ADP_90(5:5:45,:); % no drug
ADP_90_100xdose=ADP_90(1:5:41,:); %100x dose 
ADP_90_10xdose =ADP_90(2:5:42,:);
ADP_90_1Xdose = ADP_90(3:5:43,:);
ADP_90_2xdose = ADP_90(4:5:44,:);

ADP_list={ADP_90_N,...
          ADP_90_1Xdose,...
          ADP_90_2xdose,...
          ADP_90_10xdose,...
          ADP_90_100xdose};

titles={'ADP 90 - No Drug',...
        'ADP 90 - 1x dose',...
        'ADP 90 - 2x Drug',...
        'ADP 90 - 10x dose',...
        'ADP 90 - 100x dose'};
%% Boxplot ADP 90 
figure()
for i=1:1:5
    subplot(1,5,i)
    boxplot(ADP_list{i}(:,1))
    title(titles{i})
    grid on 
    box  on 
    linkaxes
end 
%% Mean and std ADP 90
figure()
plot([mean(ADP_list{1,1}(:,1)), ...
      mean(ADP_list{1,2}(:,1)), ...
      mean(ADP_list{1,3}(:,1)) ...
      mean(ADP_list{1,4}(:,1)) ...
      mean(ADP_list{1,5}(:,1))],'--x',linewidth=2);
title("Mean & std ADP90")
hold on 
grid on 
box on 
plot([std(ADP_list{1,1}(:,1)), ...
      std(ADP_list{1,2}(:,1)), ...
      std(ADP_list{1,3}(:,1)) ...
      std(ADP_list{1,4}(:,1)) ...
      std(ADP_list{1,5}(:,1))],'--o',linewidth=2);
set(gca,'xtick',1:5,'xticklabel',{'N','1x','2x','10x','100x'})
legend("Mean","std");

