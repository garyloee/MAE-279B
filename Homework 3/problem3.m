%% parameters
global a a0 n b
a=250;
a0=0;
n=2;
b=5;


%% initialize ode solver
% solving m(t) p(t)

[m1,p1,p3,t]=ode45(@(m1,p1,p3,t) ode1(m1,p1,p3,t),[0 15],[0 0.01]);
plot(t,p1);






% setting ODE

% initial condition

% solve ODE



function d1dt=ode1(m1,p1,p3,t)
global a a0 n b
d1dt=zeros(2,1);
d1dt(1)=-m1+a/(1+p3^n)+a0;
d1dt(2)=b*(m1-p1);
end

function d2dt=ode2(m2,p2,p1,t)
global a a0 n b
d2dt=zeroes(2,1);
d2dt(1)=-m2+a/(1+p1^n)+a0;
d2dt(2)=b*(m2-p2);
end

function d3dt=ode3(m3,p3,p2,t)
global a a0 n b
d3dt=zeroes(2,1);
d3dt(1)=-m3+a/(1+p2^n)+a0;
d3dt(2)=b*(m3-p3);
end