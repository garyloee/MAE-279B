
%% parameters
am=1;%/min
bm=0.1;%/min
ap=2;
bp=0.05;%/min
time1=0:60;
time2=0:120;

%% initialize ode solver
% solving m(t)
syms m(t)
% setting ODE
ode1=diff(m,t)==am-bm*m;
% initial condition
cond1=m(0)==0;
% solve ODE
mSol(t)=dsolve(ode1,cond1);

disp(mSol(t))

% solving p(t)
syms p(t)
% setting ODE
ode2=diff(p,t)==ap*mSol(t)-bp*p;
% initial condition
cond2=p(0)==0;
% solve ODE
pSol(t)=dsolve(ode2,cond2);

disp(pSol(t))

%% solving p(t) assuming quasi steady state, m=am/bm
syms pq(t)
ode3=diff(pq,t)==ap*am/bm-bp*pq;
cond3=pq(0)==0;
pqSol(t)=dsolve(ode3,cond3);
disp(pqSol)
%% plotting
figure(1)

clf
fig=gcf;
fig.Position=[800 100 1200 400];
subplot(1,2,1)
plot(time1,mSol(time1),'m-')
hold on
yline(10,'k--','steady state = a_m/b_m = 10')
hold on
plot(1/bm,mSol(1/bm), 'k.', 'MarkerFaceColor','k');
xlabel('Time, t [min]');
ylabel('mRNA level [mol]');
title('mRNA Kinetic Behavior')
ylim([0 10.9])
grid on
hold off
text(1/bm,mSol(1/bm), sprintf('   (%d, %.1f)',1/bm,mSol(1/bm)), 'Horiz','left', 'Vert','bottom')

subplot(1,2,2)
pplot=plot(time2,pSol(time2),'-');
hold on
pqplot=plot(time2,pqSol(time2),'b--');
hold on
yline(400,'k--','steady state = u_p/b_p=400')
hold on
plot(1/bp+1/bm,pSol(1/bp+1/bm), 'k.', 'MarkerFaceColor','k');
xlabel('Time, t [min]');
ylabel('Protein level [mol]');
title('Protein Kinetic Behavior')
ylim([0 435])
grid on
legend([pplot,pqplot],"Computaional Result","Quasi-steady State Result",Location="southeast")
hold off
text(1/bp+1/bm,pSol(1/bp+1/bm), sprintf('   (%d, %d)',1/bp+1/bm,pSol(1/bp+1/bm)), 'Horiz','left', 'Vert','bottom')
