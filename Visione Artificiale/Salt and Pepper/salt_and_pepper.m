img = imread('../imgs/lena.png');
img_gray = rgb2gray(img);

%% Metodo 1: rand con soglie (approccio probabilistico)

[h, w] = size(img_gray);
a = rand(h, w); % Matrice di valori casuali tra 0 e 1

salt = a > 0.98; % 2% di pixel bianchi (255)
pepper = a < 0.02; % 2% di pixel neri (0)

img_rand = img_gray; % Copia dell'immagine originale
img_rand(salt) = 255;
img_rand(pepper) = 0;

figure;
imshow(img_rand);
title('Rumore S&P con rand e soglie (probabilistico)');

%% Metodo 2: randperm (controllo preciso)

img_randperm = img_gray;
num_pixel = numel(img_gray); % h * w
num_noisy = round(0.04 * num_pixel);  % 4% di pixel con rumore

indices = randperm(num_pixel, num_noisy);  % Pixel da alterare
half = round(num_noisy / 2);

img_randperm(indices(1:half)) = 0;     % Pepe (nero)
img_randperm(indices(half+1:end)) = 255; % Sale (bianco)

figure;
imshow(img_randperm);
title('Rumore S&P con randperm (esatto)');