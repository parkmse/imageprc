% lab 01: Point operations

fname = 'face.jpg';  % natural image -> jpeg이 잘어울림
img = imread(fname);

figure(1);
imshow(img);

imgG = img(:,:,1); % r spectrum
imgG = img(:,:,2); % G spectrum
imgB = img(:,:,3); % B spectrum

figure(2);
imshow([imgG, imgG, imgB]);

% Histogram
% figure(3);
% histogram(imgR, 256);
% figure(4);
% histogram(imgG, 256);
% figure(5);
hdata = histogram(imgB, 256);
histcnt = hdata.BinCounts;
figure(3);
stem(histcnt, 'k.');

% Image Contrast 조절
% imgY = a*imgX + b
a = 2; b = 0; %contrast증가를 위해 a를 1보다 크게
imgY = a*imgB + b;
figure(4);
imshow([imgB, imgY]);

% Histogram Stretching
imgX = double(imgB);
xmin = min(imgX(:));
xmax = max(imgX(:));
ymin = 0;
ymax = 255;
a = (ymax-ymin)/(xmax-xmin);
b = -a*xmin; 
imgY = a*imgX+b;
figure(5);
imshow([imgX, imgY]/255);

% Histogram Equalization
imgEQ = histeq(imgB); % hiseq's input variable is integer
figure(6);
imshow([imgB, imgEQ]);
figure(7);
imhist(imgEQ);



% 이미지 읽기
fname = 'face.jpg'; 
img = imread(fname);

% Blue spectrum 
imgG = img(:,:,1);

% 전체 픽셀 수 계산
total_pixels = numel(imgG);

% 초기 오차범위 설정
error_range = 0.1;
min_error = inf;
best_min_pixel = 0;
best_max_pixel = 255;

% 오차범위를 줄여가면서 최적의 최소 및 최대 픽셀 값 찾기
for i = 1:50
    % 현재 오차범위 계산
    current_error = abs((best_min_pixel + best_max_pixel) / 2 - total_pixels * error_range);
    
    % 오차범위가 최소인 경우 종료
    if current_error < min_error
        break;
    end
    
    % 최소 및 최대 픽셀 값 계산
    [min_pixel, max_pixel] = find_min_max_from_histogram(imgG);
    
    % 오차범위 갱신
    current_error = abs((min_pixel + max_pixel) / 2 - total_pixels * error_range);
    if current_error < min_error
        min_error = current_error;
        best_min_pixel = min_pixel;
        best_max_pixel = max_pixel;
    end
    
    % 이미지 화질 개선
    imgX = double(imgG);
    imgY = (imgX - best_min_pixel) ./ (best_max_pixel - best_min_pixel) * 255;
    imgY = uint8(imgY);
    figure;
    subplot(1, 2, 1);
    imshow(imgG);
    title('Origin');
    subplot(1, 2, 2);
    imshow(imgY);
    title('Improved');
    
    % 최적의 최소 및 최대 픽셀 값을 출력
    fprintf('Iteration %d: Min Pixel = %d, Max Pixel = %d\n', i, best_min_pixel, best_max_pixel);
    
    % 최소 및 최대 픽셀 값을 범위 내에서 조정
    range = (best_max_pixel - best_min_pixel) / 2;
    best_min_pixel = max(best_min_pixel - range, 0);
    best_max_pixel = min(best_max_pixel + range, 255);
end

imgEQ = histeq(imgG);
figure;
subplot(1, 2, 1);
imshow(imgG);
title('Origin');
subplot(1, 2, 2);
imshow(imgEQ);
title('Improved');


imgG = imread('mmf.jpg');

% 히스토그램 평활화 적용
img_eq = histeq(imgG);

% 개선된 이미지와 히스토그램 출력
figure;
subplot(1,2,1);
imshow(imgG);
title('Original Image');
subplot(1,2,2);
imshow(img_eq);
title('Improved Image');
figure;
subplot(1,2,1);
imhist(imgG);
title('Original Histogram');
subplot(1,2,2);
imhist(img_eq);
title('Improved Histogram');





