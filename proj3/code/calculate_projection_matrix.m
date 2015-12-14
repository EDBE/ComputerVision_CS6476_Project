% Projection Matrix Stencil Code
% CS 4495 / 6476: Computer Vision, Georgia Tech
% Written by Henry Hu, Grady Williams, James Hays

% Returns the projection matrix for a given set of corresponding 2D and
% 3D points. 

% 'Points_2D' is nx2 matrix of 2D coordinate of points on the image
% 'Points_3D' is nx3 matrix of 3D coordinate of points in the world

% 'M' is the 3x4 projection matrix


function M = calculate_projection_matrix( Points_2D, Points_3D )

% To solve for the projection matrix. You need to setup a homogenous
% set of equations using the corresponding 2D and 3D points:

%                                                     [M11       [ u1
%                                                      M12         v1
%                                                      M13         .
%                                                      M14         .
%[ X1 Y1 Z1 1 0  0  0  0 -u1*X1 -u1*Y1 -u1*Z1          M21         .
%  0  0  0  0 X1 Y1 Z1 1 -v1*Z1 -v1*Y1 -v1*Z1          M22         .
%  .  .  .  . .  .  .  .    .     .      .          *  M23   =     .
%  Xn Yn Zn 1 0  0  0  0 -un*Xn -un*Yn -un*Zn          M24         .
%  0  0  0  0 Xn Yn Zn 1 -vn*Zn -vn*Yn -vn*Zn ]        M31         .
%                                                      M32         un
%                                                      M33         vn ]

% Then you can solve this using least squares with the '\' operator or SVD.
% Notice you obtain 2 equations for each corresponding 2D and 3D point
% pair. To solve this, you need at least 6 point pairs.

%%%%%%%%%%%%%%%%
% Your code here
%%%%%%%%%%%%%%%%

fprintf('Randomly setting matrix entries as a placeholder\n')
M = [0.1768    0.7018    0.7948    0.4613; ...
     0.6750    0.3152    0.1136    0.0480; ...
     0.1020    0.1725    0.7244    0.9932];
%This M matrix came from a call to rand(3,4). It leads to a high residual.
%Your total residual should be less than 1.

[rows cols] = size(Points_3D);
%Initiate A
A = zeros(rows * 2, 12);   
%Compute A
for r = 1: rows
   A(2*r-1, :) = [Points_3D(r, 1) Points_3D(r, 2) Points_3D(r, 3) 1 0 0 0 0 ...
                  -Points_2D(r, 1)*Points_3D(r, 1) -Points_2D(r, 1)*Points_3D(r, 2)...
                  -Points_2D(r, 1)*Points_3D(r, 3) -Points_2D(r, 1)]; 
                
   A(2*r, :)   = [0 0 0 0 Points_3D(r, 1) Points_3D(r, 2) Points_3D(r, 3) 1 ...
                  -Points_2D(r, 2)*Points_3D(r, 1) -Points_2D(r, 2)*Points_3D(r, 2) ...
                  -Points_2D(r, 2)*Points_3D(r, 3) -Points_2D(r, 2)];
end 
%Compute the eigenvalues and corresponding eigenvectors of A' * A
[eigenVector eigenValue] = eig(A' * A);
 
%The eigenvector m corresponding to the minimal eigenvalue
m = eigenVector(:, 1);

%Convert m to a 3 by 4 matrix M
M = vec2mat(m, 4);
end

