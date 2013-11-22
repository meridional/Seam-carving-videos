function [svv] = spatiov(fi, ws)
% sv - takes a frame fi, and a windowsize, ws,
% returns a m-n-(ws * 2 + 1) matrix for different path cost.


%% set up the stage
n = size(fi, 1);
m = size(fi, 2);
svv = zeros([n m ws*2+1]);

%% calculate gv and gd
gv = abs(fi - vertcat(zeros([1 m]), fi(1:(n-1),:)));
% hacky matrix shifting
gdp = abs(fi - ...
  padarray([zeros([1 (m-1)]);fi(1:(n-1), 2:m)], [0 1], 0, 'post'));
gdn = abs(fi - ...
  padarray(fi(1:(n-1),1:(m-1)), [1,1],0, 'pre'));
% calc the two parts of the sum

% for xb - xa > 0 - positive
fstp = abs(gdp - gv);
sndp = abs(gv - padarray(gdp(:,1:(m-1)), [0 1], 0, 'pre'));


% for xb - xa < 0 - negavive
fstn = abs(gdn - gv);
sndn = abs(gv - padarray(gdn(:,2:m), [0 1], 0, 'post'));

%svv = sv;
for idx = 1:ws
  convMat1 = [zeros([1 (ws - idx + 2)]) ones([1 (ws - idx + 1)])];
  convMat2 = [zeros([1 (ws - idx)]) ones([1 (ws - idx + 1)])];
  svv(2:end,:,idx) = conv2(fstp(2:end,:),convMat1,'same') +...
    conv2(sndp(2:end,:),convMat2,'same');
end

for idx = 1:ws
  convMat1 = [ones([1 idx]) zeros([1 (idx + 1)]) ];
  convMat2 = [ ones([1 idx]) zeros([1 idx - 1])];
  svv(2:end,:,ws+idx+1) = conv2(fstn(2:end,:),convMat1,'same') + ...
    conv2(sndn(2:end,:),convMat2,'same');
end


% for i = 2:n
%   for j = 1:m
%     for xa = j-1:-1:max(j-ws,1)
%       idx = ws + 1 + xa - j;
%       sv(i,j,idx) = sum(fstp(i,xa:(j-1))) + sum(sndp(i,(xa+1):j));
%     end
%     for xa = j+1:min(m,j+ws)
%       idx = ws + 1 + xa - j;
%       sv(i,j,idx) = sum(fstn(i,(j+1):xa)) + sum(sndn(i,j:(xa-1)));
%     end
%   end
% end



end