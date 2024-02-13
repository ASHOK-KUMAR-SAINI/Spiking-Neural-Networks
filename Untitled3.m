[ numTrials , timeLength ] = size ( spikeMat );
time_s = timeLength ./1000;
numAP = cell (1 ,1);
for i = 1: numTrials
numAP {i} = length ( find ( spikeMat (i ,:) ==1) );
end
numAP = cell2mat (numAP );
mean_firingRate = numAP ./ time_s ;






% simulate the baseline period
[ spikeMat_base , tVec_base ] = poissonSpikeGen1 (6, 0.5 , 20);
tVec_base = ( tVec_base - tVec_base ( end )) *1000 - 1;
% simulate the stimulus period
[ spikeMat_stim , tVec_stim ] = poissonSpikeGen1 (30 , 1, 20);
tVec_stim = tVec_stim *1000;
% put the baseline and stimulus periods together
spikeMat = [ spikeMat_base spikeMat_stim ];
tVec = [ tVec_base tVec_stim ];
% plot the raster and mark stimulus onset
plotRaster ( spikeMat , tVec );
hold all;
plot ([0 0], [0 size( spikeMat , 1)+1]) ;
% label the axes
xlabel ('Time (ms)');
ylabel ('Trial number ')