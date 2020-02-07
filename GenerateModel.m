clear all
clc

syms L g nu theta omega u t real


x = [theta;omega];
p = [L;g;nu];

f = [omega;
     -g*sin(theta)/L+u/L - nu*omega ];
 
A = jacobian(f,x);
B = jacobian(f,u);



matlabFunction(f, 'file','DynFunc','vars',{t,x,u,p});
matlabFunction(A,B, 'file','LinFunc','vars',{x,u,p});
