%% Draw a sphere magnet
%%                      Author: Mohamed K. Ghori B.S. M.E.
%                      ------------------------------------
% 
% Acknowledgements:
%


function [Task] = drawmagnetball( )
%Print Task Name
Task = 'Running ';
%---------------------
% INSTRUCTIONS
%{
% Call function to create a 3D representation of the magnet sphere used
in the ominmagnet experiemnt
%}

% Enough Inputs EXCEPTION
if nargin == 0

    %% Draw Sphere
    % Title of Figure
    title('Ball Model')
    % Sphere vectors
    [x,y,z] = sphere;
    % Image of Magnet
    I = imread('capture.png');
    % Map Image
    warp(x,y,z,I);
    % Set axis size & limits
    axis([-20 20 -20 20 -5 5])
    % Set the viewing angle
    view(-135, 40)
    % Label the axes.
    xlabel('x0 (m)')
    ylabel('y0 (m)')
    zlabel('z0 (m)')
    % Turn on Grid
    grid on
    % equal axis view
    axis equal;
    
else
    ERROR = 'Not Enough Input Arguments';
    display(ERROR);
end
end

