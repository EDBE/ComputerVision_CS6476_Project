% Fundamental Matrix Stencil Code
% CS 4495 / 6476: Computer Vision, Georgia Tech
% Written by Henry Hu

% Returns the camera center matrix for a given projection matrix

% 'Points_a' is nx2 matrix of 2D coordinate of points on Image A
% 'Points_b' is nx2 matrix of 2D coordinate of points on Image B
% 'F_matrix' is 3x3 fundamental matrix

% Try to implement this function as efficiently as possible. It will be
% called repeatly for part III of the project

function [ F_matrix ] = estimate_fundamental_matrix(Points_a,Points_b)

%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%

%This is an intentionally incorrect Fundamental matrix placeholder
F_matrix = [0  0     -.0004; ...
            0  0      .0032; ...
            0 -0.0044 .1034]; 

[rows cols] = size(Points_a);
A = zeros(rows, 9);

%Compute A
for r = 1: rows
    A(r, :) = [Points_a(r, 1)*Points_b(r, 1) Points_a(r, 1)*Points_b(r, 2) Points_a(r, 1) Points_a(r, 2)*Points_b(r, 1) ...
               Points_a(r, 2)*Points_b(r, 2) Points_a(r, 2) Points_b(r, 1) Points_b(r, 2) 1];        
end    
[eigenVector eigenValue] = eig(A' * A);
tildef = eigenVector(:, 1);
tildeF = vec2mat(tildef, 3);
%Fundamental matrix F with Full Rank
F_matrix = rank(tildeF);

[U, S, V] = svd(tildeF);
S(3, 3) = 0;

%Fundamental matrix F with rank 2
F_matrix = U * S * V';

end

