%% Rolls a Magnet Ball in a Circle Trajectory Using Magnetic Field
% Author: Mohamed Ghori
% Reference Material: 
% A. J. Petruska, J. B. Brink, and J. J. Abbott, "First Demonstration of a Modular and Reconfigurable Magnetic-Manipulation System," IEEE Int. Conf. Robotics and Automation, 2015 (to appear). 
% A. J. Petruska, A. W. Mahoney, and J. J. Abbott, "Remote Manipulation with a Stationary Computer-Controlled Magnetic Dipole Source," IEEE Trans. Robotics, 30(5):1222-1227, 2014. 
% A. J. Petruska and J. J. Abbott, "Omnimagnet: An Omnidirectional Electromagnet for Controlled Dipole-Field Generation," IEEE Trans. Magnetics, 50(7):8400810(1-10), 2014. 
% Link: http://www.telerobotics.utah.edu/index.php/Research/Omnimagnets

function [ currX, currY, currZ ,Task] = rollBallInCircle(wHb,radius,T,dt,speed,ballsize)
%Print Task Name
Task = 'Running Roll Ball in Circle';
%---------------------
% rollBallInCircle Returns the Circle path to follow
%
%   rollBallInCircle() 
%   "Returns a path of a Circle shape with a radius length of 1"
%   
%   rollBallInCircle(x0,y0,phi,psi,radius) 
%   "Returns a path of a Circular shape with an init position and orientation 
%    and far radius 'x0' 'y0' 'phi' 'psi' & 'radius' "
%
%   rollBallInCircle(x0,y0,phi,psi,radius,T,dt) 
%   "Returns a path of a Circular shape with an init position and orientation 
%    and far radius 'x0' 'y0' 'phi' 'psi' & 'radius' "
%    with Time to completion and timestep 'T' & 'dt' "
%
%   [ currX, currY, currZ ] = rollBallInCircle(x0,y0,phi,psi,radius,T,dt,speed,ballsize) 
%   "Returns a path of a Circular shape with an init position and orientation 
%    and far radius 'x0' 'y0' 'phi' 'psi' & 'radius' "
%    with Time to completion and timestep 'T' & 'dt' 
%    with ball-size and video speed 'ballsize' 'speed'"
%
% EX___  
%   [ currX, currY, currZ ] = rollBallInCircle(0,0,pi,pi,1,10,0.1,1,1);
%

%% rollBallInCircle
% Enough Inputs EXCEPTION
if nargin == 0||nargin == 5||nargin == 7||nargin == 9
    % Default Variables 
    %% 0 Input 
    if nargin == 0
        % init x
        x0 = 10;
        % init y
        y0 = 0;
        % Init pos
        p0 = [x0;y0;0];
        % init latitude
        phi = 0;
        % init longitude
        psi = 0;
        % Init rot vector(rotation in world-z then magnetic-y)
        R0 = roty(phi)*rotz(psi);
        % Init Homgeneous 
        wHb = [R0,p0;0 0 0 1];
        % radius of circle
        radius = 10;
        % speed of video
        speed = 1;
        % tool size
        ballsize = 1;
        % time to completion
        T = 10;
        % time step at which to reccord
        dt = 0.1;
    end
    %% 5 Input 
    if nargin == 0
        % time to completion
        T = 10;
        % time step at which to reccord
        dt = 0.1;    
        % speed of video
        speed = 1;
        % tool size
        ballsize = 1;
    end
    %% 7 Input 
    if nargin == 0
        % speed of video
        speed = 1;
        % tool size
        ballsize = 1;
    end
    % Column of Homogeneous
        %xcol= 0;
        %ycol= 4;
        %zcol= 8;
        pcol= 12; 
    % ----------------------
    
    %% rollBallInCircle
    % Initiate current vectors
    currX = [];
    currY = [];
    currZ = [];

    % Angle Step size
    del = 2*pi/(T/dt);
    
    % Full Cirlce
    for Q = 0:del:2*pi
        % Pos current
        pos2 = [radius*cos(Q);radius*sin(Q);0];
        if isnan(wHb(pcol+1:15))==0
            % Time to completion point to point movement
            T = dt;
            % add 4 steps between points
            dt = dt/4;
            % Use ballfwd Control
            [ currx, curry, currz, wHb] = ballfwd(wHb,pos2,T,dt,speed,ballsize);
            % Set Required Current Vecotrs 
            currX = [currX;currx];
            currY = [currY;curry];
            currZ = [currZ;currz];
        end
    end
else
    ERROR = 'Not Enough Input Arguments';
    display(ERROR);
end
end

