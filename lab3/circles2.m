clear;
clc;

fname = "Test_cir03.jpg";
img = imread(fname);
figure(1);
imshow(img);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
imgY = (img(:,:,1) + img(:,:,2) + img(:,:,3))/3; % 이미지 흑백 영상
imgY = double(imgY);
obj = imgY(55:55+21,105:105+21);
figure(2); imshow(obj);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
patt = flipud(fliplr(obj));
patt = patt/sum(patt(:)); % pattern을 필터처럼!, dc의 영향을 덜 받음.
patt = patt - mean(patt(:));

imgR = conv2(imgY, patt, 'same'); % convolution & correlation차이가 있음. flipud & flipping left right 함수 사용.
imgR = imgR/max(imgR(:));

figure(3); imshow(imgR);
figure(4); mesh(imgR);

num = 0;
rcpnt = zeros(num,2); % memory 관리를 매트랩 자체에서 사용
threshold = 0.6;
objsize = size(obj);
radr = ceil(objsize(1)/2);
radc = ceil(objsize(2)/2);

while(num < 1000)
    [maxval, r, c] = max2d(imgR);
    
    if maxval<threshold
        break;
    end
    num = num+1;

    rcpnt(num,1) = r;
    rcpnt(num,2) = c;

    % Erase
    rs = max(1, r-radr);
    re = min(size(imgR, 1), r+radr);
    cs = max(1, c-radc);
    ce = min(size(imgR, 2), c+radc);
    imgR(rs:re, cs:ce) = 0;
end

rad = radr;
color = [255, 0, 0];
imgC = DrawCross(img, rcpnt, rad, color);
figure(5); imshow(imgC);

function [maxval, r, c] = max2d(img)
%

[row, col] = size(img);

img = img';
vec = img(:);

[maxval, ind] = max(vec);

r = floor((ind-1)/col);
c = (ind-1) - r*col;

r = r+1;
c = c+1;
end


function [imgC] = DrawCross(img, rcpnt, rad, color)
%
%

imgC = img;
[num, wid] = size(rcpnt);

for n = 1: num
    r = rcpnt(n,1);
    c = rcpnt(n,2);

    rs = max(1, r-rad);
    re = min(size(imgC, 1), r+rad);
    cs = max(1, c-rad);
    ce = min(size(imgC, 2), c+rad);

    imgC(rs:re, c, 1) = color(1);
    imgC(r, cs:ce, 1) = color(1);
    
    imgC(rs:re, c, 2) = color(2);
    imgC(r, cs:ce, 2) = color(2);

    imgC(rs:re, c, 3) = color(3);
    imgC(r, cs:ce, 3) = color(3);
end

end
