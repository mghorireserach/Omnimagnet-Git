function [quat] = quat_mult(a,b)
%Print Task Name
Task = 'Running Quat_Mult'
%---------------------
    %% Hamiltonian Multiplier
    quat = [a(1)*b(1)-a(2)*b(2)-a(3)*b(3)-a(4)*b(4);...
            a(1)*b(2)+a(2)*b(1)+a(3)*b(4)-a(4)*b(3);...
            a(1)*b(3)+a(2)*b(4)+a(3)*b(1)-a(4)*b(2);...
            a(1)*b(4)+a(2)*b(3)+a(3)*b(2)-a(4)*b(1)];

end
