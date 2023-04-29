function t=measure_apd90(ap,o)
%The ADP90 is a measurement of the action potential duration at 90%
%repolarization.

%Input: ap.y
%       o :Option if you want to plot ==1
%Output: ADP90
    
    % Value and index of the max point
    [y1,t1]=max(ap.y(1:8001,1));
    [y2,t2]=max(ap.y(8002:16002,1));
    [y3,t3]=max(ap.y(16003:24003,1));
    
    M_indexes=[t1,t2+8001,t3+16002];
    M_values= [y1,y2,y3];

    % As V-rest I consider the first point of the AP 
    rest_pot=[ap.y(1,1),ap.y(8002,1),ap.y(16003,1)]; 
    
    % Theoretical values of the APD90 
    N_values=M_values-abs(M_values-rest_pot)*0.90;

    % The most similar value (msv) in the vector (*but is it higher or lower?)
    [y1,t1]=min(abs(ap.y(1:8001,1) - N_values(1)));
    [y2,t2]=min(abs(ap.y(8002:16002,1)- N_values(2)));
    [y3,t3]=min(abs(ap.y(16003:24003,1)- N_values(3)));

    %Find the index of the msv in the vector
    N_indexes=[t1,t2+8001,t3+16002];

    %Values of the difference  
    N_values=[y1,y2,y3];
    
    % Interval of time between the first time point and the msv  time point
   
    t=[abs(ap.t(1)-ap.t(N_indexes(1)));
       abs(ap.t(8002)-ap.t(N_indexes(2)));
       abs(ap.t(16003)-ap.t(N_indexes(3)))];

    
    if (o==1)
        figure()
        plot(ap.t,ap.y(:,1))
        title("ap.y(:,1) APD90")
        hold on 
        grid on

        plot(ap.t(M_indexes(1)),ap.y(M_indexes(1),1),'o',linewidth==1)
        plot(ap.t(M_indexes(2)),ap.y(M_indexes(2),1),'o',linewidth==1)
        plot(ap.t(M_indexes(3)),ap.y(M_indexes(3),1),'o',linewidth==1)
        plot(ap.t(N_indexes(1)),ap.y(N_indexes(1),1),'x',linewidth==2)
        plot(ap.t(N_indexes(2)),ap.y(N_indexes(2),1),'x',linewidth==2)
        plot(ap.t(N_indexes(3)),ap.y(N_indexes(3),1),'x',linewidth==2)
        plot(ap.t(1),    rest_pot(1),'x',linewidth==2)
        plot(ap.t(8002), rest_pot(2),'x',linewidth==2)
        plot(ap.t(16003),rest_pot(3),'x',linewidth==2)
        
        vline(ap.t(8002), 'k--'); 
        vline(ap.t(1), 'k--'); 
        vline(ap.t(16003), 'k--'); 
        vline(ap.t(N_indexes(1)), 'k--'); 
        vline(ap.t(N_indexes(2)), 'k--'); 
        vline(ap.t(N_indexes(3)), 'k--'); 
        ylim([min(ap.y(:,1)),max(ap.y(:,1))]);
        xlim([min(ap.t),max(ap.t)]);
        

        plot(M_indexes(1),M_values(1),'o',linewidth==1)
        plot(M_indexes(2),M_values(2),'o',linewidth==1)
        plot(M_indexes(3),M_values(3),'o',linewidth==1)
        plot(N_indexes(1),N_values(1),'o',linewidth==1)
        plot(N_indexes(2),N_values(2),'o',linewidth==1)
        plot(N_indexes(3),N_values(3),'o',linewidth==1)

    end 
end 

