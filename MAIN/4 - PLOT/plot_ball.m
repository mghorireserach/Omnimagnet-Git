%% PLOT MAGNET BALL POSITION
% Author: Mohamed Ghori

% INSTRUCTIONS 
%{
% 2-Steps
% 1)Call plot_ball(ballsize) "with only the ballsize of the ball"
%   This creates the plot window
% 
% 2)Call plot_ball(x0,y0,ballsize,dt,speed) "with the current x,y-position &"
%                                       "the ballsize of the ball & "
%                                       "the time step & the scale"
%----------------------------------------------------------------------
%}

function [Task] = plot_ball(ballsize,pos,R,dt,speed)
%Print Task Name
Task = 'Running Plot Magnet Ball';
%---------------------
persistent h
%% Draw Sphere
if nargin ==1
    %% Creating Figure
    % Enforce that one unit is displayed 
    % equivalently in x, y, and z.
    axis equal;
    % Set the viewing volume
    % height : ensures ample height to see whole picture
    height = ballsize*5;
    % -x x -y y -z z step
    axis([-20 20 -20 20 -height 20])
    % Set the viewing angle
    view(-135, 40)
    % Label the axes.
    xlabel('x0 (m)')
    ylabel('y0 (m)')
    zlabel('z0 (m)')
    % Turn on Grid
    grid on
    % Title of Figure
    title('Ball Trajectory')
    hold on
    
% Omnimagnet Representation  Credit: Husam Aldahiyat Date 5 Sep, 2008 13:44:02 
    s=4;
    x=[-1 1  1 -1 -1 -1;...
        1 1 -1 -1  1  1;...
        1 1 -1 -1  1  1;...
       -1 1  1 -1 -1 -1]*s/2;
    
    y=[-1 -1 1  1 -1 -1;...
       -1  1 1 -1 -1 -1;...
       -1  1 1 -1  1  1;...
       -1 -1 1  1  1  1]*s/2;
    
   z=[0 0 0 0 0 1;...
      0 0 0 0 0 1;...
      1 1 1 1 0 1;...
      1 1 1 1 0 1]*s;
for i=1:6
    h=patch(x(:,i),y(:,i),z(:,i),'k');
    set(h,'edgecolor','r')
    alpha(h,0.1)
end

    % Circles
    x = 0:0.001:2*pi;
    Tx = cos(x);
    Ty = sin(x);
    sizex = size(x);
    Tz = 2*ones(sizex(2),1)+s/2-1;
    fill3(Tx,Ty,Tz,'r')
    
    Bx = cos(x);
    By = sin(x);
    sizex = size(x);
    Bz = zeros(sizex(2),1)+s/2-1;
    fill3(Bx,By,Bz,'b')
    
    [Cx,Cy,Cz] = cylinder(1);
    Cz = 2*Cz+s/2-1;
    MAT = [Cx; Cy; Cz];
    
    surf(Cx,Cy,Cz)
    I = imread('capture.png');
    warp(Cx,Cy,Cz,I);
    
    I = imread('capture.png');
    h =  warp(x,y,z,I);
    alpha(h,.25)
    h = hgtransform;
    

  
    
else
    %% Draw Sphere
    [x,y,z] = sphere;
    % Draw Function
    % set(s(1), 'xdata',ballsize*x+x0 ,'ydata', ballsize*y+y0,'zdata',ballsize*z+ballsize)
    x = ballsize*x+pos(1);
    y = ballsize*y+pos(2);
    z = ballsize*z+ballsize;
    %s = surf(x,y,z);
    Rot = [R,[0;0;0];0,0,0,1];
    set(h,'Matrix',Rot)
    drawnow
    %% Draw Arrow Pointing North(magnet-Z-Axis) & AxisOfRolling(magnet-Y-Axis)
    % Elongate Quiver
    R(7:9) = 4*ballsize*R(7:9);
    R(4:6) = 2*ballsize*R(4:6);
    % Draw z-Arrow
    a = quiver3(pos(1),pos(2),pos(3)+ballsize,R(7),R(8),R(9));
    % Draw y-Arrow
    b =  quiver3(pos(1),pos(2),pos(3)+ballsize,R(4),R(5),R(6));
    % Draw x-Arrow
    c = quiver3(pos(1),pos(2),pos(3)+ballsize,R(1),R(2),R(3));
    
    %% sets time delay "causes warning in first run"
    pause(dt/speed);
    
    %% makes prvious ball invisible & Marks Position
    delete(a);
    delete(b);
    delete(c);
    delete(h);
    % Draws a red dot to denote poition already visited
    scatter3(pos(1),pos(2),0,'.','red')
end   
end

