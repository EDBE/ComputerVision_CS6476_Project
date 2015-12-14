% RANSAC Stencil Code
% CS 4495 / 6476: Computer Vision, Georgia Tech
% Written by Henry Hu

% Find the best fundamental matrix using RANSAC on potentially matching
% points

% 'matches_a' and 'matches_b' are the Nx2 coordinates of the possibly
% matching points from pic_a and pic_b. Each row is a correspondence (e.g.
% row 42 of matches_a is a point that corresponds to row 42 of matches_b.

% 'Best_Fmatrix' is the 3x3 fundamental matrix
% 'inliers_a' and 'inliers_b' are the Mx2 corresponding points (some subset
% of 'matches_a' and 'matches_b') that are inliers with respect to
% Best_Fmatrix.

% For this   section, use RANSAC to find the best fundamental matrix by
% randomly sample interest points. You would reuse
% estimate_fundamental_matrix() from part 2 of this assignment.

% If you are trying to produce an uncluttered visualization of epipolar
% lines, you may want to return no more than 30 points for either left or
% right images.

function [ Best_Fmatrix, inliers_a, inliers_b] = ransac_fundamental_matrix(matches_a, matches_b)


%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%

% Your ransac loop should contain a call to 'estimate_fundamental_matrix()'
% that you wrote for part II.

%placeholders, you can delete all of this


matches = size(matches_a,1);
p = 0.99;
samples = 9;
%ratio of outliers
outlierR = 0.30; 
N = log(1-p)/(log(1-((1-outlierR)^samples)));

iterations = round(N);
bestInliers = [];
bestF_matrix = [];

for i=1:iterations
  % Randomly sample from matches
  randInd = randsample(matches,samples);
  
  samples_a = matches_a(randInd,:);
  samples_b = matches_b(randInd,:);
  
  %Generate fundamental matrix for the samples points
  F_matrix = estimate_fundamental_matrix2(samples_a, samples_b);
    
  %Find distance based on F_matrix
  dist = zeros(matches,1);
  for j = 1:matches
    dist(j) = ([matches_b(j,:) 1] * F_matrix*[matches_a(j,:) 1]')^2;
  end
    
  % Compare the distance to an inlier threshold
  inliers = find(dist < 0.0000005);
    
  if (length(inliers)>length(bestInliers))
  bestInliers = inliers;
  bestF_matrix = F_matrix;
  end

end

Best_Fmatrix = bestF_matrix;
inliers_a = matches_a(bestInliers,:);
inliers_b = matches_b(bestInliers,:);
end

