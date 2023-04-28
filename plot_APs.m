clc
close all 
clear 

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
%% PLOT NO DRUG ACTION POTENTIALS 
figure(100)
for  i=5:5:50
    plot(M_list(i).t,M_list(i).y(:,1))
    hold on
    grid on 
    box  on 
    title("No Drug Influenced APs")
end 
saveas(figure(100), 'Plots/No_drug.jpg')
%%
s_name={'Sub 1','Sub 2','Sub 3','Sub 4','Sub 5','Sub 6','Sub 7','Sub 8','Sub 9','Sub 10'};
index=0;
for i=1:5:46 
    index=index+1;
    figure(index)
    for j=0:1:4
        plot(M_list(i+j).t,M_list(i+j).y(:,1),linewidth=1);
        hold on 
        grid on 
        title([s_name(index)])
    end
    legend("100x","10x","1x","2x","N")
    saveas(figure(index), ['Plots/',[s_name{index}],'.jpg'])
end 








