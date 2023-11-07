clear all;
close all;
Pmin=zeros(12,1);
Pmax=zeros(12,1);
M_solution=zeros(12,1);
P_solution=zeros(12,1);
for m=1:12
    
    
    % Define the parameters
    
    
    % Define the ODE system
    ode_system = @(t, y) [
    1/(y(3)^m + 1)-0.3*y(1);
    y(1)-0.3*y(2);
    y(2)-0.3*y(3)
    ];
    
    % Set initial conditions for m and p
    initial_conditions = rand(1,3);
    
    % Define the time span for the solution
    tspan = [0, 10000];
    
    % Solve the ODE system using ode45
    [t, y] = ode45(ode_system, tspan, initial_conditions);
    
    % Extract the solution for p
    p_values = y(:, 1:3);
    
    figure(1)
    clf
    fig=gcf;
    fig.Position=[800 100 600 400];
    
    % Plot M E P vs t
    plot(t, p_values);
    xlabel('Time (t), second');
    ylabel('p, [mol]');
    title('Plot of p_1, p_2, and p_3 vs t');
    legend('M', 'E', 'P');
    grid on;
    pause(0.2)

    equations = @(x) [x(1) - 1/(0.3*(x(2)^m + 1)); x(2) - x(1)/(0.3^2)];

    % Initial guess for the solution
    initial_guess = [1; 1];
    
    % Solve the system of equations numerically
    solution = fsolve(equations, initial_guess);
    
    % Extract the values of M and P from the solution
    M_solution(m) = solution(1);
    P_solution(m) = solution(2);

    % save max min
    Pmax(m)=max(p_values(round(length(p_values)*9/10):length(p_values),3))-solution(2);
    Pmin(m)=min(p_values(round(length(p_values)*9/10):length(p_values),3))-solution(2);


end

% Plot Pmax and Pmin vs m
figure;
plot(1:12, Pmax, 'o-', 'LineWidth', 2, 'DisplayName', 'Pmax');
hold on;
plot(1:12, Pmin, 's-', 'LineWidth', 2, 'DisplayName', 'Pmin');
hold on;

xlabel('m');
ylabel('Pmax and Pmin');
title('Pmax and Pmin vs m');
legend('Pmax', 'Pmin');
grid on;

% Display the plot



