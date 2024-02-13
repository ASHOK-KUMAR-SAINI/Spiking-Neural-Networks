
%function [OW,N_spike,N_input]=orgate2(X,N_spike,N_input,OW)
%for epoch=1:1:1
for j=1:1:size(X,1)
dt = 0.0001; %time step [ms]
t_end=1;  % total simulation time
E_L = -0.070;   %resting membrane potential [mV]
V_reset = -0.075; %value to reset voltage to after a spike [mV]
V_spike = 0.000000049;    %value to draw a spike to, when cell spikes [mV]
R_m = 600000000;           %membrane resistance [MOhm]      

tau = 0.025;        %membrane time constant [ms]
tau_t=0.012;       %time constant for adaptive threshold 
alpha=.5;         %threshold updataion rate when spike occures
a=.45;           %threshold updataion rate when there is no spike
t_vect = 0:dt:t_end-dt; 
fr1=poissonSpikeGen1(25,1)*0.0000000049; %25hz which is equal to 0 
fr2=poissonSpikeGen1(51,1)*0.0000000049;  %51hz which is equal to 1

nfr1=0;    % number of pre-spikes in fr1
nfr2=0;    % number of pre-spike in fr2
for ij=1:1:length(t_vect)
    if fr1(ij)>0
        nfr1=nfr1+1;
    end
    if fr2(ij)>0
        nfr2=nfr2+1;
    end
end

result=or(X(j,1),X(j,2));
for i=1:1:(size(X,2))
    if or(result,X(j,i))==0
        N_input(j)=nfr1;
    else 
        N_input(j)=nfr2; % N_input is desired output
    end
result=or(result,X(j,i));    
end



tpr=zeros(size(X,2),length(t_vect)); % vector matrix of pre-spike timing
I_e_vect=zeros(size(X,2),length(t_vect)); % Injected current matrix
for k=1:1:size(X,2)
if X(j,k)==0
   I_e_vect(k,:)=fr1;
end
if X(j,k)==1 
   I_e_vect(k,:)=fr2;
end
end

for kl=1:1:size(X,2)
for il=1:1:length(t_vect)-1 
    if I_e_vect(kl,il)>0
        tpr(kl,il)=il;
    end
end
end

N_spike(j)=0; % predicted output which changes according to weights
V_vect = zeros(1,length(t_vect));  % membrane potential matrix
V_vect(1)=E_L; % rasting potential 
V_th = zeros(1,length(t_vect)); % threshold potential
V_th(1) = -0.055;                                            %spike threshold [mV]
V_spike_plot=zeros(1,length(t_vect)); %post spike matrix                                          
tpost=zeros(1,length(t_vect));   % post spike timing mtrix


for i=1:1:length(t_vect)-1 
 V_inf = E_L + sum(sum((I_e_vect(:,i).*OW)))*R_m;    % membrane potentail at infinity
if(V_vect(i)>=V_th(i))
     V_th(i+1)=V_th(i)-V_th(i)*alpha;
    V_vect(i+1)=V_reset;
    V_spike_plot(i)=V_spike;
    N_spike(j)=N_spike(j)+1;
    tpost(i)=i;
else
    V_vect(i+1) = V_inf + (V_vect(i) - V_inf)*exp(-dt/tau);
    V_th(i+1)=a*V_vect(i+1)-((a*V_vect(i+1)-V_th(i))*exp(-dt/tau_t)); 
     V_spike_plot(i+1)=0;
end
end

if tpost==0                                                                                     
    disp("PLEASE INITIALIZE WEIGHTS CORRECTELY");
end

%if (N_spike(j)==N_input(j))   
%OW=W;
%else
%[W]=deltaW2(tpr,tpost,OW);   % update weights when predicted output is less then desired output                                                                                                       
%OW=W;
%end

disp("IN EPOCH 1 The training error of " +j+"th row elements is"+(N_input(j)-N_spike(j))/N_input(j))


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
end
%end


