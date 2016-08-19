%% show magnetic field for certain Omnimagnet Current values 
%%                      Author: Mohamed K. Ghori B.S. M.E.
%                      ------------------------------------
% 
% Acknowledgements:
%

function [ Task ] = magfield(I)
%Print Task Name
Task = 'Running Show MAG Field';
%---------------------
% Display magntic vector field for specific set of currents for the Omnimagnet  
%   magfield(I)
%   Call with input current vector applied to Omnimagnet
%
% EX__
%  [Task] = magfield([1,0,0]);
%   
% Compact Text Format
format compact

%% magfield
% Enough Inputs EXCEPTION
if nargin == 1
    % Mapping of Magnetic Field to Current Based on Physical 
    K = eye(20);
    %% Eqn I => B
    % position of the ball center
    for k = -1:0.1:1
        for j = -1:0.1:1
            for i = -1:0.1:1
            % pose 
            pos = [i,j,k];
            % pose unit vector
            p_hat = pos/norm(pos);
            % Attributes of Solenoid
            M = [25.1 0 0;0 25.8 0; 0 0 26.3];
            % Constant of Permeability
            mu = 4*(10^-7)*pi;
            % Eqn parts for B => I 
            temp = (2*pi/mu)*(norm(pos)^3)*((3*p_hat*(p_hat') - 2*eye(3)));
            % Current Vector
            B = inv(temp)*I;
            % Direction of B
            if norm(B)>0
                arr = [0;0;0];
            else
                arr = B/norm(B);
            end
            % Show magnectic field vector
            quiver3(pos(1), pos(2), pos(3),arr(1),arr(2),arr(3));            
            drawnow
            hold on
            end
        end
    end
else
    display('ERROR: Not Enough Input Arguments');
end
end

