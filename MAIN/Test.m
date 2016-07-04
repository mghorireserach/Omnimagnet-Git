% Window Size
ax = axes('XLim',[-1.5 1.5],'YLim',[-1.5 1.5],'ZLim',[-1.5 1.5]);
% Make View 3D
view(3)
% Grid On
grid on
axis equal
% Cylinder size 0.2
[x,y,z] = cylinder([.1 0]);
[a, b, c] = cylinder([.1 .1]);
% Digitize Image
I = imread('ghoul.jpg');
J = imread('magnito.jpg');
% print image 
h(1) = warp(z,y,x,I);
%h(2) = warp(x+2,y,z,J);
%h(1) = surface(x,y,z,'FaceColor','red');
h(2) = surface(a,b,-c,'FaceColor','green');
%h(3) = surface(z,x,y,'FaceColor','blue');
%h(4) = surface(-z,x,y,'FaceColor','cyan');
%h(5) = surface(y,z,x,'FaceColor','magenta');
%h(2) = surface(y,z,x,'FaceColor','yellow');
t = hgtransform('Parent',ax);
set(h,'Parent',t)

Rz = eye(4);
Sxy = Rz;
for r = 0:.01:2*pi
    % Z-axis rotation matrix
    Ry = makehgtform('yrotate',r)
    % Scaling matrix
    %Sxy = makehgtform('scale',r/4);
    % Concatenate the transforms and
    % set the transform Matrix property
    set(t,'Matrix',Ry)
    drawnow
end
pause(1)
%set(t,'Matrix',eye(4))
clear all 
clc
