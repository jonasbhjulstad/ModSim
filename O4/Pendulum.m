function state_dot = Pendulum(t, x, parameters)
    
    M = 1;
    len = 1;

    syms L(q,qd)
    
    L(x,x_dot,th1,th2,th1_dot,th2_dot) = 0.5*M*len*(2*th1_dot^2+th2_dot^2+cos(th1-th2)*th1_dot*th2_dot+x_dot^2)+M*9.81*len*(2*cos(th1)+cos(th2))
    
   


end