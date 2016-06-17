%% This is the Main Function that runs all other functions 
% INSTRUCTIONS
%{
% This is the main function where any comands can be written
%}

function MAIN( )
%Print Task Name
Task = 'Running Main Function'
%---------------------

%% Ball Params
% Ball Size
ballsize = 1;
% Initial Position
x0 = 5;
y0 = 0;
% Init Roty(latitude)
phi = 0;
% Init Rotz(longitude)
psi = 0;

%% Video Params
% Period
T = 10
% Time Step
dt = 0.1;
% Video Speedx
speed = 1;

%% Specific Params
% Corner(square) 
corner = [10;10];
% Radius(circle)
Radius = 5;

%% Initi Graphing Area with ball size of 1
plot_ball(1);

%% Roll ball in square
[currx, curry, currz] = rollBallInSquare(y0,x0,phi,psi,corner,speed,ballsize,T,dt)

%% Play it Back
%playback(p0,currx,curry,currz,ballsize,speed,T/4,dt);


end

