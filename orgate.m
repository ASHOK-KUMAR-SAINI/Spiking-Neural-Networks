dt = 0.1;
t_end=500;                                                       %time step [ms]
E_L = -70;                                             %resting membrane potential [mV]
V_th = -55;                                            %spike threshold [mV]
V_reset = -75;                                          %value to reset voltage to after a spike [mV]
V_spike = 10;                                           %value to draw a spike to, when cell spikes [mV]
R_m = 10;                                              %membrane resistance [MOhm]                                            
N_spike=0;
tau = 10;                                           %membrane time constant [ms]
t_vect = dt:dt:t_end;  
V_vect = zeros(1,length(t_vect));  %membrene potential 
V_spike_plot=zeros(1,length(t_vect));             %% spike voltage for post spike
V_vect(1)=E_L;  
tpost=0;
tpr1=0;
tpr2=0;
I_e_vect=zeros(2,length(t_vect));
for i=600:1:4999
if rem(t_vect(i),60)==0
I_e_vect(1,i)=1.55 ;  %current in nA
tpr1=i;
end

if rem(t_vect(i),80)==0
I_e_vect(2,i)=1.55;
tpr2=i;
end
end

for i=1:1:4999
    if I_e_vect(1,i) && I_e_vect(2,i)==1.55
    [W1,W2]=deltaW2(tpr1,tpr2,tpost);
    else
    [W1,W2]=deltaW(tpr1,tpr2,tpost);
    end
 V_inf = E_L + (I_e_vect(1,i)*W1+I_e_vect(2,i)*W2)*R_m; 
 V_vect(i+1) = V_inf + (V_vect(i) - V_inf)*exp(-dt/tau);
 if(V_vect(i+1)>=V_th)
     V_vect(i+1)=V_spike;
     V_spike_plot(i+1)=V_vect(i+1);
    V_vect(i+1)=V_reset;
   
    N_spike=N_spike+1;
   
    tpost=i;
 else
    V_vect(i+1) = V_inf + (V_vect(i) - V_inf)*exp(-dt/tau); 
    V_spike_plot(i+1)=0;
 end   

end

if tpost==0
    disp("PLEASE INITIALIZE WEIGHTS CORRECTELY");
end

figure()
subplot(3,1,1)
plot(t_vect,I_e_vect(1,:))
title("input spike X1");
xlabel("time(mS)");
ylabel("spike current(nA)");
subplot(3,1,2)
plot(t_vect,I_e_vect(2,:))
title("input spike X2");
xlabel("time(mS)");
ylabel("spike current(nA)");
subplot(3,1,3)
plot(t_vect,V_spike_plot);
title(" post spike")
xlabel("time(mS)");
ylabel("spike(mV)");
figure()
plot(t_vect,V_vect);
