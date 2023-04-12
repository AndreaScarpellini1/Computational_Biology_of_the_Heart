%
% population driver for ORd model to create stable population and
% keep conductances, biomarkers and state variables
%
%%
clear all;
clc;
close all;

%% Fixed values 
BCL = 800;  %BCL in ms 
Nstim=500;  %Number of stimulus

%% Uploading the gAmps and the drug effects 

%gAmps = [ICaL ITo INaCa IK1 IKr IKs INaf INaL INaK];
%gAmps = random('unif',0.70,1.30,[1000,9]);
%save('gAmps.mat','gAmps','-v7.3');

%gAmps matrix [10 different models X 9 different ionic chanels]
load mask.mat

ngAmps = length(gAmps(1,:));   % ngAmps = 9
nsamples = length(gAmps(:,1)); % nsamples = 10

%% Ritonavir --> modifies the following channels:
%Gna
%GNaL
%GKr
%GCaL
%Ritonavir Terapeutic value 
EFTPC= 0.4369; %[μM]
name_models={'M_1','M_2','M_3','M_4','M_5','M_6','M_7','M_8','M_9','M_10'};

cont=0;
settings.minIsqIni=Nstim*BCL/(1000*60);
settings.BCL=BCL;
for  i =1:1:10
    [t,y,currents]=main2019_ORd_MMChA(gAmps(i,:),settings,[],[],1);
    save(['ORm_Output/',name_models{i},'_without_drug'],'t','y','currents');
end 
%%
moltiplicative_coeffiecients=[1.0, 2.0, 10, 100];
name_molt_coeff={'1','2','10','100'};
index=0;

for k =moltiplicative_coeffiecients
    index=index+1;
    %Concentration= k * terapeutic value 
    IC= k* EFTPC;
    
    %Blocking factor for Na, NaL, Kr, CaL
    BFNa=1.0/(1+(IC/27.96163));
    BFNaL=1.0/(1+(IC/7.175)^0.7);
    BFKr=1.0/(1+(IC/5.157));
    BFCaL=1.0/(1+(IC/8.228)^1.3);
    
   
    for ii=1:nsamples
        %Changing the value of the gAmps according to the drug effect. 
        gAmps_Drug=gAmps(ii,:);
        gAmps_Drug(7)=gAmps_Drug(7)*BFNa;  %Na
        gAmps_Drug(8)=gAmps_Drug(7)*BFNaL; %NaL
        gAmps_Drug(5)=gAmps_Drug(5)*BFKr;  %Kr
        gAmps_Drug(1)=gAmps_Drug(1)*BFCaL; %CaL

        %function ---------------------------------------------------------
        tstart=tic;
        cont=0;
        settings.minIsqIni=Nstim*BCL/(1000*60);
        settings.BCL=BCL;
        [t,y,currents]=main2019_ORd_MMChA(gAmps_Drug,settings,[],[],1);
        %t --> time, resolution of 24003
        %y(1) --> transmembrane potential 
        %------------------------------------------------------------------
        
        %Saving
        save(['ORm_Output/',name_models{ii},'_',name_molt_coeff{index},'xEFTPC.mat'],'t','y','currents');
        fprintf([name_models{ii},'of coeff ',name_molt_coeff{index},' completed!']);
        telapsed = toc(tstart);
        fprintf('-Execution time: %f\n',telapsed);
        fprintf('############################################################\n')
    end
end 
