function tc = temporal(fi, prev_seam)
% takes a frame, a seam from the previous frame
% returns a matrix of temporal cost

%m = size(fi, 2);
rc = carve(fi, prev_seam);
%il = zeros(size(fi));
%ir = zeros(size(fi));
pad = zeros([size(fi,1) 1]) ;
il = [pad cumsum((fi(:,1:end-1) - rc).^2,2)];
%for i = 2:m
  %il(:,i) = il(:,i-1) + (fi(:,i-1)-rc(:,i-1)).^2;
%end
%sum(sum(il == ill))
ir = [fliplr(cumsum((fi(:,end:-1:2) - rc(:,end:-1:1)).^2,2)) pad];
%for i = (m-1):-1:1
 % ir(:,i) = ir(:,i+1) + (fi(:,i+1)-rc(:,i)).^2;
%end
%sum(sum(ir ~= irr))
tc = ir + il;
end
