clc
clear 
close all
%% Import Data 
list = dir('ORm_Output');
list(1)=[];
list(1)=[];

for i=1:length(list)
    M_list(i)=load(['ORm_Output/',list(i).name]);
end
for i=1:length(list)  
    M_list(i).('name')=list(i).name;
end
%% measurement of APD 90
for i =1:1:length(M_list)
    APD_90(i,:)=measure_apd90(M_list(i),0);
    %saveas(figure(i), ['Plots_90/',[list(i).name],'.jpg'])
end
close all
%% Cheking the first condition 
% Which is the difference in the alternance of the 3 APs for each subject
% and for every dose.
dose={'ctrl','100','10','1','2'};
for j= 2:1:5             
    flag=0;
    for i =0:5:45  
        if( abs(APD_90(i+j,1)-APD_90(i+j,2))>10 || ...
            abs(APD_90(i+j,2)-APD_90(i+j,3))>10 )
            flag=flag+1;
            disp(flag)
        end 
    end 
    fprintf('\n Pro-arrhythmic behavior probabilty - dose %s is: %4.2f%%, \n', [dose{j}],(flag/10)*100);
end 
%% Checking the second condition 
% The second condition regards the abnormal repolarization of the AP for
% every subject and for every dose. Do check this we perform a visual
% inspection. 
s_name={'Sub 10','Sub 1','Sub 2','Sub 3','Sub 4','Sub 5','Sub 6','Sub 7','Sub 8','Sub 9'};
index=0;
for i=1:5:46 
    index=index+1;
    figure(index)
    for j=0:1:4
        plot(M_list(i+j).t,M_list(i+j).y(:,1));
        hold on 
        grid on 
        title([s_name(index)])
        xlim([0,max(M_list(i+j).t)])
        ylim([min(M_list(i+j).y(:,1)),50])
    end
    legend("100x","10x","1x","2x","N")
 end 
 %it seems we have no abnormal repolarizatino within the subjects
%close all 
%% Checking the third condition 

% The third condition regards the abnormal prolongation of the third AP of 
% each subject and dose regarding the control 
% -------------------------------------------------------------------------

risk=[];
arr_indexes=[];
for j= 2:1:5        %for every dose skipping the control  
    flag=0;
    for i =0:5:45  
        if (abs(APD_90(j+i,3)-APD_90(i+1,3))>0.25*APD_90(i+1,3))
            flag=flag+1;
            arr_indexes=[arr_indexes i+j];
        end 
    end 
    fprintf('\n Pro-arrhythmic behavior probabilty - dose %s is: %4.2f%%, \n', [dose{j}],(flag/10)*100);
    risk(j)=(flag/10)*100; %saving the risk 
end 

%% plot boxplot 
names={'ctrl','100x','10x','1x','2x'};
positions=[1 2 3 4 5];

figure('Name','Box1')
subplot(1,2,1)
ax=gca;
for  i=1:1:5
    boxplot(APD_90(i:5:length(M_list),3),'Positions',positions(i),'Widths',0.5)
    hold on
end
xticks(ax, positions);
xticklabels(ax, names);
grid on 
ylabel("Time [ms]")
xlabel("Doses")
box on 
linkaxes 
title("APD 90 -  All subjects distributions")

subplot(1,2,2)
data=APD_90;
data(arr_indexes,:)=NaN;
ax=gca;
for  i=1:1:5
    boxplot(data(i:5:length(M_list),3),'Positions',positions(i),'Widths',0.5)
    hold on
end
xticks(ax, positions);
xticklabels(ax, names);
grid on 
ylabel("Time [ms]")
xlabel("Doses")
box on 
linkaxes 
title("APD 90 -  Non Arrhythmic subjects distributions")

%% Mean and standard deviation 
names={'ctrl','100x','10x','1x','2x'};
positions=[1 2 3 4 5];

figure('Name','ErrorBars')
subplot(1,2,1)
ax=gca;
for  i=1:1:5
    x = positions(i);
    y = APD_90(i:5:length(M_list),3);
    errorbar(x, mean(y), std(y), 'o', 'LineWidth', 1.5, 'MarkerSize', 8, 'CapSize', 10);
    hold on
end
xticks(ax, positions);
xticklabels(ax, names);
grid on 
ylabel("Time [ms]")
xlabel("Doses")
box on 
title("APD 90 -  All subjects distributions")

subplot(1,2,2)
ax=gca;
for  i=1:1:5
    x = positions(i);
    y = data(i:5:length(M_list),3);
    errorbar(x, mean(y), std(y), 'o', 'LineWidth', 1.5, 'MarkerSize', 8, 'CapSize', 10);
    hold on
end
xticks(ax, positions);
xticklabels(ax, names);
grid on 
ylabel("Time [ms]")
xlabel("Doses")
box on 
linkaxes 
title("APD 90 -  Non Arrhythmic subjects distributions")
%%
names={'ctrl','100x','10x','1x','2x'};
positions=[1 2 3 4 5];

figure('Name','BarPlot')
subplot(1,2,1)
ax=gca;
for  i=1:1:5
    x = positions(i);
    y = APD_90(i:5:length(M_list),3);
    bar(x, mean(y), 0.8, 'LineWidth', 1.5, 'FaceColor', 'w', 'EdgeColor', 'k')
    hold on
    errorbar(x, mean(y), std(y), 'k', 'LineWidth', 1.5, 'CapSize', 10);
end
xticks(ax, positions);
xticklabels(ax, names);
grid on 
ylabel("Time [ms]")
xlabel("Doses")
box on 
linkaxes 
title("APD 90 -  All subjects distributions")

subplot(1,2,2)
data=APD_90;
data(arr_indexes,:)=NaN;
ax=gca;
for  i=1:1:5
    x = positions(i);
    y = data(i:5:length(M_list),3);
    bar(x, mean(y(~isnan(y))), 0.8, 'LineWidth', 1.5, 'FaceColor', 'w', 'EdgeColor', 'k')
    hold on
    errorbar(x, mean(y(~isnan(y))), std(y(~isnan(y))), 'k', 'LineWidth', 1.5, 'CapSize', 10);
end
xticks(ax, positions);
xticklabels(ax, names);
grid on 
ylabel("Time [ms]")
xlabel("Doses")
box on 
linkaxes 
title("APD 90 -  Non Arrhythmic subjects distributions")


%%
for i=1:1:5
disp(M_list(i).name)
disp(mean(data(i:5:length(M_list),3)))
end