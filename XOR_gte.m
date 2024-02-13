%for xx=1:1:100
node_hidden=2;
node_output=1;
a(1)=0;
% Whid=ones(node_hidden,size(X,2));
% Wout=ones(node_output,size(X,2));
for y=1:1:1000
for j=1:1:size(X,1)
fr1=poissonSpikeGen1(25,1)*0.00000000049;  %25hz which is equal to 0 
fr2=poissonSpikeGen1(51,1)*0.00000000049;  %51hz which is equal to 1
% for j=1:1:size(X,1)
% for y=1:1:100000

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% PARAMETERS USED %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
dt = 0.001;                  %time step [ms]
t_end=1;                      % total simulation time
E_L = -0.070;                    %resting membrane potential [mV]
V_reset = -0.075;               %value to reset voltage to after a spike [mV]
V_spike = 0.00000000049;          %value to draw a spike to, when cell spikes [mV]
R_m = 60000000;            %membrane resistance [MOhm]      

tau = 0.025;                    %membrane time constant [ms]
tau_t=0.012;                    %time constant for adaptive threshold 
alpha=.5;                      %threshold updataion rate when spike occures
a=.45;                             %threshold updataion rate when there is no spike
t_vect = 0:dt:t_end-dt; 


nfr1=0;                           % number of pre-spikes in fr1
nfr2=0;                             % number of pre-spike in fr2
for ij=1:1:length(t_vect)
    if fr1(ij)>0
        nfr1=nfr1+1;
    end
    if fr2(ij)>0
        nfr2=nfr2+1;
    end
end

result=xor(X(j,1),X(j,2));

    if result==0
        N_predicted(j)=nfr1;
    else 
        N_predicted(j)=nfr2;        % N_input is desired output
    end


N_output(j)=0;                    % predicted output which changes according to weights

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% INPUT LAYER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
                                

I_e_vect_In1=zeros(size(X,2),length(t_vect));             % Injected current matrix

for k=1:1:size(X,2)
if X(j,k)==0
   I_e_vect_In1(k,:)=fr1;
end
if X(j,k)==1 
   I_e_vect_In1(k,:)=fr2;
end
end
N_IN=ones(1,size(X,2));
for t=1:1:size(X,2)
for i=1:1:length(t_vect)
    if I_e_vect_In1(t,i)>0
        N_IN(t)=N_IN(t)+1;
    end
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% HIDDEN LAYER %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


S_out_hidden=zeros(node_hidden,length(t_vect)); %post spike matrix or output matrix
V_mem_hid = zeros(node_hidden,length(t_vect));                           % membrane potential matrix

V_th_hid = zeros(node_hidden,length(t_vect));                             % threshold potential

for n=1:1:node_hidden
N_out(n)=0;
V_mem_hid(n,1)=E_L;                                              % rasting potential 
V_th_hid(n,1) = -0.055;                                           %spike threshold [mV]   
for i=1:1:length(t_vect)-1 
V_inf = E_L + sum(sum((I_e_vect_In1(:,i)*Whid(n,:))))*R_m;    % membrane potentail at infinity
if(V_mem_hid(n,i)>=V_th_hid(n,i))
     V_th_hid(n,i+1)=V_th_hid(n,i)-V_th_hid(n,i)*alpha;
    V_mem_hid(n,i+1)=V_reset;
    S_out_hidden(n,i)=V_spike;
     
    
else
    V_mem_hid(n,i+1) = V_inf + (V_mem_hid(n,i) - V_inf)*exp(-dt/tau);
    V_th_hid(n,i+1)=a*V_mem_hid(n,i+1)-((a*V_mem_hid(n,i+1)-V_th_hid(n,i))*exp(-dt/tau_t)); 
    
end
end
for tt=1:1:length(S_out_hidden)
    if S_out_hidden(n,tt)>0
        N_out(n)=N_out(n)+1;
    end
end

% figure
% subplot(3,1,1)
% plot(t_vect, V_mem_hid);
% title('Membrene Pot(mV) V/s time(mS)');
% xlabel('Time');
% ylabel('Voltage');
% hold on 
% plot(t_vect,V_th_hid);
% subplot(3,1,2)
% plot(t_vect,S_out_hidden(n,:));
% title("Spike Pot(mV) V/s Time(mS)");
% xlabel("Time");
% ylabel("Voltage");
% subplot(3,1,3)
% plot(t_vect,I_e_vect_In1);
% title("Injected Current(nA) V/s Time(mS)");
% xlabel("Time");
% ylabel("Current");
end


I_e_vect_In2=S_out_hidden;


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% OUTPUT LAYER   %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

V_out_end=zeros(node_output,length(t_vect)); %post spike matrix or output matrix

V_mem_out = zeros(node_output,length(t_vect));                           % membrane potential matrix
V_th_out = zeros(node_output,length(t_vect));                             % threshold potential    
for m=1:1:node_output 
    V_mem_out(m,1)=E_L;                                              % rasting potential 
    V_th_out(m,1) = -0.055;                                           %spike threshold [mV] 
for i=1:1:length(t_vect)-1 
 V_inf = E_L + sum(sum((I_e_vect_In2(:,i)*Wout(m,:))))*R_m;    % membrane potentail at infinity
if(V_mem_out(m,i)>=V_th_out(m,i))
     V_th_out(m,i+1)=V_th_out(m,i)-V_th_out(m,i)*alpha;
    V_mem_out(m,i+1)=V_reset;
    V_out_end(m,i)=V_spike;
  
else
    V_mem_out(m,i+1) = V_inf + (V_mem_out(m,i) - V_inf)*exp(-dt/tau);
    V_th_out(m,i+1)=a*V_mem_out(m,i+1)-((a*V_mem_out(m,i+1)-V_th_out(m,i))*exp(-dt/tau_t)); 
    
end
end
for tk=1:1:length(V_out_end)
    if V_out_end(m,tk)>0
        N_output(j)=N_output(j)+1;
    end
end
% figure
% subplot(3,1,1)
% plot(t_vect, V_mem_out);
% title('Membrene Pot(mV) V/s time(mS)');
% xlabel('Time');
% ylabel('Voltage');
% hold on 
% plot(t_vect,V_th_out);
% subplot(3,1,2)
% plot(t_vect,V_out_end);
% title("Spike Pot(mV) V/s Time(mS)");
% xlabel("Time");
% ylabel("Voltage");
% subplot(3,1,3)
% plot(t_vect,I_e_vect_In2);
% title("Injected Current(nA) V/s Time(mS)");
% xlabel("Time");
% ylabel("Current");
end
%disp("IN EPOCH 1 The training error of " +j+"th row elements is"+(N_predicted(j)-N_output(j)))

% [Whid,Wout]= weights_XOR(N_output(j),N_predicted(j), ...
%    V_mem_hid,V_mem_out,V_th_out,V_th_hid,N_out,Wout,Whid,N_IN,I_e_vect_In2);


%  if ( N_predicted(j)-N_output(j)) < 5 && ( N_predicted(j)-N_output(j)) > -5
%      Whidd=Whidd+Whid;
%      Woutt=Woutt+Wout;
%      break;
%  end
a(1)=a(1)+N_output(1);
end

end
%end
%%%% ek kaam krte hai ,m jaanta hu ki jo firing rate hai woh average hai
%%%% ,to weightd update krne ke baad or model train krne ke baad me ek kaam
%%%% krta hu jo testing in data hai uska bhi average leke classifie krta hu
%%%% output ko
