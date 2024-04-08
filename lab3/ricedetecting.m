% Detecting rice grains

clear;
clc;

% Read an image
img = imread('rice.png');
if size(img,3)==1
   gray = double(img);
else
    gray = double(rgb2gray(img));
end

figure(1);
imshow(uint8(gray));

lowpassfilter = fspecial('Gaussian', [15 15], 1);
filtered = imfilter(gray, lowpassfilter, 'replicate');

improved = gray - filtered;

improved = uint8(improved + abs(min(improved(:))));
figure(2);
imshow(improved);

% Detecting edges after background removal
edges = edge(improved,'canny');

figure(3);
imshow(edges);

% Binarization and noise reduction
thresh = graythresh(improved);  
imgB = imbinarize(improved, thresh); % Binarize image

se = strel('square', 2);  
imgB = imerode(imgB, se); 
imgB = imdilate(imgB, se); 

% Compute connected components
cc = bwconncomp(imgB);

% Extract area data
grainData = regionprops(cc, 'Area');
grainAreas = [grainData.Area];


% Display histogram of grain areas
figure(4);
hist(grainAreas, 100); % 50 bins
title('Histogram of Rice Grain Areas');
xlabel('Area');
ylabel('Number of Grains');


% threshold value
areaThreshold = 28;  

% Compute connected components
cc = bwconncomp(imgB);

% Extract area and centroid data
grainData = regionprops(cc, 'Area', 'Centroid');


grainTable = struct2table(grainData);  

% Order the grains
orderedGrains = sortrows(grainTable, 'Area', 'descend');

% Remove grains with area less than the threshold
filteredGrains = orderedGrains(orderedGrains.Area >= areaThreshold, :);

% Display the original binary image
figure(6);
imshow(imgB);
hold on;
Num = size(filteredGrains, 1);
title(["Detected: ", num2str(Num)]);


for k = 1:height(filteredGrains)
    x = filteredGrains.Centroid(k, 1);
    y = filteredGrains.Centroid(k, 2);
    text(x, y, num2str(k), 'Color', 'r');
end

hold off;
