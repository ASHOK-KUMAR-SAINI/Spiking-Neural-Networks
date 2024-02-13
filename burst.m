% Set up the input signal
x = 100; % or any other real value

% Normalize the input signal
x_norm =20 / 255;

% Set the burst firing threshold and burst duration
theta = 0.01;
burst_duration = 0.1;

% Set the refractory period and inter-burst delay
refractory_period = 0.01;
interburst_delay = 0.05;

% Set the time vector
t =0:0.000001:(0.001-0.000001);

% Initialize the spike train
spike_train = zeros(size(t));

% Generate spikes
i = 1;
while i <= length(spike_train)
    
    % Check if the input signal has crossed the threshold
    if x_norm > theta
        
        % Generate a burst of spikes
        num_spikes = round(x_norm * 20); % Number of spikes proportional to input signal
        spike_times = linspace(t(i), t(i) + burst_duration, num_spikes);
  
        
        % Set the refractory period and inter-burst delay
        i_refractory = i + num_spikes - 1;
        i_interburst = i_refractory + round(interburst_delay / 0.01);
        
        % Check if there is another input signal peak during the refractory period
        while i_interburst <= length(spike_train) && x_norm > theta
            
            % Delay the next burst until after the refractory period
            i_interburst = i_interburst + round(refractory_period / 0.01);
            
        end
        
        % Update the index to skip over the refractory period and inter-burst delay
        i = i_interburst;
        
    end
    
    % Increment the time step index
    i = i + 1;
    
end
spike_train(1)=1;
spike_train(ceil(spike_times(2:end)*10000))=1;
% Plot the spike train
figure;
stem(t, spike_train);
title('Spike Train');
xlabel('Time (s)');
ylabel('Spike');
