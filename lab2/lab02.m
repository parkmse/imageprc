% Test_alpha blending

clear; % remove variable
clc;

imgA = imread("baboon.png");
imgB = imread("lena.png");

% --> make img to video
% alp = 0:0.1:1; % alp is form of vector
% for i = 1: length(alp)
%     ap = alp(i);
%     img = (1-ap)*imgA + ap*imgB;    
% 
%     %figure(i);
%     imshow(img);
%     pause(1);
% end

% --> not neccesary
% alp = 0.5; % weighted average
% img = (1-alp)*imgA + alp*imgB;


[row, col, dep] = size(imgA);
msksize = [row, col];
rad = min(msksize)/3;
imMsk = CircleMask(msksize, rad);
figure;
imshow(imMsk);

%gaussian
% [row, col, dep] = size(imgA);
% msksize = [row, col];
% rad = min(msksize)/3;
% imMsk = GaussMask(msksize, rad);
% figure;
% imshow(imMsk);

% filter coefficient
% h = [1 2 3 4 5 4 3 2 1];
% hh = h'*h; % vector 2개 matrix outerproduct
% 
% sig = min(msksize)/6;
% imMsk = GaussMask(msksize, sig);
% figure;
% imshow(imMsk)

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


function imMsk = GaussMask(msksize, sig)
% -- > definition help for function
% function imMsk = GaussMask(msksize, sig)
% msksize = [row, col] of size of mask
% rad : sigma for Gaussian function

rows = msksize(1);
clos = msksize(2);
center = msksize/2;

% Meshgird
[x, y] = meshgrid(1:rows, 1:clos);

% Distance
% exp(- (x^2 + y^2)/2*sigma)
dist = exp( -((x-center(2)).^2+(y-center(1)).^2)/(2*sig));

% Binary mask
imMsk = dist/max(dist(:)); % Max = 1 min = 0

end
























