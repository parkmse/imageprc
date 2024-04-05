clear;
clc;

imgA = imread("peppers.png");
imgB = imread("face.jpg");

block_size = [90, 90];

x_A = 180; y_A = 15;
x_B = 250; y_B = 360;

imgA_resized = imcrop(imgA, [x_A, y_A, block_size(2)-1, block_size(1)-1]);

h = [1 2 3 4 5 4 3 2 1];
h = conv(h,h); % convolution 조정
hh = h'*h; % vector 2개 matrix outerproduct
hh = hh/sum(hh(:));

imgB_new = imgB;  % imgB 복사본 생성

alp = 0:0.2:1;
for i = 1: length(alp)
    ap = alp(i);
    imgB_resized = imcrop(imgB_new, [x_B, y_B, block_size(2)-1, block_size(1)-1]);

    if ~isequal(size(imgA_resized), size(imgB_resized))
        imgA_resized = imresize(imgA_resized, size(imgB_resized));
    end

    [row, col, dep] = size(imgA_resized);
    msksize = [row,col];
    sig = min(msksize)/3;
    immsk = GaussMask(msksize, sig);
    immsk = double(immsk);
    immsk = imfilter(immsk, hh);

    imgA_resized = double(imgA_resized);
    imgB_resized = double(imgB_resized);
    imgmsk = double(repmat(immsk, [1,1,3]));

    imgR = imgA_resized.*imgmsk + imgB_resized.*(1-imgmsk);

    imgB_new(y_B:y_B+block_size(1)-1, x_B:x_B+block_size(2)-1, :) = imgR;

    figure(i);
    imshow(uint8(imgB_new));
    pause(0.3);
end

function imMsk = GaussMask(msksize, sig)
    rows = msksize(1);
    cols = msksize(2);
    center = msksize/2;

    [x, y] = meshgrid(1:rows, 1:cols);
    dist = exp(-((x-center(2)).^2+(y-center(1)).^2)/(2*sig));
    imMsk = dist/max(dist(:));
end
