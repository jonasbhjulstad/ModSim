clear all
close all
clc

tf = 20;

p = [1;9.81;0.1];

x0 = [0;0]; 
%x0 = [pi;0];
 
u0 = 0.0;
f0 = DynFunc(0,x0,u0,p);
display(['Steady-state? f(x0,u0)= [',num2str(f0.'),']'])

[A,B] = LinFunc(x0,u0,p);


dx0 = [90*pi/180;0];

opt = odeset('MaxStep',1e-1);
Dyn = @(t,x) DynFunc(t,x,u0,p);
[t,x]=ode45(Dyn,[0 tf],x0+dx0,opt);  

Dyn = @(t,x) DynLin(t,x,u0,A,B);
[tlin,xlin]=ode45(Dyn,[0 tf],x0+dx0,opt); 

Labels = {'$$\theta\,\,\mathrm{ in }\,\,[^\circ]$$','$$\omega\,\,\mathrm{ in }\,\,[^\circ/s]$$'};
figure(1);clf
for i = 1:2
    subplot(2,1,i);hold on
    h1 = plot(t,180*x(:,i)/pi,'k','linewidth',2);
    xlabel('$$t$$','interpreter','latex','fontsize',25)
    ylabel(Labels{i},'interpreter','latex','fontsize',25)
    Ax = get(gca);
    AxisX(i,:) = Ax.XLim;
    AxisY(i,:) = Ax.YLim;
end
legend([h1],{'Nonlinear model'},'fontsize',20,'location','southeast')


pause

for i = 1:2
    subplot(2,1,i)
    h2 = plot(tlin,180*xlin(:,i)/pi,'r','linewidth',2);
    xlim(AxisX(i,:));ylim(AxisY(i,:))
    %A(i) = get(gca);
end
legend([h1,h2],{'Nonlinear model','Linearized model'},'fontsize',20,'location','southeast')
