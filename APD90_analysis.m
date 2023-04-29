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

for j= 2:1:5        %for every dose
    for i =1:1:10   %for every subject


    end 
end 

%% Checking the second condition 
% The second condition regards the abnormal repolarization of the AP for
% every subject and for every dose. Do check this we perform a visual
% inspection. 

s_name={'Sub 1','Sub 2','Sub 3','Sub 4','Sub 5','Sub 6','Sub 7','Sub 8','Sub 9','Sub 10'};
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


%% Checking the third condition 

% The third condition regards the abnormal prolongation of the third AP of 
% each subject and dose regarding the control 
% 

 s=5;
 j=1;
 q=0;
 p=1;
 listi=[];
 probability=[];
 for i=1:1:10
     for k= 1:1:5
         if ((APD_90(k+q.*5,3) - APD_90(s.*i,3))>0.25*APD_90(s.*i,3))
             listi(j,1)=APD_90(k+q*5,3);
              probability(p,1)=1;
             j=j+1;
         else
             probability(p,1)=0;
         end
         p=p+1;
     end
     q=q+1;
 end
 
 dose1=0;
 dose2=0;
 dose3=0;
 dose4=0;
 
 for i=1:5:50
 dose1= dose1 + probability(i,1);
 end
  for i=2:5:50
 dose2= dose2 + probability(i,1);
  end
  for i=3:5:50
 dose3= dose3 + probability(i,1);
  end
  for i=4:5:50
 dose4= dose4 + probability(i,1);
  end
 
fprintf('\n pro-arrhythmic behavior probabilty for dose1 is %d \n',(dose1./10).*100)
fprintf('\n pro-arrhythmic behavior probabilty for dose2 is %d \n',(dose2./10).*100)
fprintf('\n pro-arrhythmic behavior probabilty for dose3 is %d \n',(dose3./10).*100)
fprintf('\n pro-arrhythmic behavior probabilty for dose4 is %d \n',(dose4./10).*100)
         
%  for j= 2:1:5        %for every dose
%     for i =1:1:10   %for every subject
% 
% APD_90(i,3)
%     end 
% end 
%  
 
 
%  %% BOXPLOTs
% APD_90_N=APD_90(5:5:length(M_list),:); % no drug
% APD_90_100xdose=APD_90(1:5:46,:); %100x dose 
% APD_90_10xdose =APD_90(2:5:47,:);
% APD_90_1Xdose = APD_90(3:5:48,:);
% APD_90_2xdose = APD_90(4:5:49,:);
% 
% APD_list={APD_90_N,...
%           APD_90_1Xdose,...
%           APD_90_2xdose,...
%           APD_90_10xdose,...
%           APD_90_100xdose};
% 
% titles={'APD 90 - No Drug',...
%         'APD 90 - 1x dose',...
%         'APD 90 - 2x Drug',...
%         'APD 90 - 10x dose',...
%         'APD 90 - 100x dose'};
% 
% %Taking the third AP
% figure()
% for i=1:1:5
%     subplot(1,5,i)
%     boxplot(APD_list{i}(:,3))
%     title(titles{i})
%     grid on 
%     box  on 
%     linkaxes
% end 
% %% Mean and std APD 90
% figure()
% bar([ mean(APD_list{1,1}(:,3)), ...
%       mean(APD_list{1,2}(:,3)), ...
%       mean(APD_list{1,3}(:,3)) ...
%       mean(APD_list{1,4}(:,3)) ...
%       mean(APD_list{1,5}(:,3))]);
% 
% title("Mean & std ADP90")
% hold on 
% grid on 
% box on 
% bar([std(APD_list{1,1}(:,3)), ...
%       std(APD_list{1,2}(:,3)), ...
%       std(APD_list{1,3}(:,3)) ...
%       std(APD_list{1,4}(:,3)) ...
%       std(APD_list{1,5}(:,3))]);
% set(gca,'xtick',1:5,'xticklabel',{'N','1x','2x','10x','100x'})
% legend("Mean","std",'Location','northwest');
% 
% 
% %% Differences whithin the single subject 
% fprintf('\n_________________________________________________________\n')
% fprintf('\n Differences whithin the single subject & arrythmic risk \n')
% dose={'1x','2x','10x','100x'};
% for j= 2:1:5 %for every dose
%     for i =1:1:10   %for every subject
% 
%         res1 = abs(APD_list{1,j}(i,1)-APD_list{1,j}(i,2))/abs(APD_list{1,j}(i,1))*100;
%         res2 = abs(APD_list{1,j}(i,2)-APD_list{1,j}(i,3))/abs(APD_list{1,j}(i,2))*100;
% 
%         fprintf('\nFor subject %g, and dose %s:, \n', [i,dose{j-1}])
%         fprintf('AP1-AP2: %4.3f%%, AP2-AP3:%4.3f%%  \n', [res1,res2]);
%         
%         %check the thershold
%         if((res1>25 || res1==25) || (res2>25 || res2==25))
%             m(j-1,i)=1;
%         else  
%             m(j-1,i)=0;
%         end 
%     end 
%      %Write the arrythmic risk ratio 
%         fprintf(['\nThe arrythmic risk ratio is %4.2f' ...
%                  '\n================================='],...
%             sum(m(j-1,:)==1)/length(m(j-1,:)))
% end 
% %%
