
clear all;
close all;
m=12;
% Define the equations as anonymous functions
equations = @(x) [x(1) - 1/(0.3*(x(2)^m + 1)); x(2) - x(1)/(0.3^2)];

% Initial guess for the solution
initial_guess = [1; 1];

% Solve the system of equations numerically
solution = fsolve(equations, initial_guess);

% Extract the values of M and P from the solution
M_solution = solution(1);
P_solution = solution(2);

% Display the results
disp('Numerical Solution:');
disp(['M: ', num2str(M_solution)]);
disp(['P: ', num2str(P_solution)]);

% Define the functions
MP_function = @(P) 1/(0.3*(P^m + 1));
PM_function = @(M) M/(0.3^2);

% Generate a range of values for P and calculate corresponding M
P_values = linspace(0, 10, 100);
M_values_MP = arrayfun(MP_function, P_values);

% Generate a range of values for M and calculate corresponding P
M_values = linspace(0, 10, 100);
P_values_PM = arrayfun(PM_function, M_values);

% Calculate the Jacobian matrix
syms M E P;
f1 = 1/(P^m + 1)-0.3*M;
f2 = M-0.3*E;
f3 = E-0.3*P;
X = [M, E, P];
Jacobian = jacobian([f1; f2; f3], X);

% Substitute the equilibrium point into the Jacobian matrix
equilibrium_point = [M_solution; P_solution/0.3; P_solution];
Jacobian_at_equilibrium = double(subs(Jacobian, [M; E; P], equilibrium_point));

% Find eigenvalues and eigenvectors
[eigenvecs, eigenvals] = eig(Jacobian_at_equilibrium);

% Display the eigenvectors and eigenvalues
disp('Eigenvectors:');
disp(eigenvecs);
disp('Eigenvalues:');
disp(diag(eigenvals));


% Plot M(P) and P(M) in the same figure
figure;
plot(M_values, P_values_PM, '-', 'DisplayName', 'P(M)');
hold on;
plot(M_values_MP, P_values, '-', 'DisplayName', 'M(P)');
plot(M_solution, P_solution, 'rx', 'DisplayName', 'Intersection Point');



hold off;

ylabel('P');
xlabel('M');
title('Plot of P(M) and M(P)');
legend;
