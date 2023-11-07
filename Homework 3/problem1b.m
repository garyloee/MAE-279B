[Xkd, Ykd]=meshgrid(0:15);
DDtot=(Ykd./(1+Xkd+Ykd));
surf(Xkd, Ykd, DDtot);
xlabel('X/k_x_d');
ylabel('Y/k_y_d');
zlabel('APF');