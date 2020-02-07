M = 1;
L = 1;
q = sym('p', [3,1]);
dq = sym('dp',[3,1]);

Lagrangian = 0.5*M*L^2*(2*dq(2)^2+dq(3)^2+cos(q(2)-q(3))*dq(2)*dq(3)+dq(1)^2)+M*9.81*L*(2*cos(q(2))+cos(q(3)));

LagDDiff_dq = jacobian(jacobian(Lagrangian,dq),dq);

LagDiff_q = jacobian(Lagrangian,q)';

LagDiff_dq_q = jacobian(LagDiff_q,dq);
Q = [0;0;0];
state_dot = [dq;inv(LagDDiff_dq)*(Q + LagDiff_q-LagDiff_dq_q*dq)];

matlabFunction(state_dot,'File', 'PendulumDynamics.m')