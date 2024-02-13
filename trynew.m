% function [W]=trynew(X,W,Y)
% for j=1:1:size(X,1)
% outfrq=zeros(1,length(Y));
% c=0;
% d=0;
% Y1=zeros(1,length(Y));
% dt = 0.1;
% t_end=500;                                                       %time step [ms]
% E_L = -70;                                             %resting membrane potential [mV]
% V_th = -55;                                            %spike threshold [mV]
% V_reset = -75;                                          %value to reset voltage to after a spike [mV]
% V_spike = 10;                                           %value to draw a spike to, when cell spikes [mV]
% R_m = 10;                                              %membrane resistance [MOhm]                                            
% N_spike=0;
% tau = 10;                                           %membrane time constant [ms]
% t_vect = dt:dt:t_end;  
% V_vect = zeros(1,length(t_vect));                     %membrene potential 
% V_vect(1)=E_L;
% V_spike_plot=zeros(1,length(t_vect));             %% spike voltage for post spike
% V_vect(1)=E_L;  
% tpost=zeros(1,length(t_vect));
% I_e_vect=zeros(1,length(t_vect));
% I_e_vect1=zeros(1,length(t_vect));
% I_e_vect2=zeros(1,length(t_vect));
% alpha=0.01;
% 
% for i=650:1:5000
% if rem(t_vect(i),10)==0 % 100 hz 
% I_e_vect1(i)=1.55 ;  %current in nA
% end
% if rem(t_vect(i),5)==0 % 200 hz
% I_e_vect2(i)=1.55;
% end
% end
% for k=1:1:size(X,2)
% if X(j,k)==0
%     I_e_vect=I_e_vect+I_e_vect1;
% end
% if X(j,k)==1 
%     I_e_vect=I_e_vect+I_e_vect2;
% end
% end
% if Y(j)==0
% Y1(j)=100;
% end
% if Y(j)==1
% Y1(j)=200;
% end
% 
% 
% for i=1:1:4999
% if tpost(i)>0
% c=i;
% outfrq(j)=10000/(c-d);
% end
% if outfrq(j) ~= Y1(j)
% W(j)=W(j)+alpha*(-outfrq(j)+Y1(j))*I_e_vect(i);
% end
% V_inf = E_L + (I_e_vect(i)*W(j))*R_m; 
% V_vect(i+1) = V_inf + (V_vect(i) - V_inf)*exp(-dt/tau);
%  if(V_vect(i)>V_th)
%      
%    V_spike_plot(i+1)=V_spike;
%    V_vect(i+1)=V_th;
%    V_vect(i+1)=V_reset;
%    
%     N_spike=N_spike+1;
%   
%     tpost(i+1)=1;
%    
%  else
%     V_vect(i+1) = V_inf + (V_vect(i) - V_inf)*exp(-dt/tau); 
%     V_spike_plot(i+1)=0;
%  end
%  
%  if c > 0
%  d=c;
%  end
%  end
% 
% 
% figure()
% plot(t_vect,V_spike_plot);
% title("spike");
% figure()
% plot(t_vect,I_e_vect);
% title("spike input");
% figure()
% plot(t_vect,V_vect);
% 
% if tpost==0
%     disp("PLEASE INITIALIZE WEIGHTS CORRECTELY");
% end
% end
% 
% end
% 
c=zeros(1,1000);
for i =1:1:1000
    spikeMat=poissonSpikeGen1(51,1);
    for j=1:1:1000
        if spikeMat(j)>0
            c(i)=c(i)+1;
        end
    end
end