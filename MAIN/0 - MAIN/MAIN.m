%% This is the Main Function that Runs all other functions for the Omnimagnet Simulation
%                           Author: Mohamed Ghori
%                          -----------------------
% Reference Material: 
% A. J. Petruska, J. B. Brink, and J. J. Abbott, "First Demonstration of a Modular and Reconfigurable Magnetic-Manipulation System," IEEE Int. Conf. Robotics and Automation, 2015 (to appear). 
% A. J. Petruska, A. W. Mahoney, and J. J. Abbott, "Remote Manipulation with a Stationary Computer-Controlled Magnetic Dipole Source," IEEE Trans. Robotics, 30(5):1222-1227, 2014. 
% A. J. Petruska and J. J. Abbott, "Omnimagnet: An Omnidirectional Electromagnet for Controlled Dipole-Field Generation," IEEE Trans. Magnetics, 50(7):8400810(1-10), 2014. 
% Link: http://www.telerobotics.utah.edu/index.php/Research/Omnimagnets

function [curra, currb, currc, type,Task] =  MAIN(type,x0,y0,phi,psi,ShapeSize,T,dt,speed,ballsize)
%Print Task Name
Task = 'Running Main Function';
%---------------------
format compact
% Main calls the shape function that generates a vector of current values
% for each solenoid. These current values in combination corespond to 
% orienations the magnetic field adopted at diffrent points along the
% desired trajectory. 
%
%   MAIN() 
%   "Returns a path of random shape with a defining size of 1 unit"
%   
%   MAIN(type) 
%   "Returns a path of shape(1=Square)(2=Circle) with a 
%    defining size of 1"
%   
%   MAIN(type,x0,y0,phi,psi,ShapeSize) 
%   "Returns a path of shape(1=Square)(2=Circle) with
%    an initital position and orientation and defining size of 'x0' 'y0' 'phi' 
%    'psi' & 'ShapeSize' "
%
%   MAIN(type,x0,y0,phi,psi,ShapeSize,T,dt) 
%   "Returns a path of shape(1=Square)(2=Circle) 
%    with an inititial position and orientation and defining size 
%    of 'x0' 'y0' 'phi' 'psi' & 'ShapeSize' 
%    and with a Time to completion and timestep of 'T' & 'dt' "
%
%   MAIN(type,x0,y0,phi,psi,ShapeSize,T,dt,speed,ballsize) 
%   "Returns a path of shape(1=Square)(2=Circle) 
%    with an inititial position and orientation and defining size 
%    of 'x0' 'y0' 'phi' 'psi' & 'ShapeSize' 
%    and with Time to completion and timestep of 'T' & 'dt' 
%    and with ball-size and video speed of 'ballsize' 'speed'"
%
% EX___  
%   MAIN(2,0,0,pi,pi,[10;10],10,0.1,1,1);
%

%% MAIN
% Enough Inputs EXCEPTION
if nargin == 0||nargin == 1||nargin == 6||nargin == 8||nargin == 10
    %% Add Paths 
    % MATLAB add path function
    addpath(genpath('C:\Users\alighori\Documents\2) MENU\1) OCCUPATION\JOBS\JOB(05.26.2016) - RA (Dr. Aaron Becker)\Test Project (Omni-Magnet & Magnet Ball)\MATLAB CODE\Omnimagnet_GIT\Omnimagnet-Git\MAIN'))
    %addpath('MATH-ROT','MATH-QUAT','MATH-THETA','MATH-HOM','CNTRL','PLOT','SHAPES','MAIN');
    
    %% Init Graph
    if nargin ==10
        plot_ball(ballsize);
    else
        plot_ball(1);
    end
%% Following Shape
    %% 0 Param "Blind"
    % check input 
    if nargin ==0 
        % randomly chose a shape (1-rectangle 2-circle)
        a = ceil(2*rand);
        % assign shapee
        if a==1
            % run rectangular trajectory 
            [curra, currb, currc,p0] = rollBallInSquare();
            % playback trajectory
            playback(curra,currb,currc,p0);
        else
            % run Circle trajectory
            [curra, currb, currc,p0] = rollBallInCircle();
            % playback trajectory
            playback(curra,currb,currc,p0);
        end
    end

    %% 1 Param "Given Path Shape"
    % check input 
    if nargin == 1
        if type==1
            % run rectangle trajectory
            [curra, currb, currc,p0] = rollBallInSquare();
            % playback trajectory
            playback(curra,currb,currc,p0);
        else
            % run circle trajectory
            [curra, currb, currc,p0] = rollBallInCircle();
            % playback trajectory
            playback(curra,currb,currc,p0);
        end
    end

    %% 6 Param "Given Path Shape, & Path Parameters"
    % check input 
    if nargin ==6
        if type==1
            % run rectangle trajectory (specified rectangle)
            [curra, currb, currc,p0] = rollBallInSquare(x0,y0,phi,psi,ShapeSize);
            % playback trajectory
            playback(curra,currb,currc,p0);
        else
            % run circle trajectory (specified circle)
            [curra, currb, currc,p0] = rollBallInCircle(x0,y0,phi,psi,ShapeSize);
            % playback trajectory
            playback(curra,currb,currc,p0);
        end
    end
    

    %% 8 Param "Given Path Shape, Path Params, & Time Params"
    % check input 
    if nargin == 8
        if type==1
            % run rectangle trajectory (specified rectangle, Time to complete & time step to reccord)
            [curra, currb, currc,p0] = rollBallInSquare(x0,y0,phi,psi,ShapeSize,T,dt);
            % playback trajectory
            playback(curra,currb,currc,p0,T,dt);
        else
            % run circle trajectory (specified Circle, Time to complete & time step to reccord)
            [curra, currb, currc,p0] = rollBallInCircle(x0,y0,phi,psi,ShapeSize,T,dt);
            % playback trajectory
            playback(curra,currb,currc,p0,T,dt);
        end
    end

    %% 10 Param "Given Path Shape, Path Params, & Time Params, Video Params"
    % check input 
    if nargin == 10
        if type==1
            % run rectangle trajectory (specified rectangle, Time to complete & time step to reccord,tool size & speed of video)
            [curra, currb, currc,p0] = rollBallInSquare(x0,y0,phi,psi,ShapeSize,T,dt,speed,ballsize);
            % playback trajectory
            playback(curra,currb,currc,p0,T,dt,speed,ballsize);
        else
            % run circle trajectory (specified Circle, Time to complete & time step to reccord,tool size & speed of video)
            [curra, currb, currc,p0] = rollBallInCircle(x0,y0,phi,psi,ShapeSize,T,dt,speed,ballsize);
            % playback trajectory
            playback(curra,currb,currc,p0,T,dt,speed,ballsize);
        end
    end
    
%% Write Solenoid-Current Values to MS-Excel File    
% create File
filename = 'currentdata.xlsx';
% write curra (inner solenoid)
xlswrite(filename,curra,'currx','A1');
% write currb (middle solenoid)
xlswrite(filename,currb,'curry','A1');
% write currc (Outer solenoid)
xlswrite(filename,currc,'currz','A1');

else
    ERROR = 'Not Enough Input Arguments';
    display(ERROR);
end

end

