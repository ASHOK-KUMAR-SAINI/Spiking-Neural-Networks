%function spike_train = TTFS_CODING(image, t_vect)
 %image=im;
 %t_vect=t;
% image=[255,12;100,190];
image=im;
 a=size(image,1);
 b=size(image,2);
spike_train=zeros(a*b,length(t_vect));
for i=1:1:a*b
for t=1:1:length(t_vect)
Threshold=1.0*exp(-t/6);
if (image(i)/255.0)>Threshold
    spike_train(i,t)=1;
    break;
else 
    spike_train(i,t)=0;
end
end
end

spikeMat=logical(spike_train);
hold all;
for trialCount = 1:size(spikeMat,1)
    spikePos = t_vect(spikeMat(trialCount ,:));
    for spikeCount = 1: length (spikePos)
        plot(trialCount,spikePos(spikeCount),'b.') ;
    end
end

xlim([0 size(spikeMat,1)+1]);