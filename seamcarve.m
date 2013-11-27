function [seam, ri] = seamcarve(frgb, ws, seam, scw, tcw, sw)
% dynamic programming, 
% takes a frgb - one or multiple rgb-frames -- has to be rgb
% ws - the window size that is used in calculating s_v
% seam - s_{i-1}, the previous seam, pass in 0 for initial frame
% scw - weighting for Sc term
% tcw - weighting for Tc term
% sw - weighting for S term
% returns a seam for the current frame, seam
% and r_i, the seam carved out of the current seam
% seam is a n by 1 vector, the index of the pixel to be removed at each
% row.



% rows and cols
n = size(frgb,1);
m = size(frgb,2);
frameCount = size(frgb,4);
fi = zeros([n m frameCount]);
for i = 1:frameCount
  fi(:,:,i) = rgb2gray(frgb(:,:,:,i));
end


%% initialization
cost = zeros([n m]);
sv = zeros([n m (2*ws+1)]);

directions = zeros([n m]);
seamenergy = zeros([n m]);

%% getting the cost
for i = 1:frameCount
  w = weightingFun(i, frameCount);
  % getting sv
  sv = sv + spatiov(fi, ws) * w;
  % adding Sh
  cost = cost + spatioh(fi) * w * scw;
  % adding S
  cost = cost + saliency(fi) * w * sw;
  % adding Tc
  if (seam ~= 0)
    cost = cost + temporal(fi, seam) * w * tcw;
  end
end

%% dp part

seamenergy(1,:) = cost(1,:);
for i = 2:n
  for j = 1:m
    d = getDirection(i, j, m);
    directions(i,j) = d;
    seamenergy(i,j) = seamenergy(i-1,j+directions(i,j))...
      + cost(i,j) + sv(i,j,ws + 1 + d);
  end
end
      function d = getDirection(i, j, m)
      % take the energy cache sv, and i,j, m returns the best d

      % get the legit direction candidates
        ds = -ws:ws;
        ds = ds(j + ds > 0);
        ds = ds(j + ds <= m);

        % get the energies
        svprime = sv(i,j,ws+1-ds);
        ecprime = seamenergy(i-1,ds+j);
        en = ecprime(:) + svprime(:);
        [~, ids] = min(en);
        d = ds(ids);
      end

% calc the seam from the cache
[~, idx] = min(seamenergy(n,:));
seam(n) = idx;

for i = (n-1):(-1):1
  seam(i) = seam(i+1) + directions(i+1,seam(i+1));
end

% carve
ri = carve(frgb(:,:,:,1), seam);
end

%% part of dp



%% weighting function
function w = weightingFun(x, n)
% return the weights for the averaging the saliencies if using the
% look-ahead strategy

w = (n - x + 1) / (n + 1);

end