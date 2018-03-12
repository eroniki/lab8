function [trajectory] = LinearTrajectory(q_current, q_next, step_size)
cond = 1;
trajectory = q_current;
while cond
    cand = trajectory(end, :) + step_size;
    if sum(cand>q_next)
        cond = 0;
        for i=1:3
            if sign(step_size(i))
                cand(i) = min(cand(i), q_next(i)); 
            else
                cand(i) = max(cand(i), q_next(i)); 
            end
        end
   end
   trajectory = [trajectory; cand];
end
trajectory(1, :) = [];

if ~prod(equality_double(trajectory(end, :), q_next))
    trajectory(end, :) = q_next;
end
end


function t = equality_double(A, B)
    t = abs(A-B) < 1e-12*ones(size(A));
end
