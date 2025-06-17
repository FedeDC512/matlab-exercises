%% 1. Caricamento immagine e conversione
img_rgb = imread('../imgs/peppers.png'); % Immagine truecolor
img_gray = rgb2gray(img_rgb); % Conversione in scala di grigi
img_gray = single(img_gray); % Conversione a float per convoluzioni

%% 2. Calcolo dei gradienti dx e dy tramite convoluzione
dx = conv2(img_gray, [-1 1], 'same'); % Derivata orizzontale
dy = conv2(img_gray, [-1; 1], 'same'); % Derivata verticale

%% 3. Modulo e direzione del gradiente
m = sqrt(dx.^2 + dy.^2); % Modulo del gradiente
a = atan2(dy, dx); % Direzione (angolo) in [-pi, pi]

%% 4. Codifica dell’angolo del gradiente in [0, 255]
a2 = uint8(255 * (a + pi) / (2 * pi)); % Mapping angolo → range 0–255
a2(m == 0) = 0; % Dove non c'è gradiente, metti nero

%% 5. Visualizzazione
figure;
imshow(img_rgb);
title('Immagine Truecolor (RGB)');

figure;
imshow(img_gray, []);
title('Scala di grigi');

figure;
imshow(m, []);
title('Modulo del gradiente');

figure;
imshow(a2, hsv(256));
title('Direzione del gradiente (HSV)');

%% 6. Sogliatura: evidenzia contorni forti
figure;
imshow(m > 128, []);
title('Contorni forti (m > 128)');

figure;
imshow(m > 30, []);
title('Contorni leggeri (m > 30)');

figure;
imshow(m > 10, []);
title('Contorni lievi (m > 10)');

%% 🔎 7. Extra: Tavolozze e HSV semplificata
% Visualizza la tavolozza HSV con 8 colori (per esplorazione)
disp('HSV Palette (8 colori):');
hsvPalette = round(255 * hsv(8));
disp(hsvPalette);

% Visualizza la direzione del gradiente con solo 16 colori
figure;
imshow(a2, hsv(16));
title('Direzione con HSV a 16 colori');