function [ fi ] = carve( fi, seam )
%CARVE takes a frame and a seam, returns a new frame
% fi is a n-by-m matrix, seam should be a n-dim vector, storing the index
% of the pixel to be removed at each row
% CAN work with images of different number of channels

n = size(fi,1);
for i = 1:n
  fi(i,seam(i):end-1,:) = fi(i,seam(i)+1:end,:);
end
fi(:,end,:)=[];
end
