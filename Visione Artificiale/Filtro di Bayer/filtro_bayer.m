img = imread('../imgs/lena.png');
img_gray = rgb2gray(img);

[h, w] = size(img_gray);
bayerRGB = zeros(h, w, 3, 'like', img);

% Maschere per ogni canale
maskR = false(h, w);
maskG = false(h, w);
maskB = false(h, w);

% Filtro Bayer (RGGB)
% R G
% G B

maskR(1:2:end, 1:2:end) = true;  % R in righe dispari, colonne dispari
maskG(1:2:end, 2:2:end) = true;  % G in righe dispari, colonne pari
maskG(2:2:end, 1:2:end) = true;  % G in righe pari, colonne dispari
maskB(2:2:end, 2:2:end) = true;  % B in righe pari, colonne pari

% Applica img_gray solo ai pixel della rispettiva maschera
bayerRGB(:,:,1) = uint8(maskR) .* img_gray;  % Rosso
bayerRGB(:,:,2) = uint8(maskG) .* img_gray;  % Verde
bayerRGB(:,:,3) = uint8(maskB) .* img_gray;  % Blu

figure;
imshow(bayerRGB);
title('Pattern Bayer simulato a colori (RGB)');