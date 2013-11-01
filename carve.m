function [ ri ] = carve( fi, seam )
%CARVE takes a frame and a seam, returns a new frame
% fi is a n-by-m matrix, seam should be a n-dim vector, storing the index
% of the pixel to be removed at each row
% CAN work with images of different number of channels

n = size(fi, 1);
m = size(fi, 2);

ri = zeros([n m-1 size(fi,3)]);
for i = 1:n
  ri(i,1:(seam(i)-1),:) = fi(i,1:(seam(i)-1),:);
  ri(i,seam(i):(m-1),:) = fi(i, (seam(i)+1):m,:);
end

end