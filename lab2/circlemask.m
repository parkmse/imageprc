clear; % remove variable
clc;

imgA = imread("face.jpg");
imgB = imread("LSK.jpg");

% gaussian
[row, col, dep] = size(imgA);
msksize = [row, col];
rad = min(msksize)/3;
imMsk = CircleMask(msksize, rad);
figure;
imshow(imMsk);

% image composition
imgA = double(imgA);
imgB = double(imgB);

imgMsk = double(repmat(imMsk, [1,1,3]));
imgR = imgA.*imgMsk + imgB.*(1-imgMsk);

figure;
imshow(imgR/255);

function imMsk = CircleMask(msksize, rad)
% -- > definition help for function
% function imMsk = CircleMask(msksize, rad)
% msksize = [row, col] of size of mask
% rad : radius for circle

rows = msksize(1);
clos = msksize(2);
center = msksize/2;

% Meshgird
[x, y] = meshgrid(1:rows, 1:clos);

% Distance
dist = sqrt( (x-center(2)).^2+(y-center(1)).^2);

% Binary mask
imMsk = dist <= rad;

end