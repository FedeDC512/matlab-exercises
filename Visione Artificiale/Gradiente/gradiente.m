%% 1. Caricamento e preparazione immagine
img = imread('../imgs/barbara.png');
img = rgb2gray(img);  

%% 2. Calcolo delle derivate orizzontale e verticale con convoluzione
dx = conv2(img, [-1 1], 'same'); % Derivata in direzione x
dy = conv2(img, [-1; 1], 'same'); % Derivata in direzione y

%% 3. Modulo del gradiente (con prodotto puntuale)
% Il punto (.) indica operazione elemento per elemento
m = sqrt(dx.^2 + dy.^2); % Modulo: misura dell'intensità del bordo

%% 4. Direzione del gradiente (angolo)
a = atan2(dy, dx); % Angolo del gradiente, in radianti [-pi, pi]

%% 5. Normalizzazione dell'angolo per visualizzarlo
a2 = uint8(255 * (a + pi) / (2 * pi)); % Mappa angolo [-pi, pi] in [0, 255]

% Rendi neri i pixel dove il gradiente è nullo (nessuna direzione)
a2(m == 0) = 0;

%% 6. Visualizzazione dei risultati
figure;
imshow(uint8(img));
title('Immagine originale');

figure;
imshow(m, []);
title('Modulo del gradiente |∇I|');

figure;
imshow(a2, hsv(256));
title('Direzione del gradiente (HSV)');