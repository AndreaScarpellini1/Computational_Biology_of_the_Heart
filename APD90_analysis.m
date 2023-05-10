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
    APD_90(i,:)=measure_apd90(M_list(i),1);
    saveas(figure(i), ['Plots_90/',[list(i).name],'.jpg'])
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
close all 
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
titles=['ctrl','100','10','1','2'];
for  i=1:1:5
    subplot(1,4,i)
    for j=i:5:length(M_list)
        disp(M_list(i).name)
    end 
end 