function [best_M min_residue Projected_2D_Pts]= calibrate_camera(Points_2D, Points_3D)

[rows cols] = size(Points_3D);
k_s = [8; 12; 16];   %k = 8, 12, 16
M_matrix = cell(3, 10); %This will contain 30 matrices M
residue_matrix = zeros(3, 10);   %This will contain 30 residues, correspondingly

for num = 1: 3
    k = k_s(num);
    for times = 1: 10   %Repeat 10 times
        randomSorting = randperm(rows);
        indexM = randomSorting(1, 1:k); %pick up the first k entries as the indecies of 2D and 3D points
        indexR = randomSorting(1, k+1: k+4);
        % Compute A
        A = zeros(k*2, 12);
        for r = 1: k
            A(2*r-1, :) = [Points_3D(indexM(r), 1) Points_3D(indexM(r), 2) Points_3D(indexM(r), 3) 1 0 0 0 0 ...
                  -Points_2D(indexM(r), 1)*Points_3D(indexM(r), 1) -Points_2D(indexM(r), 1)*Points_3D(indexM(r), 2)...
                  -Points_2D(indexM(r), 1)*Points_3D(indexM(r), 3) -Points_2D(indexM(r), 1)]; 
                
            A(2*r, :)   = [0 0 0 0 Points_3D(indexM(r), 1) Points_3D(indexM(r), 2) Points_3D(indexM(r), 3) 1 ...
                  -Points_2D(indexM(r), 2)*Points_3D(indexM(r), 1) -Points_2D(indexM(r), 2)*Points_3D(indexM(r), 2) ...
                  -Points_2D(indexM(r), 2)*Points_3D(indexM(r), 3) -Points_2D(indexM(r), 2)];
        end 
        [eigenVector eigenValue] = eig(A' * A);
        m = eigenVector(:, 1);
        M = vec2mat(m, 4);
        residue = 0;
        for i = 1: 4
            estimated_2D_Homo_pixel = M * [Points_3D(indexR(i), 1: 3) 1]';
            estimated_2D_pixel = [estimated_2D_Homo_pixel(1)/estimated_2D_Homo_pixel(3);...
                                 estimated_2D_Homo_pixel(2)/estimated_2D_Homo_pixel(3)];
            residue = residue + sqrt((estimated_2D_pixel(1)-Points_2D(indexR(i), 1))^2+...
                                     (estimated_2D_pixel(2)-Points_2D(indexR(i), 2))^2);
        end
        residue_matrix(num, times) = residue / 4;
        M_matrix(num, times) = {M};
    end
end

[min_residue index] = min(residue_matrix(:));    %find the minimal residue and find the best M
[i j] = ind2sub(size(residue_matrix), index);
best_M = M_matrix{i, j};

Projection = best_M*[Points_3D ones(size(Points_3D,1),1)]';
Projection = Projection';
u = Projection(:,1)./Projection(:,3);
v = Projection(:,2)./Projection(:,3);

Projected_2D_Pts = [u v];

end
