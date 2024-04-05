clear; % remove variable
clc;

imgA = imread("face.jpg");
imgB = imread("LSK.jpg");

% gaussian
[row, col, dep] = size(imgA);
msksize = [row, col];
sig = min(msksize)/6;
imMsk = GaussMask(msksize, sig);
% figure;
% imshow(imMsk);

% image composition
imgA = double(imgA);
imgB = double(imgB);

imgMsk = double(repmat(imMsk, [1,1,3]));
imgR = imgA.*imgMsk + imgB.*(1-imgMsk);

figure;
imshow(imgR/255);

function imMsk = GaussMask(msksize, sig)
% -- > definition help for function
% function imMsk = GaussMask(msksize, sig)
% msksize = [row, col] of size of mask
% rad : sigma for Gaussian function

rows = msksize(1);
clos = msksize(2);
center = msksize/2;

% Meshgrid
[x, y] = meshgrid(1:rows, 1:clos);

% Distance
dist = exp( -((x-center(2)).^2+(y-center(1)).^2)/(2*sig));

% Binary mask
imMsk = dist/max(dist(:)); % Max = 1 min = 0

end