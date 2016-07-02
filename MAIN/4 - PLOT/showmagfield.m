%% Visualization for the Magnetic field line from the Omnimagnet to the Magnet-tool 
%%                      Author: Mohamed K. Ghori B.S. M.E.
%                      ------------------------------------
% 
% Acknowledgements:
%

%% NOTE: NOT TESTED TO WORK
function [ Task ] = showmagfield( currx,curry,currz,p0)
%Print Task Name
Task = 'Running Show Magnetic Field';
%---------------------
% INSTRUCTIONS
%{
% PUT INFO ON HOW TO USE FUNCTION
%}

% Enough Inputs EXCEPTION
if nargin == 0
    % Step size between quivers
    delp = 1; 
    % Initialize posB (Position of Quiver)
    posB = p0;
    % Draw 200 quivers to outline magnetic field lines
    for n = 0:200
        % Magnetic Field Value at position
        B = fwdMagneticField(curra,currb,currc,p0(1),p0(2));
        % Direction of Magnetic Field line
        direction = B/norm(B);
        % Draw arrow tangent to magnetic field line
        quiver(direction(1),direction(2),posB(1),posB(2));
        % Iterate through positions along the magnetic field line
        posB = direction*delp+posB;
    end
else
    ERROR = 'Not Enough Input Arguments'
end
end
