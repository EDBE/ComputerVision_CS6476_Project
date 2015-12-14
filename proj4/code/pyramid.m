%
% 1, get the data path
data_path = '../data/';

% 2, list the directories to use
categories = {'Kitchen', 'Store', 'Bedroom', 'LivingRoom', 'Office', ...
       'Industrial', 'Suburb', 'InsideCity', 'TallBuilding', 'Street', ...
       'Highway', 'OpenCountry', 'Coast', 'Mountain', 'Forest'};
% and also the abbreviation
abbr_categories = {'Kit', 'Sto', 'Bed', 'Liv', 'Off', 'Ind', 'Sub', ...
    'Cty', 'Bld', 'St', 'HW', 'OC', 'Cst', 'Mnt', 'For'};
% number of training examples
num_train_per_cat = 100;

% 3, use get_image_paths function to have the cell arrays containing the
% file path for each train and test image, as well as cell arrays with the
% label of each train and test
fprintf('Getting paths and labels for all train and test data\n')
[train_image_paths, test_image_paths, train_labels, test_labels] = ...
    get_image_paths(data_path, categories, num_train_per_cat);

% 4, build the pyramid
image_dir = '/Users/musictechnology/Dropbox/Fall_2015/6476CS_CV/Projects/proj4/data/train/kitchen';
output_dir = '/Users/musictechnology/Dropbox/Fall_2015/6476CS_CV/Projects/proj4/';
pyramid_all = BuildPyramid(train_image_paths, image_dir, output_dir);