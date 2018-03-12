%% Initialization
clear all; close all; clc;
%% Conditions and 
pos = [0.04, 0.007, -.0015; 0.0011, 0.048, 0; 0.06, 0.05, -.07];
[m, ~] = size(pos);
pos_dot = [0.2, 0.15, 0.12];
%% Find Trajectory for each joint
trajectory = pos(1, :);
for i=1:m
    first = i;
    next = mod(i+1, m+1);
    if next == 0
        next = 1;
    end
    pos_current = pos(first, :);
    pos_next = pos(next, :);
    d = pos_next - pos_current;
    tmin = abs(d)./ pos_dot;
    [tmax, maxId] = max(tmin);
    pos_dot_modified = d ./ tmax;
    step_size = 0.001 * pos_dot_modified;
    traj_pos = LinearTrajectory(pos_current, pos_next, step_size);
    trajectory = [trajectory; traj_pos];
end

%% Plot the trajectories
plot3(trajectory(:,1),trajectory(:,2),trajectory(:,3))
view(-38,10)