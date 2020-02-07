M = 1;
m = 1;
L = 1;
q = sym('p', [3,1], 'Real');
dq = sym('dp',[3,1],'Real');

x_th1_dot = -L*cos(q(2))*dq(2) + dq(1);

x_th2_dot = -L*cos(q(2))*dq(2)-L*cos(q(3))*dq(3)+dq(1);

y_th1_dot = L*sin(q(2))*dq(2);

y_th2_dot = L*sin(q(2)*dq(2)+L*sin(q(3))*dq(3));

T_x = 0.5*m*q(1)^2;

T_th1 = 0.5*M*(x_th1_dot^2 + y_th1_dot^2);

T_th2 = 0.5*M*(x_th2_dot^2 + y_th2_dot^2);

U = -M*9.81*L*(2*cos(q(2)) + cos(q(3)));

Lagrangian = T_x + T_th1 + T_th2 -U;

LagDDiff_dq = jacobian(jacobian(Lagrangian,dq),dq);

LagDiff_q = jacobian(Lagrangian,q)';

LagDiff_dq_q = jacobian(LagDiff_q,dq);
Q = [0;0;0];
state_dot = [dq;inv(LagDDiff_dq)*(Q + LagDiff_q-LagDiff_dq_q*dq)];
state = [q;dq];
syms t
matlabFunction(state_dot,'File', 'TestFunc.m', 'vars', {t,state})