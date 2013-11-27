img = imread('lake.jpg');
img = im2double(img);
seams = 50;

r = zeros(size(img));
q = 0;
for i = 1:seams
  tic
  s = q;
  [q,~] = seamcarve(img, 1, s, 5, 1, 2);
  sum(s ~= q)
  i
  toc
end

imshow(img);

%%
obj = VideoReader('nov_25_16_12_.mov.avi');
vid = obj.read();
%%
w = size(vid,2);
c = 1;
carved = vid;
seams = 80;
for i = 1:seams
  next = carved(:,2:end,:,:);
  [height,width,~,~] = size(carved);
  s = 0;
  downsampledWidth = floor(width * 0.5);
  downsampledHeight = floor(height * 0.5);
  for f = 1:size(vid,4)
    
    downsampled = imresize(carved(:,:,:,f),...
      [downsampledHeight downsampledWidth]);
    tic
    [s,~] = seamcarve(downsampled,7,s,5,1,2);
    toc
    %size(interp(s,2))
    upsampledSeam = (interp1(s,2,'nearest') * 2) + (rand([1 height]) > 0.5);
    next(:,:,:,f) = carve(carved(:,:,:,f), upsampledSeam);
  end
  carved = next;
end