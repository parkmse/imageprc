clear;
clc;

imgA = imread("baboon.png");
imgB = imread("lena.png");

% specify block size
block_size = [30, 80];

% copy the images to the same size
x_A = 75; y_A = 155;
x_B = 250; y_B = 250;

imgA_resized = imcrop(imgA, [x_A, y_A, block_size(2)-1, block_size(1)-1]);
imgB_resized = imcrop(imgB, [x_B, y_B, block_size(2)-1, block_size(1)-1]);

if ~isequal(size(imgA_resized), size(imgB_resized))
    imgA_resized = imresize(imgA_resized, size(imgB_resized));
end

% create Gaussian mask
[row, col, dep] = size(imgA_resized);
msksize = [row, col];
rad = min(msksize)/3;
immsk = GaussMask(msksize, rad);

% convert to double
imgA_resized = double(imgA_resized);
imgB_resized = double(imgB_resized);
imgmsk = double(repmat(immsk, [1,1,3]));

% alpha-blending
imgR = imgA_resized.*imgmsk + imgB_resized.*(1-imgmsk);

% merge the blended image and the original image
imgB(y_B:y_B+block_size(1)-1, x_B:x_B+block_size(2)-1, :) = imgR;

% show blended image
figure;
imshow(uint8(imgB)); 

function immsk = GaussMask(msksize, rad)

rows = msksize(1);
cols = msksize(2);
center = msksize / 2;

[x, y] = meshgrid(1:rows, 1:cols);

dist = sqrt((x-center(2)).^2 + (y-center(1)).^2)/rad;

sig = 0.6;

immsk = dist <= sig;

end