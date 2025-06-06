img = imread('../imgs/lena.png');
img_gray = rgb2gray(img);

bayer = zeros(size(img_gray), 'like', img_gray);

% Filtro Bayer (RGGB)
% R G
% G B

bayer(1:2:end, 1:2:end) = img_gray(1:2:end, 1:2:end); % R (rosso)
bayer(1:2:end, 2:2:end) = img_gray(1:2:end, 2:2:end); % G (verde alto)
bayer(2:2:end, 1:2:end) = img_gray(2:2:end, 1:2:end); % G (verde basso)
bayer(2:2:end, 2:2:end) = img_gray(2:2:end, 2:2:end); % B (blu)

figure;
imshow(img_gray);
title('Immagine originale in scala di grigi');

figure;
imshow(bayer);
title('Pattern Bayer applicato (grayscale)');