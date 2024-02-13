% Define the amplitude values
a = [0.1 .23 .45 .64 0.33 0.5 0.9];

% Calculate the firing time using Δt = 1/a
firing_time_inv = 1./a;

% Calculate the firing time using Δt = 1 - a
firing_time_lin = 1 - a;


% Plot the results
figure;
plot(a, firing_time_inv, '-o', 'DisplayName', '1/a');
hold on;
plot(a, firing_time_lin, '-x', 'DisplayName', '1-a');
xlabel('Amplitude (a)');
ylabel('Firing Time (Δt)');
legend();