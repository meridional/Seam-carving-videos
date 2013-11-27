function s = saliency(fi)
% saliency function
% takes a frame
% returns a matrix of saliency values

%kernel = [1 2 1; 0 0 0 ; -1 -2 -1];

%gy = conv2(fi, kernel, 'same');
%gx = conv2(fi, kernel', 'same');
[gx, gy] = gradient(fi);
s = sqrt(gy.^2 + gx.^2);

end
