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

