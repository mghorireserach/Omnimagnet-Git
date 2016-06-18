%% Rotation Matrix
% Author: Mohamed Ghori
%INSTRUCTIONS
%{
% Call using roll pitch yaw
%}
function [ R ] = RotMatrix(rpy)
%Print Task Name
Task = 'Returning Make Rotation Matrix'
%---------------------

% Setting Rotation to zero    
Rx = 1;
Ry = 1;
Rz = 1;

% Finiding Rotations in x,y,z
if isnan(rpy(1))==0
    w = rpy(1);
    Rx = [1 0 0; 0 cos(w) -sin(w); 0 sin(w) cos(w)];
else
    Rx = eye(3)
end
if isnan(rpy(2))==0
    w = rpy(2);
    Ry = [cos(w) 0 sin(w); 0 1 0; -sin(w) 0 cos(w)];
else
    Rx = eye(3)
end
if isnan(rpy(3))==0
    w = rpy(3);
    Rz = [cos(w) -sin(w) 0; sin(w) cos(w) 0; 1 0 0];
else
    Rx = eye(3)
end

% Final Rotationn
R = Rx*Ry*Rz;

end

