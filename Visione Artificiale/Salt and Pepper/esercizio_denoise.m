img = imread('../imgs/lena.png');
img_gray = rgb2gray(img);

img_noisy = imnoise(img_gray, 'salt & pepper', 0.02); % Aggiunge rumore

%% Denoise con Filtro Media (media 3x3)
kernel = fspecial('average', [3,3]); % Filtro di media
img_denoised_avg = conv2(img_noisy, kernel, 'same');
img_denoised_avg = uint8(img_denoised_avg);

%% Denoise con Filtro Mediana (medfilt2)
img_denoised_median = medfilt2(img_noisy, [3 3]);

%% Visualizzazione dei risultati

figure;
imshow(img_gray);
title('Immagine originale');

figure;
imshow(img_noisy);
title('Con rumore Salt & Pepper');

figure;
imshow(img_denoised_avg);
title('Denoise con Filtro Media 3x3');

figure;
imshow(img_denoised_median);
title('Denoise con Filtro Mediana 3x3');