% Test_alpha blending

clear; % remove variable
clc;

imgA = imread("baboon.png");
imgB = imread("lena.png");

[row, col, dep] = size(imgA);
msksize = [row, col];
sigma = min(msksize)/6; % 가우시안 마스크의 시그마 값 설정
gaussianMask = GaussianMask(msksize, sigma);
figure;
imshow(gaussianMask);

% image composition
imgA = double(imgA);
imgB = double(imgB);

imgMsk = double(repmat(gaussianMask, [1,1,3]));
imgR = imgA.*imgMsk + imgB.*(1-imgMsk);

figure;
imshow(imgR/255);

function gaussianMask = GaussianMask(msksize, sigma)
% function gaussianMask = GaussianMask(msksize, sigma)
% msksize = [row, col] of size of mask
% sigma : standard deviation for gaussian mask

rows = msksize(1);
cols = msksize(2);
center = msksize/2;

% Meshgrid
[X, Y] = meshgrid(1:rows, 1:cols);
X = X - center(2);
Y = Y - center(1);

% Gaussian mask
gaussianMask = exp(-(X.^2 + Y.^2) / (2 * sigma^2));
gaussianMask = gaussianMask / sum(gaussianMask(:)); % normalization

end

