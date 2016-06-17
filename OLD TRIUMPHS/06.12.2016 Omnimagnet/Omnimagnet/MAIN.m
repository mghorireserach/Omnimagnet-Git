%% This is the Main Function that runs all other functions 
% INSTRUCTIONS
%{
% This is the main function where any comands can be written
%}

function MAIN( )
%Print Task Name
Task = 'Running Main Function'
%---------------------

% Ball Size
size = 1;
% Period
T = 10
% Time Step
dt = 0.1;
% Corner 
corner = [10;10];
% Radius
Radius = 10;
% Initial Position
p0 = [5;5;0]




% Initi Graphing Area with ball size of 1
plot_ball(1);
% Roll ball in square
[currx, curry, currz] = rollBallInCircle(p0(1),p0(2),0,0,Radius,T,dt);

% Play it Back
playback(p0,currx,curry,currz,size,speed,T,dt);


end

