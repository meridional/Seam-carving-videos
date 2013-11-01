img = imread('lake.jpg');
img = im2double(img);
seams = 50;

r = zeros(size(img));
for i = 1:seams
  tic
  [~,img] = seamcarve(img, 1, 0, 5, 1, 2);
  i
  toc
end

imshow(img);