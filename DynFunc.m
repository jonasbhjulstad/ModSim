function f = DynFunc(t,in2,u,in4)
%DYNFUNC
%    F = DYNFUNC(T,IN2,U,IN4)

%    This function was generated by the Symbolic Math Toolbox version 6.1.
%    01-Sep-2017 16:47:32

L = in4(1,:);
g = in4(2,:);
nu = in4(3,:);
omega = in2(2,:);
theta = in2(1,:);
t2 = 1.0./L;
f = [omega;-nu.*omega+t2.*u-g.*t2.*sin(theta)];
