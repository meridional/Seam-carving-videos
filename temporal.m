function tc = temporal(fi, prev_seam)
% takes a frame, a seam from the previous frame
% returns a matrix of temporal cost

m = size(fi, 2);
rc = carve(fi, prev_seam);
il = zeros(size(fi));
ir = zeros(size(fi));
for i = 2:m
  il(:,i) = il(:,i-1) + (fi(:,i-1)-rc(:,i-1)).^2;
end

for i = (m-1):-1:1
  ir(:,i) = ir(:,i+1) + (fi(:,i+1)-rc(:,i)).^2;
end
tc = il+ir;
end