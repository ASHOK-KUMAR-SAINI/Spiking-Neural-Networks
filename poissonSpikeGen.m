function[spikeMat,tVec]=poissonSpikeGen(fr,tStim)
dt=1/1000;
nBins=floor(tStim/dt);
a=size(fr,1);
b=size(fr,2);
prob_of_spike=fr*dt;
for i=1:1:a*b
   
spikeMat(i,:)=rand(1,nBins)<prob_of_spike(i);
   
end

tVec=0:dt:tStim-dt;
end
