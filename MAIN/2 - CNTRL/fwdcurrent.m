%% Converts Current to Change in Orientation and Position
%                           Author: Mohamed Ghori
%                          -----------------------
% Reference Material: 
% A. J. Petruska, J. B. Brink, and J. J. Abbott, "First Demonstration of a Modular and Reconfigurable Magnetic-Manipulation System," IEEE Int. Conf. Robotics and Automation, 2015 (to appear). 
% A. J. Petruska, A. W. Mahoney, and J. J. Abbott, "Remote Manipulation with a Stationary Computer-Controlled Magnetic Dipole Source," IEEE Trans. Robotics, 30(5):1222-1227, 2014. 
% A. J. Petruska and J. J. Abbott, "Omnimagnet: An Omnidirectional Electromagnet for Controlled Dipole-Field Generation," IEEE Trans. Magnetics, 50(7):8400810(1-10), 2014. 
% Link: http://www.telerobotics.utah.edu/index.php/Research/Omnimagnets

function [ wHb, Task] = fwdcurrent(I0, If,wHb,T,dt,speed,ballsize)
%Print Task Name
Task = 'Running Current to Step';
%---------------------
%
% fwdcurrent first rotates the ball such that the y-axis of coresponding to
% the orientatoin of the initial and final vector of the 3-solenoid-currents
% coincide second it rolls the ball about the y axis such that the x&z-axies
% coincide 
%
%   [ pf, wRb ] = fwdcurrent(I0, If,p0,wRb,T,dt,speed,ballsize)
%   "Returns the resultant position and orientation of the ball
%    when the solnoid-currents change from an Inital to a final state 
%    given this initial and final solenoid-current state the current
%    orientatoin, a time to completion and time step, and ballsize and 
%    speed of the video:
%    'I0' & 'If' , 'p0' & 'wRb' , 'T' & 'dt' , 'speed' & 'ballsize' 
%
% EX___
%   [ pf, wRb ] = fwdcurrent([1;2;3], [4;;6],[0;0;0],eye(3),10,0.1,1,1)
%   
% Column of Homogeneous
        %xcol= 0;
        %ycol= 4;
        %zcol= 8;
        pcol= 12; 
    % ----------------------
    
%% fwdcurrent
% Enough Inputs EXCEPTION
if nargin == 7
        %% Find Rotation
        % Initial Orientation
        [phi1, psi1] = fwdMagneticField( I0(1), I0(2), I0(3), wHb(pcol+1), wHb(pcol+2));
        % Final Orientation
        [phi2, psi2] = fwdMagneticField( If(1), If(2), If(3), wHb(pcol+1), wHb(pcol+2));
        % Rotation about world-z-axis
        psi = psi2 -psi1;
        % Rotation about world-y-axis (negativd phi2 due to backward rotation)
        phi = -phi2+phi1;
    % If there is no change in orientation
    if phi==0 && psi == 0
    else
        %% Single Angle Rotation
        % Current Rotation Matrix
        R = rotz(psi)*roty(phi);
        % Trace of current rotation matrix from magent-field to world
        tau = trace(R);
        % Unit vector of axis of rotation
        u_hat = (1/sqrt((1+tau)*(3-tau)))*[R(6)-R(8);R(7)-R(3);R(4)-R(2)];
        % angle of rotatoin
        th = acos((tau-1)/2);
        % average agular velocity 
        omega = th/T;
        % Number of steps to show in visual
        reps = floor(T/dt);
        % set current position
        step = wHb(pcol+1:15)';
        % direction of linear movemnt
        direction = [u_hat(1:2);0];
        % vector to skew symmetric matrix
        u_skew = vect2skew(u_hat);
        % Use rodruigez formula to rotate about singular axis
        Rot = (eye(3)*cos(omega*dt)+u_hat*u_hat'*(1-cos(omega*dt))+u_skew*sin(omega*dt));
        % Set Current Homogeneous Matrix
        Hcurr = wHb;  
        % linear velocity
        vel = omega*ballsize*direction;
        
        %% debugging 
        if isnan(direction(1))
            %puase();
        end
        %%
        
        for n = 1:reps
            % step forward
            step = step + vel*dt;
            Hcurr(pcol+1:15) = step;
            Hcurr(1:3,1:3) = Hcurr(1:3,1:3)*Rot;
            % vsiualization
            plot_ball(ballsize,Hcurr,dt,speed)
            % Magnetic Field Visualization
            showmagfield(I0(1),I0(2),I0(3),wHb(pcol+1:15)');
            
        end
            % Resultant Orientation
            Rot = (eye(3)*cos(th)+u_hat*u_hat'*(1-cos(th))+u_skew*sin(th));
            % Resultant Pos
            wHb(pcol+1:15) = wHb(pcol+1:15)' + vel*T;
            wHb(1:3,1:3) = wHb(1:3,1:3)*Rot;
            % visualization
            plot_ball(ballsize,wHb,dt,speed)
    end
    
else
    ERROR = 'Not Enough Input Arguments';
    display(ERROR);
end
end

