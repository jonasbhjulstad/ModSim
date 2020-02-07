function [ state_dot ] = Kinematics( t, state, parameters )
   
    %(omega always passed as parameters)
    omega = parameters;
    
    %Function for calculating Axis/angle from Rotation matrix:
    [state_mat,M] = Rotations(state(1:3))
    
    %Ode45-adapted output:
    state_dot = [inv(M)*omega;reshape(state_mat,[9,1])];
    
    
    %Code for DCM:
    %{
    omega = parameters;
    
    Omega = [0,-omega(3),omega(2);
        omega(3), 0, -omega(1);
        -omega(2), omega(1), 0];
    
    Rba = reshape(state,[3,3]);
    
    dRba = Rba*Omega;
    
    state_dot = reshape(dRba, [9,1]);
    
    %}
    
      
end
