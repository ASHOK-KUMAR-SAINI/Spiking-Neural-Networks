function[spikeMat]=poissonSpikeGen1(fr,tStim)
dt=1/1000;
nBins=floor(tStim/dt);
spikeMat=rand(1,nBins)<fr*dt;
end
  


