% Carica immagine in scala di grigi
img = imread('cameraman.tif'); % Immagine di test
img = double(img); % Conversione a double

[h_piccola, w_piccola] = size(img);

% Imposta l’angolo di rotazione in gradi
angolo_gradi = 30;
alpha = deg2rad(angolo_gradi); % Conversione in radianti

% Calcola le coordinate dei 4 vertici dell’immagine originale rispetto al centro
cx_p = w_piccola / 2;
cy_p = h_piccola / 2;

% Vertici (x, y) rispetto al centro
vertici = [
    -cx_p, -cy_p;   % A
     cx_p, -cy_p;   % B
     cx_p,  cy_p;   % C
    -cx_p,  cy_p    % D
];

% Ruota i 4 vertici
R = [cos(alpha), -sin(alpha); sin(alpha), cos(alpha)];
vertici_rot = (R * vertici')';

% Calcola dimensioni bounding box dell’immagine ruotata
max_x = max(abs(vertici_rot(:,1)));
max_y = max(abs(vertici_rot(:,2)));
W_grande = 2 * ceil(max_x) + 1;
H_grande = 2 * ceil(max_y) + 1;

% Centro dell’immagine grande
cx_g = W_grande / 2;
cy_g = H_grande / 2;

% Inizializza immagine ruotata
img_ruotata = zeros(H_grande, W_grande);

% Mapping inverso: per ogni pixel dell'immagine ruotata, troviamo da dove proviene
for yg_idx = 1:H_grande
    for xg_idx = 1:W_grande
        % Coordinate rispetto al centro
        Xg = xg_idx - cx_g;
        Yg = yg_idx - cy_g;

        % Coordinate inverse (da immagine grande → immagine piccola)
        xp =  Xg * cos(alpha) + Yg * sin(alpha);
        yp = -Xg * sin(alpha) + Yg * cos(alpha);

        % Indici nella matrice dell’immagine piccola
        xp_idx = round(xp + cx_p);
        yp_idx = round(yp + cy_p);

        % Se dentro i limiti, copia il pixel
        if xp_idx >= 1 && xp_idx <= w_piccola && yp_idx >= 1 && yp_idx <= h_piccola
            img_ruotata(yg_idx, xg_idx) = img(yp_idx, xp_idx);
        end
    end
end

% Rotazione con funzione MATLAB
img_ruotata_builtin = imrotate(img, -angolo_gradi, 'nearest', 'loose');

% Mostra risultati
figure;
imshow(uint8(img));
title('Originale');

figure;
imshow(uint8(img_ruotata));
title(['Ruotata di ', num2str(angolo_gradi), '°']);

figure;
imshow(uint8(img_ruotata_builtin));
title('Rotazione con imrotate');
