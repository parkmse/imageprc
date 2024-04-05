Intelligent Image Processing
이 저장소는 지능형 영상처리 과목의 실습 내용을 담고 있습니다.

실습 내용 요약
이미지 크기 조정(Image Resizing): 원본 이미지와 합성할 이미지를 동일한 크기로 조정합니다. MATLAB의 imresize 함수를 사용하여 선형 보간(bilinear interpolation) 방법을 적용했습니다.

이미지 대비 조정(Image Contrast Adjustment): 이미지의 밝기와 대비를 조정하여 이미지를 더 선명하게 만듭니다. a*imgA+b와 같은 선형 변환을 사용하여 대비를 조절합니다.

이미지 부분 추출(Extracting Image Parts): 연예인 이미지에서 눈, 코, 입 등의 부위를 추출하여 합성할 이미지와 조합합니다. MATLAB의 imcrop 함수를 사용하여 이미지 부분을 추출하고, size 함수를 사용하여 크기를 파악합니다.

마스킹(Masking): 이미지 부분을 부드럽게 처리하기 위해 가우시안 마스크(Gaussian Mask)를 사용합니다. 마스크를 생성하고, 추출한 이미지에 적용하여 자연스러운 효과를 적용합니다.

알파 블렌딩(Alpha Blending): 이미지를 합성하는 데 사용됩니다. 이미지와 동일한 크기의 Zero 이미지를 생성하고, 추출한 이미지의 부분을 Zero 이미지에 삽입하여 합성합니다.
