% Define the parameters
a = 250;
n = 2;
a0 = 0;
b = 5;

% Define the ODE system
ode_system = @(t, y) [
    -y(1) + a/(1+y(6)^n) + a0;
    -y(2) + a/(1+y(4)^n) + a0;
    -y(3) + a/(1+y(5)^n) + a0;
    b*(y(1)-y(4));
    b*(y(2)-y(5));
    b*(y(3)-y(6))
];

% Set initial conditions for m and p
initial_conditions = rand(1,6);

% Define the time span for the solution
tspan = [0, 60];

% Solve the ODE system using ode45
[t, y] = ode45(ode_system, tspan, initial_conditions);

% Extract the solution for p
p_values = y(:, 4:6);

figure(1)
clf
fig=gcf;
fig.Position=[800 100 1200 400];
subplot(1,2,1)
% Plot p vs t
plot(t, p_values);
xlabel('Time (t), second');
ylabel('p, [mol]');
title('Plot of p_1, p_2, and p_3 vs t');
legend('p_1', 'p_2', 'p_3');
grid on;

subplot(1,2,2)
% Extract the solution for m
m_values = y(:,1:3);

% Plot p vs t
plot(t, m_values);
xlabel('Time (t), second');
ylabel('m, [mol]');
title('Plot of m_1, m_2, and m_3 vs t');
legend('m_1', 'm_2', 'm_3');
grid on;
