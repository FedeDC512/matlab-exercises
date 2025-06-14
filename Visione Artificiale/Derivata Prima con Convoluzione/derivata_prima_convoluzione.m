%% Parte 1: Derivata su vettore (differenza tra valori adiacenti)
v = 10 * rand(1, 8);  % Vettore casuale
disp('Vettore originale:');
disp(v);

% Calcolo della derivata discreta (differenze tra elementi successivi)
dv = v(1:end-1) - v(2:end);
disp('Derivata prima (differenze finite):');
disp(dv);

%% Parte 2: Derivata su immagine

% Caricamento immagine e conversione a tipo float
img = imread('../imgs/lena.png');
img = rgb2gray(img);

% Derivata orizzontale (dx): variazioni lungo le righe
dx = conv2(img, [-1 1], 'same');

% Derivata verticale (dy): variazioni lungo le colonne
dy = conv2(img, [-1; 1], 'same');

% Calcolo del modulo del gradiente (combinazione di dx e dy)
modulo_gradiente = sqrt(dx.^2 + dy.^2);

%% Visualizzazione
figure;
imshow(uint8(img));
title('Immagine originale');

figure;
imshow(dx, []);
title('Derivata orizzontale (dx)');

figure;
imshow(dy, []);
title('Derivata verticale (dy)');

figure;
imshow(modulo_gradiente, []);
title('Modulo del gradiente |∇I|');
