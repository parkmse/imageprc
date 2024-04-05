clear; % remove variable
clc;

imgA = imread("baboon.png");
imgB = imread("lena.png");

% --> make img to video
alp = 0:0.1:1; % alp is form of vector
for i = 1: length(alp)
    ap = alp(i);
    img = (1-ap)*imgA + ap*imgB;    

    figure(i);
    imshow(img);
    pause(0.1);
end