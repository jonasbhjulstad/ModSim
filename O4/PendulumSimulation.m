clear all
close all
clc

% Parameters and initial states
tf = 10;
% parameters =
 state = [0,pi/2,pi/2,0,0,0.001]';
M = 1;
L = 1;
% Simulation
try

    %%%%%% MODIFY THE CODE AS YOU SEE FIT
    opts = odeset('OutputFcn', 'odeplot', 'RelTol', 1e-3, 'AbsTol', 1e-10);
    
    [tsim,xsim] = ode23s(@(t,x)TestFunc(t, x),[0,tf],state,opts);

catch message
    display('Your simulation failed with the following message:')
    display(message.message)
    display(' ')

    % Assign dummy time and states if simulation failed
    tf = 0.1;
    tsim = [0,tf];
    xsim = 0;
end

%% 3D animation
DoublePlot = true;
FS = 30;
scale = 0.1;

% Create Objects
% Cube
vert{1} = 3*[ -1, -1, 0;  %1
               1, -1, 0;  %2
               1,  1, 0;  %3
              -1,  1, 0;  %4
              -1, -1, 2;  %5
               1, -1, 2;  %6
               1,  1, 2;  %7
              -1,  1, 2]/2; %8
fac{1} = [1 2 3 4;
          5 6 7 8;
          1 4 8 5;
          1 2 6 5;
          2 3 7 6;
          3 4 8 7];
Lrail = 1.2*max(abs(xsim(:,1)))/scale;
% Rail
a = 1.5;
vert{2} = [-Lrail,-a,-0.1;
           -Lrail, a,-0.1;
            Lrail, a,-0.1;
            Lrail,-a,-0.1];
fac{2} = [1,2,3,4];
% Sphere
[X,Y,Z] = sphere(20);
[fac{3},vert{3},c] = surf2patch(3*X/2,3*Y/2,3*Z/2);
% Animation
tic
t_disp = 0;
SimSpeed = 1;
 while t_disp < tf/SimSpeed
    % Interpolate state
     x_disp   = interp1(tsim,xsim,SimSpeed*t_disp)';

    % Unwrap state. MODIFY
    x = x_disp(1,1); % position cart
    th1 = x_disp(2,1);
    th2 = x_disp(3,1);
    p1 = L*[-sin(th1)+x;-cos(th1)]; % position 1st ball
    p2 = p1 + L*[-sin(th1)-sin(th2);-cos(th1)-cos(th2)]; % position 2nd ball

    % Input argument for DrawPendulm
    pos_disp = [x(1);p1(1);0;p1(2);p2(1);0;p2(2)];

    figure(1);clf;hold on
    if DoublePlot
        subplot(1,2,1);hold on
        DrawPendulum( pos_disp, vert, fac, scale);
        campos(scale*[15    15     -70])
        camtarget(scale*[0,0,1.5])
        camva(30)
        camproj('perspective')
        subplot(1,2,2);hold on
    end
    DrawPendulum( pos_disp, vert, fac, scale);
    campos(scale*[1    70     20])
    camtarget(scale*[0,0,1.5])
    camva(30)
    camproj('perspective')
    drawnow
    if t_disp == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    t_disp = toc;
 end
