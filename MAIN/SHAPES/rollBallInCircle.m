%% This function is intended to Roll a Magnet Ball in A Circle
% Author: Mohamed Ghori
% Reference Material: 
% A. J. Petruska, J. B. Brink, and J. J. Abbott, "First Demonstration of a Modular and Reconfigurable Magnetic-Manipulation System," IEEE Int. Conf. Robotics and Automation, 2015 (to appear). 
% A. J. Petruska, A. W. Mahoney, and J. J. Abbott, "Remote Manipulation with a Stationary Computer-Controlled Magnetic Dipole Source," IEEE Trans. Robotics, 30(5):1222-1227, 2014. 
% A. J. Petruska and J. J. Abbott, "Omnimagnet: An Omnidirectional Electromagnet for Controlled Dipole-Field Generation," IEEE Trans. Magnetics, 50(7):8400810(1-10), 2014. 

% INSTRUCTIONS
%{              
%               Init-x(x0) Init-y(y0) Init-phi(phi) Init-psi(psi) 
%               NOTE: "Init position and Orientation"
%               Radius of circle(radius)
%               NOTE: "radius off circle about origin"
%               Period(T) Time-Step(dt)
%               NOTE: "The total time to complete the square and the number
%                      of steps to be displayed"
%}

function [ currX, currY, currZ ] = rollBallInCircle( x0, y0, phi, psi,radius,speed,ballsize,T,dt)
%Print Task Name
Task = 'Running Roll Ball in Circle'
%---------------------
% Initiate current vectors
currX = [];
currY = [];
currZ = [];

% First Orientation
wRb = rotz(psi)*roty(phi);

% Angle Step size
del = 2*pi/(T/dt);

pos1 = [x0;y0;0];
% Full Cirlce
for Q = 0:del:2*pi
    % Pos current
    pos2 = [radius*cos(Q);radius*sin(Q);0]
    if isnan(pos1)==0
    % Use ballfwd Control
    [ currx, curry, currz, wRb] = ballfwd(dt,pos1,pos2,wRb,dt,speed,ballsize);
    % Set Required Current Vecotrs 
    currX = [currX;currx];
    currY = [currY;curry];
    currZ = [currZ;currz];
    end
    % set Old pos
    pos1 = pos2
end

end

