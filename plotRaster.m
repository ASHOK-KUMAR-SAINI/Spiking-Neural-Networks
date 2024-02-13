function [] = plotRaster(spikeMat,tVec)
% visualise raster plot
hold all;
for trialCount = 1:size(spikeMat,1)
    spikePos = tVec(spikeMat(trialCount ,:));
    for spikeCount = 1: length (spikePos)
        %plot([spikePos(spikeCount) spikePos( spikeCount )], [ trialCount-0.4 trialCount+0.4],'b.') ;
        plot(spikePos(spikeCount),trialCount,'b.') ;
    end
end

ylim([0 size(spikeMat,1)+1]);