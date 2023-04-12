function t=measure_adp90(ap,o)
%input: Action Pontential vector (length(24003)
%output: ADP90

    [y1,t1]=max(ap(1:8001));
    [y2,t2]=max(ap(8001:16002));
    [y3,t3]=max(ap(16003:24003));
    
    M_indexes=[t1,t2+8001,t3+16003];
    M_values=[y1,y2,y3];
    
    N_values=M_values*0.90;
    [y1,t1]=min(abs(ap(1    : 8001)-N_values(1)));
    [y2,t2]=min(abs(ap(8001 :16002)-N_values(2)));
    [y3,t3]=min(abs(ap(16003:24003)-N_values(3)));
    N_indexes=[t1,t2+8001,t3+16003];

    t=abs(M_indexes-N_indexes)*0.1000;
    if (o==1)
        figure()
        plot(ap)
        title("AP with max and 0.9 points")
        hold on 
        grid on
        plot(M_indexes(1),M_values(1),'o',linewidth=1)
        plot(M_indexes(2),M_values(2),'o',linewidth=1)
        plot(M_indexes(3),M_values(3),'o',linewidth=1)
        plot(N_indexes(1),N_values(1),'o',linewidth=1)
        plot(N_indexes(2),N_values(2),'o',linewidth=1)
        plot(N_indexes(3),N_values(3),'o',linewidth=1)
    end 
end 

