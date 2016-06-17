%% Return Homogeneous Matrix at Position (pos) and Rotation (rpy)
% INSTRUCTIONS
%{
% Call with new Position Vector & Roation Vector
% Creates a Homogeneous Vector using euler angles in current perspective
%}
function H = HomoMatrix(rpy,pos)
%Print Task Name
Task = 'Creating Homogeneous Matrix'
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
    Rx = eye(3);
end
if isnan(rpy(2))==0
    w = rpy(2);
    Ry = [cos(w) 0 sin(w); 0 1 0; -sin(w) 0 cos(w)];
else
    Ry = eye(3);
end
if isnan(rpy(3))==0
    w = rpy(3);
    Rz = [cos(w) -sin(w) 0; sin(w) cos(w) 0; 1 0 0];
else
    Rz = eye(3);
end

% Final Rotationn
R = Rx*Ry*Rz;

% Final Homogeneous Transformation
H = [R,pos;[0 0 0 1]];
end