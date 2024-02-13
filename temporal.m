function [spike]=temporal(data,threshold,tau)
spike_timing=tau*log(data/data-threshold);
if spike_timing>0

