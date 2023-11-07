m = 1;

% Define a function that returns the difference between the two equations
equations = @(x) [x(2) - 1/(0.3 * (x(1)^m + 1)); x(1) - x(2)/0.3^2];

% Initial guess for the solution
initial_guess = [1; 1];

% Use fsolve to find the solution
solution = fsolve(equations, initial_guess);

% Extract the values of P and E from the solution
P_solution = solution(1);
E_solution = solution(2);

disp(['Solution: P = ', num2str(P_solution), ', E = ', num2str(E_solution)]);

% Calculate the Jacobian matrix
syms M P;
f1 = 1/(0.3 * (P^m + 1));
f2 = M/0.3^2;
X = [M; P];
Jacobian = jacobian([f1; f2], X);

% Substitute the equilibrium point into the Jacobian matrix
equilibrium_point = [E_solution; P_solution];
Jacobian_at_equilibrium = double(subs(Jacobian, [M; P], equilibrium_point));

% Find eigenvalues and eigenvectors
[eigenvecs, eigenvals] = eig(Jacobian_at_equilibrium);

% Display the eigenvectors and eigenvalues
disp('Eigenvectors:');
disp(eigenvecs);
disp('Eigenvalues:');
disp(diag(eigenvals));

% Plotting
figure;
plot(P_solution, E_solution, 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r');
hold on;

% Plot E(P)
P_values = linspace(0, 50, 100);
E_values = 1./(0.3 * (P_values.^m + 1));
plot(P_values, E_values, '-');

% Plot P(E)
E_values = linspace(0, 15, 100);
P_values = E_values/0.3^2;
plot(P_values, E_values, '-');

% Plot eigenvectors at the equilibrium point
quiver(P_solution, E_solution, eigenvecs(1, 1), eigenvecs(2, 1), 'g', 'LineWidth', 2);
quiver(P_solution, E_solution, eigenvecs(1, 2), eigenvecs(2, 2), 'g', 'LineWidth', 2);

xlabel('P');
ylabel('E');
title('Intersection of E(P) and P(E) with Eigenvectors');
legend('Intersection Point', 'E(P)', 'P(E)', 'Eigenvector 1', 'Eigenvector 2');
grid on;
hold off;