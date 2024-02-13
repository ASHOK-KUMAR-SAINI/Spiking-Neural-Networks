%if sum(tpost)>0
 %if ((N_spike(j)>=N_input(j)-2)||(N_spike(j)>=N_input(j)-1)||(N_spike(j)>=N_input(j)))==1
% W=OW(j,:);
%else
 %[W]=deltaW2(tpr(:,1:i),tpost(1:i),OW(j,:)); 
 %end
 %else
 %V_inf = E_L + sum(sum(I_e_vect(:,i)*10))*R_m;
 %end
 %OW(j,:)=W;

 figure
subplot(3,1,1)
plot(t_vect, V_vect);
title('Membrene Pot(mV) V/s time(mS)');
xlabel('Time');
ylabel('Voltage');
hold on 
plot(t_vect,V_th);
subplot(3,1,2)
plot(t_vect,V_spike_plot);
title("Spike Pot(mV) V/s Time(mS)");
xlabel("Time");
ylabel("Voltage");
subplot(3,1,3)
plot(t_vect,I_e_vect);
title("Injected Current(nA) V/s Time(mS)");
xlabel("Time");
ylabel("Current");

