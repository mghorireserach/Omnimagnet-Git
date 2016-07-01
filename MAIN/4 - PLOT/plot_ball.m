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
end
    % Circles
    
    vectsize = size(x);

    x = 0:0.001:2*pi;
    a = cos(x)*s+s;
    b = sin(x)*s*20;
    plot(a,b)

    x = 0:0.001:2*pi;
    a = cos(x)*s-s;
    b = sin(x)*s*20;
    plot(a,b)

    x = 0:0.001:2*pi;
    a = cos(x)*s;
    b = sin(x)*s;
    plot(a,b)

    x = 0:0.001:2*pi;
    a = cos(x)*s*1.5;
    b = sin(x)*s*1.5;
    plot(a,b)
else
    %% Draw Sphere
    [x,y,z] = sphere;
    % Draw Function
    % set(s(1), 'xdata',ballsize*x+x0 ,'ydata', ballsize*y+y0,'zdata',ballsize*z+ballsize)
<<<<<<< HEAD
    s = mesh(ballsize*x+pos(1),ballsize*y+pos(2),ballsize*z+ballsize,'FaceColor',[1 0 0]);
    colormap 'hsv'
=======
    s = mesh(ballsize*x+pos(1),ballsize*y+pos(2),ballsize*z+ballsize);
    colormap hsv
>>>>>>> parent of b322448... Show Magnetic Field
    alpha(.1)
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
    
    %% sets time delay
    pause(dt/speed);
    
    %% makes prvious ball invisible & Marks Position
    % Ball Visibility
    set(s,'visible','off')
    set(a,'visible','off')
    set(b,'visible','off')
    set(c,'visible','off')
    % Draws a red dot to denote poition already visited
    scatter3(pos(1),pos(2),0,'.','red')
end   
end

