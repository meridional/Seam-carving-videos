img = imread('lake.jpg');
img = im2double(img);
seams = 50;

r = zeros(size(img));
s = 0;
for i = 1:seams
  tic
  [s,~] = seamcarve(img, 1, s, 5, 1, 2);
  i
  toc
end

imshow(img);