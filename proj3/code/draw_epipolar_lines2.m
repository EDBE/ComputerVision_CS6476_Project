function [] = draw_epipolar_lines2(F_matrix, ImgLeft, ImgRight, PtsLeft, PtsRight)

[rows cols] = size(PtsLeft);
%ImgLeft = imread('pic_a.jpg'); %Load image a
[rowsA, colsA] = size(ImgLeft);
figure(21);
imshow(ImgLeft, 'Border', 'tight')
hold on
for r = 1:rows
    pointB = [PtsRight(r, 1); PtsRight(r, 2); 1]; %Points in image b represented in homogenous coordinate
    plot(PtsLeft(r, 1), PtsLeft(r, 2), '+', 'markersize', 6, 'Color', 'r');
    la = F_matrix * pointB; 
    lLeft = [1; 0; 0];
    lRight = [1; 0; -colsA];
    pointHomoLeft = cross(la, lLeft);
    pointHomoRight = cross(la, lRight);
    pointLeft = [pointHomoLeft(1)/pointHomoLeft(3); pointHomoLeft(2)/pointHomoLeft(3)];
    pointRight = [pointHomoRight(1)/pointHomoRight(3); pointHomoRight(2)/pointHomoRight(3)];
    line([pointLeft(1) pointRight(1)], [pointLeft(2) pointRight(2)], 'Color', 'g', 'linewidth', 1) %Draw polar lines
end
%ImgRight = imread('pic_b.jpg'); %Load image b
[rowsA, colsA] = size(ImgRight);
figure(22);
imshow(ImgRight, 'Border', 'tight')
hold on
for r = 1:rows
    pointA = [PtsLeft(r, 1); PtsLeft(r, 2); 1]; %Points in image a represented in homogenous coordinate
    plot(PtsRight(r, 1), PtsRight(r, 2), '+', 'markersize', 6, 'Color', 'r');
    lb = F_matrix' * pointA; 
    lLeft = [1; 0; 0];
    lRight = [1; 0; -colsA];
    pointHomoLeft = cross(lb, lLeft);
    pointHomoRight = cross(lb, lRight);
    pointLeft = [pointHomoLeft(1)/pointHomoLeft(3); pointHomoLeft(2)/pointHomoLeft(3)];
    pointRight = [pointHomoRight(1)/pointHomoRight(3); pointHomoRight(2)/pointHomoRight(3)];
    line([pointLeft(1) pointRight(1)], [pointLeft(2) pointRight(2)], 'Color', 'g', 'linewidth', 1) %Draw polar lines
end