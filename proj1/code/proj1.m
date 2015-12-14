% Before trying to construct hybrid images, it is suggested that you
% implement my_imfilter.m and then debug it using proj1_test_filtering.m

% Debugging tip: You can split your MATLAB code into cells using "%%"
% comments. The cell containing the cursor has a light yellow background,
% and you can press Ctrl+Enter to run just the code in that cell. This is
% useful when projects get more complex and slow to rerun from scratch

close all; % closes all figures

%% Setup
% read images and convert to floating point format
image1 = im2single(imread('../data/dog.bmp'));
image2 = im2single(imread('../data/cat.bmp'));

% Several additional test cases are provided for you, but feel free to make
% your own (you'll need to align the images in a photo editor such as
% Photoshop). The hybrid images will differ depending on which image you
% assign as image1 (which will provide the low frequencies) and which image
% you asign as image2 (which will provide the high frequencies)

%% Filtering and Hybrid Image construction
cutoff_frequency = 7; %This is the standard deviation, in pixels, of the 
% Gaussian blur that will remove the high frequencies from one image and 
% remove the low frequencies from another image (by subtracting a blurred
% version from the original version). You will want to tune this for every
% image pair to get the best results.
filter = fspecial('Gaussian', cutoff_frequency*4+1, cutoff_frequency);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% YOUR CODE BELOW. Use my_imfilter create 'low_frequencies' and
% 'high_frequencies' and then combine them to create 'hybrid_image'
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the high frequencies from image1 by blurring it. The amount of
% blur that works best will vary with different image pairs
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

low_frequencies = my_imfilter(image1, filter);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Remove the low frequencies from image2. The easiest way to do this is to
% subtract a blurred version of image2 from the original version of image2.
% This will give you an image centered at zero with negative values.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

high_frequencies = image2 - my_imfilter(image2, filter);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Combine the high frequencies and low frequencies
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

hybrid_image = low_frequencies +high_frequencies;

%% Visualize and save outputs
figure(1); imshow(low_frequencies);
figure(2); imshow(high_frequencies + 0.5);
vis = vis_hybrid_image(hybrid_image);
figure(3); imshow(vis);
imwrite(low_frequencies, 'low_frequencies.jpg', 'quality', 95);
imwrite(high_frequencies + 0.5, 'high_frequencies.jpg', 'quality', 95);
imwrite(hybrid_image, 'hybrid_image.jpg', 'quality', 95);
imwrite(vis, 'hybrid_image_scales.jpg', 'quality', 95);

%% Experiment with the cut-off frequency, code is shown below:
%  This part is written by Liang Tang

% image: Einstein and Marilyn, Cutoff frequency: 5
image3 = im2single(imread('../data/einstein.bmp'));
image4 = im2single(imread('../data/marilyn.bmp'));
cutoff_frequency2 = 5;
filter2 = fspecial('Gaussian', cutoff_frequency2 * 4 + 1, cutoff_frequency2);

einstein_low_frequencies = my_imfilter(image3, filter2);
marilyn_high_frequencies= image4 - my_imfilter(image4, filter2);
einstein_marilyn_hybrid_image= einstein_low_frequencies + marilyn_high_frequencies;
figure(4); imshow(einstein_low_frequencies);
figure(5); imshow(marilyn_high_frequencies + 0.5);
einstein_marilyn_vis = vis_hybrid_image(einstein_marilyn_hybrid_image);
figure(6); imshow(einstein_marilyn_vis);
imwrite(einstein_low_frequencies, 'einstein_low_frequencies.jpg', 'quality', 95);
imwrite(marilyn_high_frequencies + 0.5, 'marilyn_high_frequencies.jpg', 'quality', 95);
imwrite(einstein_marilyn_hybrid_image, 'einstein_marilyn_hybrid_image.jpg', 'quality', 95);
imwrite(einstein_marilyn_vis, 'einstein_marilyn_hybrid_image_scales.jpg', 'quality', 95);

%%
%image: plane and bird, cutoff frequency: 6
image5 = im2single(imread('../data/bird.bmp'));
image6 = im2single(imread('../data/plane.bmp'));
cutoff_frequency3 = 6;
filter3 = fspecial('Gaussian', cutoff_frequency3 * 4 + 1, cutoff_frequency3);

plane_low_frequencies = my_imfilter(image5, filter3);
bird_high_frequencies= image6 - my_imfilter(image6, filter3);
plane_bird_hybrid_image= plane_low_frequencies + bird_high_frequencies;
%figure(5); imshow(plane_low_frequencies);
%figure(6); imshow(bird_high_frequencies + 0.5);
plane_bird_vis = vis_hybrid_image(plane_bird_hybrid_image);
%figure(6); imshow(einstein_marilyn_vis);
imwrite(plane_low_frequencies, 'plane_low_frequencies.jpg', 'quality', 95);
imwrite(bird_high_frequencies + 0.5, 'bird_high_frequencies.jpg', 'quality', 95);
imwrite(plane_bird_hybrid_image, 'plane_bird_hybrid_image.jpg', 'quality', 95);
imwrite(plane_bird_vis, 'plane_bird_vis.jpg', 'quality', 95);

%%
%image: motocycle and bicycle, cutoff frequency: 7
image7 = im2single(imread('../data/bicycle.bmp'));
image8 = im2single(imread('../data/motorcycle.bmp'));
cutoff_frequency4 = 7;
filter4 = fspecial('Gaussian', cutoff_frequency4 * 4 + 1, cutoff_frequency4);

motorcycle_low_frequencies = my_imfilter(image7, filter4);
bicycle_high_frequencies= image8 - my_imfilter(image8, filter4);
motorcycle_bicycle_hybrid_image= motorcycle_low_frequencies + bicycle_high_frequencies;
motorcycle_bicycle_vis = vis_hybrid_image(motorcycle_bicycle_hybrid_image);

imwrite(motorcycle_low_frequencies, 'motorcycle_low_frequencies.jpg', 'quality', 95);
imwrite(bicycle_high_frequencies + 0.5, 'bicycle_high_frequencies.jpg', 'quality', 95);
imwrite(motorcycle_bicycle_hybrid_image, 'motorcycle_bicycle_hybrid_image.jpg', 'quality', 95);
imwrite(motorcycle_bicycle_vis, 'motorcycle_bicycle_vis.jpg', 'quality', 95);

%%
% image: fish and submarine, cutoff frequency: 7
image9 = im2single(imread('../data/fish.bmp'));
image10 = im2single(imread('../data/submarine.bmp'));

fish_low_frequencies = my_imfilter(image9, filter4);
submarine_high_frequencies= image10 - my_imfilter(image10, filter4);
fish_submarine_hybrid_image= fish_low_frequencies + submarine_high_frequencies;
fish_submarine_vis = vis_hybrid_image(fish_submarine_hybrid_image);

imwrite(fish_low_frequencies, 'fish_low_frequencies.jpg', 'quality', 95);
imwrite(submarine_high_frequencies + 0.5, 'submarine_high_frequencies.jpg', 'quality', 95);
imwrite(fish_submarine_hybrid_image, 'fish_submarine_hybrid_image.jpg', 'quality', 95);
imwrite(fish_submarine_vis, 'fish_submarine_vis.jpg', 'quality', 95);