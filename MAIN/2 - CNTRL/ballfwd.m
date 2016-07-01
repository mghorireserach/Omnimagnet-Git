%% Moves Ball Forward in a Straight Line from point1 to point2
% Author: Mohamed Ghori
% Reference Material: 
% A. J. Petruska, J. B. Brink, and J. J. Abbott, "First Demonstration of a Modular and Reconfigurable Magnetic-Manipulation System," IEEE Int. Conf. Robotics and Automation, 2015 (to appear). 
% A. J. Petruska, A. W. Mahoney, and J. J. Abbott, "Remote Manipulation with a Stationary Computer-Controlled Magnetic Dipole Source," IEEE Trans. Robotics, 30(5):1222-1227, 2014. 
% A. J. Petruska and J. J. Abbott, "Omnimagnet: An Omnidirectional Electromagnet for Controlled Dipole-Field Generation," IEEE Trans. Magnetics, 50(7):8400810(1-10), 2014. 
% Link: http://www.telerobotics.utah.edu/index.php/Research/Omnimagnets

function [ currX, currY, currZ, wRb, Task ] = ballfwd(p1,p2,wRb,T,dt,speed,ballsize)
%Print Task Name
Task = 'Running Move Ball Fwd';
%---------------------
%
% ballfwd rotates the ball such that the y-axis is 90 degreees
% perpendicular to the direction of piont2 from point1. second it rolls the
% ball about the y-axis until the ball reaches point2
%
%   [ currx, curry, currz, wRb ] = ballfwd(p1,p2,wRb,T,dt,speed,ballsize)
%   "Returns the solenoid-current combination coresponding to 
%    the series of orientations the magneticc-field must go through during 
%    the ball's path from point1 to point2, Given the 
%    initial point and final ponit, the initial orientation, the time to 
%    complete path, the time step, the speed of the video, and the ball size:
%    'p1' 'p2' 'wRb' 'T' 'dt' 'speed' 'ballsize' respectively
%
% EX__
%   [ currx, curry, currz, wRb ] = ballfwd([0;0;0],[1;1;1],eye(3),10,0.1,1,1)
%   

%% ballfwd
if nargin == 7
    %% Initiate Current
    % Decompose wRb into phi & psi components
    [phi, psi] = findPhiPsi(wRb);
    % Finding required current for phi and psi orientation
    [currx, curry, currz] = inverseMagneticField(p1(1), p1(2), phi, psi);
    currX = currx;
    currY = curry;
    currZ = currz;

    %% Rotate Ball about world-z-axis
    % direction vector from p1 to p2 in world
    direction = (p2-p1)/norm(p2-p1);
    % unit vector of Magnetic-Field y-axis in world x-y-plane
    yaxis = [wRb(4:5)';0];
    anglediff(direction,yaxis)
    % Angle Between Magnetic-Field y-axis and vector pointing to next position
    theta = (pi/2 - anglediff(direction,yaxis));
    % For no rotation needed EXCEPTION
    if isnan(direction)
        theta = 0;
    end

        %% Visualization of Rotation
        % Number of steps in rotation
        rotsteps = floor(T/(4*dt));
        % Angular Velocity of rotation
        omegaz = theta*4/T;
        % Seperate Rotation Matrix for visualization
        Rrot = wRb;
        % Visualization Function of ball after Rotation
        for n = 1 : rotsteps
            % Rotation
            rotz(omegaz*dt);
            Rrot = rotz(omegaz*dt)*Rrot;
            % Visualization Function of ball after Rotation
            plot_ball(ballsize,p1,Rrot,dt,speed);
            % Find the Neccessary Current and add it to current set 
                % Decompose wRb into phi & psi components    
                [phi, psi] = findPhiPsi(Rrot);
                % Finding required current for phi and psi orientation of
                % magnet-field
                [currx, curry, currz] = inverseMagneticField(p1(1), p1(2), phi, psi);
                currX = [currX;currx];
                currY = [currY;curry];
                currZ = [currZ;currz];

        end

        % Pre multiply rotation for fixed frame
        wRb = rotz(theta)*wRb;
        % Visualization Function of ball after Rotation 
        plot_ball(ballsize,p1,wRb,0,speed);
        % Find the Neccessary Current and add it to current set 
            % Decompose wRb into phi & psi components    
            [phi, psi] = findPhiPsi(wRb);
            % Finding required current for phi and psi orientation of
            % magnet-field
            [currx, curry, currz] = inverseMagneticField(p1(1), p1(2), phi, psi);
            currX = [currX;currx];
            currY = [currY;curry];
            currZ = [currZ;currz];
    %% Translation
    % Rotation required to reach p2 with no slip condition
    gama = norm(p2-p1)/(ballsize);

        %% Visualization of Translation
        % Number of steps in Translation
        transteps = floor(3*T/(4*dt));
        % Angular Velocity of rotation
        omegay = gama*4/(3*T);
        % Linear Velocity of ball
        vel = abs(omegay)*ballsize;
        % Rotation matrix for visualization
        Rtrans = wRb; 
        % Position vector for visualization
        p = p1;
        for n = 1 : transteps
            % Rotation
            Rtrans = Rtrans*roty(omegay*dt);
            % Position of Ball
            p = p + vel*direction*dt; 
            % Visualization Function of ball after Rotation
            plot_ball(ballsize,p,Rtrans,dt,speed);
            % Find the Neccessary Current and add it to current set 
                % Decompose wRb into phi & psi components    
                [phi, psi] = findPhiPsi(Rtrans);
                % Finding required current for phi and psi orientation of
                % magnet-field
                [currx, curry, currz] = inverseMagneticField(p1(1), p1(2), phi, psi);
                currX = [currX;currx];
                currY = [currY;curry];
                currZ = [currZ;currz];
        end

        % Pre multiply rotation for fixed frame
        wRb = wRb*roty(gama);
        % Visualization Function of ball after Rotation 
        plot_ball(ballsize,p2,wRb,0,speed)
        % Find the Neccessary Current and add it to current set 
            % Decompose wRb into phi & psi components    
            [phi, psi] = findPhiPsi(wRb);
            % Finding required current for phi and psi orientation of
            % magnet-field
            [currx, curry, currz] = inverseMagneticField(p1(1), p1(2), phi, psi);
            currX = [currX;currx];
            currY = [currY;curry];
            currZ = [currZ;currz];    
else
    ERROR = 'Not Enough Input Arguments';
    display(ERROR);
end
end
