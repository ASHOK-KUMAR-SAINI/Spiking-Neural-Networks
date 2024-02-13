%%LEAKY INTEGRATED AND FIRE MODEL%%
dt =0.001;                                           %time step [ms]// bin size
t_end = 1;                                         %total time of run [ms]
E_L = -0.070;                                             %resting membrane potential [mV]
V_reset = -0.075;                                          %value to reset voltage to after a spike [mV]
V_spike =0.0000000049;                                           %value to draw a spike to, when cell spikes [mV]
R_m =60000000;                                              %membrane resistance [MOhm]

tau = 0.025;    %membrane time constant [ms]
tau_t=0.012;
alpha=01;
a=.45;
t_vect = 0:dt:t_end;                                
V_vect1 = zeros(1,length(t_vect));  
V_th1 = zeros(1,length(t_vect));  
V_th1(1) = -0.055;                                            %spike threshold [mV]

V_spike_plot1=zeros(1,length(t_vect));                                          
V_vect1(1)=E_L;  
%for s=1:1:length(t_vect)
%if rem(t_vect(s),.005)==0
%I_e_vect(s)=0.0000000049 ;  %current in nA
%end
%end
%I_e_vect(1001)=0;

I_e_vect1=spikeMat*0.0000000049*2; %here w1=1
N_spike1=0;

for i=1:1:length(t_vect)-1      
 V_inf1 = E_L + I_e_vect1(200,i)*R_m; 
 V_spike_plot1(i+1)=0;
if(V_vect1(i)>=V_th1(i))
     V_th1(i+1)=V_th1(i)-V_th1(i)*alpha;
    V_vect1(i+1)=V_reset;
    V_spike_plot1(i)=V_spike;
    N_spike1=N_spike1+1;
else
    V_vect1(i+1) = V_inf1 + (V_vect1(i) - V_inf1)*exp(-dt/tau);
    V_th1(i+1)=a*V_vect1(i+1)-((a*V_vect1(i+1)-V_th1(i))*exp(-dt/tau_t)); 
     V_spike_plot1(i+1)=0;
end
end
%second neuron
V_vect2 = zeros(1,length(t_vect));  
V_th2 = zeros(1,length(t_vect));  
V_th2(1) = -0.055;                                            %spike threshold [mV]

V_spike_plot2=zeros(1,length(t_vect));                                          
V_vect2(1)=E_L;  
%for s=1:1:length(t_vect)
%if rem(t_vect(s),.005)==0
%I_e_vect(s)=0.0000000049 ;  %current in nA
%end
%end
%I_e_vect(1001)=0;

I_e_vect2= V_spike_plot1*4; %here w2=4;
N_spike2=0;

for i=1:1:length(t_vect)-1      
 V_inf2 = E_L + I_e_vect2(i)*R_m; 
 V_spike_plot2(i+1)=0;
if(V_vect2(i)>=V_th2(i))
     V_th2(i+1)=V_th2(i)-V_th2(i)*alpha;
    V_vect2(i+1)=V_reset;
    V_spike_plot2(i)=V_spike;
    N_spike2=N_spike2+1;
else
    V_vect2(i+1) = V_inf2 + (V_vect2(i) - V_inf2)*exp(-dt/tau);
    V_th2(i+1)=a*V_vect2(i+1)-((a*V_vect2(i+1)-V_th2(i))*exp(-dt/tau_t)); 
     V_spike_plot2(i+1)=0;
end
end

%MAKE PLOTS
figure
subplot(2,1,1)
plot(t_vect, V_vect1);
title('Membrene Pot1(mV) V/s time(mS)');
xlabel('Time');
ylabel('Voltage');
hold on 
plot(t_vect,V_th1);
subplot(2,1,2)
plot(t_vect, V_vect2);
title('Membrene Pot2(mV) V/s time(mS)');
xlabel('Time');
ylabel('Voltage');
hold on 
plot(t_vect,V_th2);
figure
plot(t_vect,V_spike_plot1);
title("Spike (mV) V/s Time(mS)--input for second neuron");
xlabel("Time");
ylabel("Voltage");
figure
subplot(2,1,1)
plot(t_vect(:,1:1000),I_e_vect1(200,:));
title("Injected Current(nA) V/s Time(mS) 'MAIN INPUT'");
xlabel("Time");
ylabel("Current");
subplot(2,1,2)
plot(t_vect,V_spike_plot2);
title("Spike (mV) V/s Time(mS)'MAIN OUTPUT'");
xlabel("Time");
ylabel("Voltage");



   