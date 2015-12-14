function net = proj6_part1_cnn_init()
%code for Computer Vision, Georgia Tech by James Hays
%based of the MNIST example from MatConvNet

rng('default');
rng(0);

% constant scalar for the random initial network weights. You shouldn't
% need to modify this.
f=1/100; 

net.layers = {} ;

net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{f*randn(9,9,1,10, 'single'), zeros(1, 10, 'single')}}, ...
                           'stride', 1, ...
                           'pad', 0, ...
                           'name', 'conv1') ;
                       
net.layers{end+1} = struct('type', 'pool', ...
                           'method', 'max', ...
                           'pool', [7 7], ...
                           'stride', 5, ...
                           'pad', 0) ;

net.layers{end+1} = struct('type', 'relu') ;

% % add drop out layer
% net.layers{end+1} = struct('type', 'dropout', 'rate', 0.5);

% =========================================================================
% % add another convolutional layer
net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{f*randn(5,5,10,100, 'single'), zeros(1, 100, 'single')}}, ...
                           'stride', 1, ...
                           'pad', 0, ...
                           'name', 'conv2') ;

% add max-pool layer
net.layers{end+1} = struct('type', 'pool',...
                            'method', 'max',...
                            'pool', [3 3], ...
                            'stride', 3,...
                            'pad', 0);
                        
% add another relu layer
net.layers{end+1} = struct('type', 'relu') ; 
% add drop out layer
net.layers{end+1} = struct('type', 'dropout', 'rate', 0.5);
% % =========================================================================                      
% 
% % add another relu layer
% net.layers{end+1} = struct('type', 'relu') ;
% 
% % add drop out layer
% net.layers{end+1} = struct('type', 'dropout', 'rate', 0.5);
% % =========================================================================

net.layers{end+1} = struct('type', 'conv', ...
                           'weights', {{f*randn(2,2,100,15, 'single'), zeros(1, 15, 'single')}}, ...
                           'stride', 1, ...
                           'pad', 0, ...
                           'name', 'fc1') ;
                      
% Loss layer
net.layers{end+1} = struct('type', 'softmaxloss');



% Visualize the network
vl_simplenn_display(net, 'inputSize', [64 64 1 50])