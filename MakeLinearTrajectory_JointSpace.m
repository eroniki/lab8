%% Initialization
clear all; close all; clc;
%% Conditions and 
q = [0,0,3; 0.17, -0.2, 3.5; -0.6, -1.05, 2];
[m, ~] = size(q);
q_dot = [1.2, 0.9, 1.7];
%% Find Trajectory for each joint
trajectory = q(1, :);
for i=1:m
    first = i;
    next = mod(i+1, m+1);
    if next == 0
        next = 1;
    end
    q_current = q(first, :);
    q_next = q(next, :);
    d = q_next - q_current;
    tmin = abs(d)./ q_dot;
    [tmax, maxId] = max(tmin);
    q_dot_modified = d ./ tmax;
    step_size = 0.001 * q_dot_modified;
    traj_q = LinearTrajectory(q_current, q_next, step_size);
    trajectory = [trajectory; traj_q];
end

%% Plot the trajectories
[t_k, ~] = size(trajectory);
% Joint 1
subplot(311);
plot(1:t_k, trajectory(:, 1), 'r-*');
grid minor;
% Joint 2
subplot(312);
plot(1:t_k, trajectory(:, 2), 'r-*');
grid minor;
% Joint 3
subplot(313);
plot(1:t_k, trajectory(:, 3), 'r-*');
grid minor;