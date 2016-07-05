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

function [Task] = plot_ball(ballsize,H,dt,speed)
%Print Task Name
Task = 'Running Plot Magnet Ball';
%---------------------
persistent I s
% Column of Homogeneous
        xcol= 0;
        ycol= 4;
        zcol= 8;
        pcol= 12; 
    % ----------------------
    
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
    
%% Omnimagnet Representation  Credit: Husam Aldahiyat Date 5 Sep, 2008 13:44:02 
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

%% Cylinder
    %Top of cylinder magnet
    x = 0:0.001:2*pi;
    Tx = cos(x);
    Ty = sin(x);
    sizex = size(x);
    Tz = 2*ones(sizex(2),1)+s/2-1;
    Cil(2) = fill3(Tx,Ty,Tz,'r');
    
    Bx = cos(x);
    By = sin(x);
    sizex = size(x);
    Bz = zeros(sizex(2),1)+s/2-1;
    Cil(1) = fill3(Bx,By,Bz,'b');
    
    [Cx,Cy,Cz] = cylinder(1);
    Cz = 2*Cz+s/2-1;
    MAT = [Cx; Cy; Cz]; 
    I = imread('capture.png');
    Cil(3) = warp(Cx,Cy,Cz,I);
    
    %% Draw Sphere
    [x,y,z] = sphere;   
    % Draw Function
    % Size Ball Tool
    x = ballsize*x;
    y = ballsize*y;
    z = ballsize*z;
    % Map Image
    S(1) = warp(x,y,z,I);
    alpha(S(1),0.2)
    %% Draw Arrow Pointing North(magnet-Z-Axis) & AxisOfRolling(magnet-Y-Axis)
    % Axis Vectors
    Arr(7:9)= [0 0 5*ballsize]; %4*ballsize*H(zcol+1:zcol+3);
    Arr(4:6)= [0 2*ballsize 0];%2*ballsize*H(ycol+1:ycol+3);
    Arr(1:3)= [ballsize 0 0];%2*ballsize*H(xcol+1:xcol+3);
    % Axis Center
    pos = [0 0 0] %H(pcol+1:15)';
    % Draw z-Arrow
    S(2) = quiver3(pos(1),pos(2),pos(3)+ballsize,Arr(7),Arr(8),Arr(9));
    % Draw y-Arrow
    S(3) =  quiver3(pos(1),pos(2),pos(3)+ballsize,Arr(4),Arr(5),Arr(6));
    % Draw x-Arrow
    S(4) = quiver3(pos(1),pos(2),pos(3)+ballsize,Arr(1),Arr(2),Arr(3));
    % Construct Transform Object
    s = hgtransform;
    % Set Transform Object as parent
    set(S,'Parent',s);
    
    
else
    %% Draw Sphere
    % Apply transformation
    set(s,'Matrix',H);
    % Show in Figure
    drawnow
    %{
    %% Draw Arrow Pointing North(magnet-Z-Axis) & AxisOfRolling(magnet-Y-Axis)
    % Axis Vectors
    R(7:9)= 4*ballsize*H(zcol+1:zcol+3);
    R(4:6)= 2*ballsize*H(ycol+1:ycol+3);
    R(1:3)= 2*ballsize*H(xcol+1:xcol+3);
    % Axis Center
    pos = H(pcol+1:15)';
    % Draw z-Arrow
    h(1) = quiver3(pos(1),pos(2),pos(3)+ballsize,R(7),R(8),R(9));
    % Draw y-Arrow
    h(2) =  quiver3(pos(1),pos(2),pos(3)+ballsize,R(4),R(5),R(6));
    % Draw x-Arrow
    h(3) = quiver3(pos(1),pos(2),pos(3)+ballsize,R(1),R(2),R(3));
    
    %}
    %% sets time delay "causes warning in first run"
    pause(dt/speed);
    
    
    %% makes prvious ball invisible & Marks Position
    %delete(h);
    %delete(s);
    pos = H(pcol+1:15)';
    % Draws a red dot to denote poition already visited
    scatter3(pos(1),pos(2),0,'.','red')

end   
end

