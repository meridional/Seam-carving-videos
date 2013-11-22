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
obj = VideoReader('IMG_ S01 E20.m4v');
vid = obj.read();
%%
w = size(vid,2);
c = 1;
carved = vid;
for i = 1:5
  next = carved(:,2:end,:,:);
  
  s = 0;
  for f = 1:size(vid,4)
    %i 
    %f
    tic
    [s,next(:,:,:,f)] = seamcarve(carved(:,:,:,f),1,s,5,1,2);
    toc
  end
  carved = next;
end