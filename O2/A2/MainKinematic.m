clear all
close all
clc

time_final = 20; %Final time
state_mat = eye(3);
state = [1;1;1;reshape(state_mat, [9,1])];
parameters = [2,0,0]';
%%%%%% MODIFY. Initial state values and parameter values


angle_dots = [1,1,1]';
timespan_euler = linspace(0,20,1000);
angles = angle_dots.*timespan_euler;

% Simulate dynamics
try
   
    [time,states] = ode45(@(t,x)Kinematics(t, x, parameters),[0:time_final/1000:time_final],state);
   
    statetraj = states(:,4:end);
    
    %for i = 1:length(timespan_euler)
     %      statetraj(i,:) = reshape(Rotations(angles(:,i)),[9,1]);
    %end
    
    
catch message
    display('Your simulation failed with the following message:')
    display(message.message)
    display(' ')

    %Assign dummy time and states if simulation failed
    time = [0,10];
    statetraj = [0,0];
end

%Below is a template for a real-time animation
ScaleFrame = 5;   % Scaling factor for adjusting the frame size (cosmetic)
FS         = 15;  % Fontsize for text
SW         = 0.035; % Arrows size
count = 1;
omega = parameters;
%omega = [0,-omega_vec(3), omega_vec(2);
 %   omega_vec(3), 0, -omega_vec(1);
  %  -omega_vec(2), omega_vec(1), 0];
time_display = 0; % initialise time_display
[a,b] = size(statetraj)
while count < a

    state_animate = interp1(time,statetraj,time_display); %interpolate the simulated state at the current clock time

    p     = [5;5;5];  % Position of the single body

    %%%%%% MODIFY THE FOLLOWING LINES TO PRODUCE AN "omega" AND "R" FROM YOUR SIMULATION STATE

    %omega = [];  % Some random Omega

    R = reshape(statetraj(count,:),[3,3]);
    count = count + 1;
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %3D below this point
    figure(1);clf;hold on
    MakeFrame( zeros(3,1),eye(3),ScaleFrame,FS,SW,'a', 'color', 'k')
    MakeFrame( p,R,ScaleFrame,FS,SW,'b', 'color', 'r')
    MakeArrow( p,R*omega,FS,SW,'$$\omega$$', 'color', [0,0.5,0])
    DrawRectangle(p,R ,'color',[0.5,0.5,0.5]);
    FormatPicture([0;0;2],0.5*[73.8380   21.0967   30.1493])

    if time_display == 0
        display('Hit a key to start animation')
        pause
        tic
    end
    time_display = toc; %get the current clock time
end
