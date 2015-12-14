function [ F_matrix ] = estimate_fundamental_matrix2(Points_a,Points_b)

%This F_matrix calculation function include 'normalization'
%The output of it is more accurate than the previous fundamental matrix
%estimation function
n = size(Points_a,1);
A = zeros(n,9);

% 1, Normalization
mean_a = sum(Points_a(:,1:2)) / n;
mean_b = sum(Points_b(:,1:2)) / n;
diff_a = Points_a(:,1:2) - repmat(mean_a,n,1);
diff_b = Points_b(:,1:2) - repmat(mean_b,n,1);

% 2, Calculate scale
s_a = sqrt(2) / (sum(sqrt(diff_a(:,1).^2 + diff_a( :,2).^2))/ n);
s_b = sqrt(2) / (sum(sqrt(diff_b(:,1).^2 + diff_b( :,2).^2))/ n);

% 3, Create T matrices
scale_a = [s_a 0 0; 0 s_a 0; 0 0 1];
center_a = [1 0 -mean_a(1); 0 1 -mean_a(2); 0 0 1];
scale_b = [s_b 0 0; 0 s_b 0; 0 0 1];
center_b = [1 0 -mean_b(1); 0 1 -mean_b(2); 0 0 1];

T_a = scale_a * center_a;
T_b = scale_b * center_b;

Points_a(:,3) = 1;
Points_a = (T_a * Points_a')';
Points_a(:,3) = [];

Points_b(:,3) = 1;
Points_b = (T_b * Points_b')';
Points_b(:,3) = [];


for i = 1:n;
    u = Points_b(i,1);
    v = Points_b(i,2);
    u1 = Points_a(i,1);
    v1 = Points_a(i,2);
    
    A(i,:) = [ u*u1 u*v1 u v*u1 v*v1 v u1 v1 1 ];
end

[U, S, V] = svd(A);
f = V(:, end);
F_matrix = reshape(f, [3 3])';

F_matrix = T_b' * F_matrix * T_a;

end