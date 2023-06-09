function t=measure_apd90(ap,o)
%The ADP90 is a measurement of the action potential duration  from the
% beginning to the point at 90% of repolarization. 

%Input: ap.y --> struct type 
%       o    --> Option if you want to plot ==1
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
    [y1,r1]=min(abs(ap.y(t1:8001,1) - N_values(1)));
    [y2,r2]=min(abs(ap.y(t2+8001:16002,1)- N_values(2)));
    [y3,r3]=min(abs(ap.y(t3+16002:24003,1)- N_values(3)));

    %Find the index of the msv in the vector
    N_indexes=[t1-1+r1,t2-1+8001+r2,t3-1+16002+r3];

    %Values of the difference  
    N_values=[y1,y2,y3];
    

    %find the dmax point for each APs
    dmax =[      find(abs(diff(ap.y(    1: 8001,1)))==max(abs(diff(ap.y(    1: 8001,1)))));
            8002+find(abs(diff(ap.y( 8002:16002,1)))==max(abs(diff(ap.y( 8002:16002,1)))))
           16003+find(abs(diff(ap.y(16003:24003,1)))==max(abs(diff(ap.y(16003:24003,1)))))];
   

    % Interval of time between the dmax and the msv  time point
    t=[abs(ap.t(dmax(1))-ap.t(N_indexes(1)));
       abs(ap.t(dmax(2))-ap.t(N_indexes(2)));
       abs(ap.t(dmax(3))-ap.t(N_indexes(3)))];

   
    if (o==1)
        figure()
        plot(ap.t,ap.y(:,1));
        title([ap.name], 'Interpreter', 'none');
        hold on 
        grid on

        plot(ap.t(M_indexes(1)),ap.y(M_indexes(1),1),'o')
        plot(ap.t(M_indexes(2)),ap.y(M_indexes(2),1),'o')
        plot(ap.t(M_indexes(3)),ap.y(M_indexes(3),1),'o')
        plot(ap.t(N_indexes(1)),ap.y(N_indexes(1),1),'x','LineWidth',2)
        plot(ap.t(N_indexes(2)),ap.y(N_indexes(2),1),'x','LineWidth',2)
        plot(ap.t(N_indexes(3)),ap.y(N_indexes(3),1),'x','LineWidth',2)
        plot(ap.t(dmax(1)),ap.y(dmax(1),1),'x','LineWidth',2)
        plot(ap.t(dmax(2)),ap.y(dmax(2),1),'x','LineWidth',2)
        plot(ap.t(dmax(3)),ap.y(dmax(3),1),'x','LineWidth',2)

        vline(ap.t(dmax(1)), 'k--'); 
        vline(ap.t(dmax(2)), 'k--'); 
        vline(ap.t(dmax(3)), 'k--'); 
        vline(ap.t(N_indexes(1)), 'k--'); 
        vline(ap.t(N_indexes(2)), 'k--'); 
        vline(ap.t(N_indexes(3)), 'k--'); 
        ylim([min(ap.y(:,1)),max(ap.y(:,1))]);
        xlim([min(ap.t),max(ap.t)]);
        
    end 
end 

