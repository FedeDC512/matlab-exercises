%% 1. Carica immagine e converti in scala di grigi
barbara = imread('../imgs/barbara.png');
barbara = rgb2gray(barbara);  

figure;
imshow(barbara);
title('Immagine originale');         

%% 2. Aggiunge rumore Salt & Pepper (20% dei pixel, 10% sale + 10% pepe)
barbara_noisy = barbara;
p = randperm(262144, 2*26214); % Estraggo a caso 2*26214 pixel dall'immagine (262144 = 512*512 pixel)

barbara_noisy(p(1:26214)) = 0; % I primi 26214 pixel diventano neri (0)
barbara_noisy(p(26214+1:end)) = 255; % Gli altri 26214 pixel diventano bianchi (255)

figure;
imshow(barbara_noisy);     
title('Immagine con rumore Salt & Pepper');

%% 3. Applica filtro mediano 3x3 a tutta l'immagine
barbara_median3 = medfilt2(barbara_noisy);     

figure;
imshow(barbara_median3);
title('Filtro Mediano 3x3 su tutta l''immagine');                

%% 4. Denoise selettivo: solo su pixel rumorosi (0 o 255)
barbara_denoised = barbara_noisy;

% Indici dei pixel bianchi (255) e neri (0):
b = find(barbara_noisy == 255); % Trovo dove l'immagine rumorosa è bianca
n = find(barbara_noisy == 0); % Trovo dove è nera

% Correggo solo quei pixel con il valore filtrato
barbara_denoised(b) = barbara_median3(b);
barbara_denoised(n) = barbara_median3(n);         

figure;
imshow(barbara_denoised);
title('Filtro Mediano solo su pixel rumorosi');

%% 5. Filtro Mediano più grande (11x11) su tutta l'immagine
barbara_median11 = medfilt2(barbara_noisy, [11 11]);

figure;
imshow(barbara_median11);
title('Filtro Mediano 11x11');

%% 6. Filtro Media (passa basso) con convoluzione 11x11
kernel = fspecial('average', [11 11]);  % Kernel uniforme 11x11
barbara_avg = conv2(single(barbara_noisy), kernel, 'same');

figure;
imshow(uint8(barbara_avg));
title('Filtro Media 11x11 con convoluzione');
