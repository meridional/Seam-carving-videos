function [sh] = spatioh(fi)
% spatioh - takes a frame
% returns a matrix of horizonal costs

% TODO: actual implementation

n = size(fi,1);
m = size(fi,2);
d = [zeros([n 1]) fi(:,1:(m-1))];
f = [fi(:,2:m) zeros([n 1])];

% middle part
sh = abs(fi-d) + abs(fi - f) + abs(d - f);

% boundaries
sh(:,1) = abs(abs(fi(:,1)-fi(:,2)) - abs(fi(:,2)-fi(:,3)));
sh(:,m) = abs(abs(fi(:,m)-fi(:,m-1)) - abs(fi(:,m-1)-fi(:,m-2)));
end