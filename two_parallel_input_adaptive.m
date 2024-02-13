%%LEAKY INTEGRATED AND FIRE MODEL%%
dt =0.001;                                           %time step [ms]// bin size
t_end = 1;                                         %total time of run [ms]
E_L = -0.070;                                             %resting membrane potential [mV]
V_reset = -0.075;                                          %value to reset voltage to after a spike [mV]
V_spike = 20;                                           %value to draw a spike to, when cell spikes [mV]
R_m =60000000;                                              %membrane resistance [MOhm]

tau = 0.025;    %membrane time constant [ms]
tau_t=0.012;
alpha=01;
a=.45;
t_vect = 0:dt:t_end;                                
V_vect = zeros(1,length(t_vect));  
V_th = zeros(1,length(t_vect));  
V_th(1) = -0.055;                                            %spike threshold [mV]

V_spike_plot=zeros(1,length(t_vect));                                          
V_vect(1)=E_L;  
%for s=1:1:length(t_vect)
%if rem(t_vect(s),.005)==0
%I_e_vect(s)=0.0000000049 ;  %current in nA
%end
%end
%I_e_vect(1001)=0;

I_e_vect=spikeMat*0.0000000049;
N_spike=0;
for i=1:1:length(t_vect)-1      
 V_inf = E_L + ((I_e_vect(200,i)*W1)+(I_e_vect(200,i)*W2))*R_m; 
 V_spike_plot(i+1)=0;
if(V_vect(i)>=V_th(i))
     V_th(i+1)=V_th(i)-V_th(i)*alpha;
    V_vect(i+1)=V_reset;
    V_spike_plot(i)=V_spike;
    N_spike=N_spike+1;
else
    V_vect(i+1) = V_inf + (V_vect(i) - V_inf)*exp(-dt/tau);
    V_th(i+1)=a*V_vect(i+1)-((a*V_vect(i+1)-V_th(i))*exp(-dt/tau_t)); 
     V_spike_plot(i+1)=0;
end
end
%MAKE PLOTS
figure(1)
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
plot(t_vect(:,1:1000),I_e_vect(200,:));
title("Injected Current(nA) V/s Time(mS)");
xlabel("Time");
ylabel("Current");

   