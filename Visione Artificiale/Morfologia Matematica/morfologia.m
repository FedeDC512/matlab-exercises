clear;
close all;
clc;

%% 1. Preparazione dell'Immagine e dell'Elemento Strutturante (SE)

% Carichiamo un'immagine di test standard di MATLAB
img_originale = imread('cameraman.tif');

% Definiamo l'Elemento Strutturante (SE).
% Usiamo una struct per contenere sia la maschera che l'origine.
% La maschera è il "minimo rettangolo di ricoprimento".
% L'origine ("pallino rosso") è specificata separatamente.

% Creiamo un SE non simmetrico per testare meglio il ribaltamento.
SE.mask = logical([
    0 1 1;
    1 1 0;
    1 0 0
]);
% Definiamo l'origine (riga, colonna). NOTA: non è il centro!
SE.origin = [2, 1]; % Il pixel '1' alla riga 2, colonna 1

fprintf('Elemento Strutturante (SE) personalizzato:\n');
disp(SE.mask);
fprintf('Origine (pallino rosso) in posizione: [%d, %d]\n\n', SE.origin(1), SE.origin(2));


%% 2. Esecuzione delle Nostre Funzioni Morfologiche

fprintf('Esecuzione delle funzioni personalizzate...\n');
img_erosa = my_erode(img_originale, SE);
img_dilatata = my_dilate(img_originale, SE);
img_aperta = my_open(img_originale, SE);
img_chiusa = my_close(img_originale, SE);


%% 3. Confronto con le Funzioni Native di MATLAB

% Le funzioni MATLAB (es. imerode) assumono che l'origine sia al centro
% del rettangolo di ricoprimento dell'SE. Per fare un confronto corretto,
% dobbiamo creare un SE con l'origine al centro geometrico.
[h, w] = size(SE.mask);
se_matlab = strel('arbitrary', SE.mask); % Usiamo la nostra maschera

% Le funzioni native sono equivalenti alle nostre se l'origine è al centro.
% Se il nostro SE fosse simmetrico e centrato, i risultati sarebbero identici.
% Poiché il nostro SE è asimmetrico, i risultati saranno diversi.
img_erosa_matlab = imerode(img_originale, se_matlab);
img_dilatata_matlab = imdilate(img_originale, se_matlab);
img_aperta_matlab = imopen(img_originale, se_matlab);
img_chiusa_matlab = imclose(img_originale, se_matlab);

fprintf('Confronto con le funzioni MATLAB (che usano origine centrale) completato.\n');


%% 4. Visualizzazione dei Risultati

figure('Name', 'Morfologia Matematica: Erosione e Dilatazione', 'NumberTitle', 'off');
subplot(2, 3, 1); imshow(img_originale); title('Immagine Originale');
subplot(2, 3, 2); imshow(img_erosa); title('Mia Erosione (Origine non centrale)');
subplot(2, 3, 3); imshow(img_erosa_matlab); title('imerode MATLAB (Origine centrale)');
subplot(2, 3, 5); imshow(img_dilatata); title('Mia Dilatazione (Origine non centrale)');
subplot(2, 3, 6); imshow(img_dilatata_matlab); title('imdilate MATLAB (Origine centrale)');

figure('Name', 'Morfologia Matematica: Apertura e Chiusura', 'NumberTitle', 'off');
subplot(2, 3, 1); imshow(img_originale); title('Immagine Originale');
subplot(2, 3, 2); imshow(img_aperta); title('Mia Apertura');
subplot(2, 3, 3); imshow(img_aperta_matlab); title('imopen MATLAB');
subplot(2, 3, 5); imshow(img_chiusa); title('Mia Chiusura');
subplot(2, 3, 6); imshow(img_chiusa_matlab); title('imclose MATLAB');


%% 5. Test di Correttezza (Verifica)

% Per verificare che la nostra logica sia corretta, la testiamo su un caso
% in cui i risultati DEVONO essere identici a quelli di MATLAB.
% Usiamo un SE con origine centrale.
SE_centrato.mask = SE.mask;
SE_centrato.origin = [floor(h/2) + 1, floor(w/2) + 1]; % Centro geometrico

% Eseguiamo solo l'erosione per la verifica
img_erosa_test = my_erode(img_originale, SE_centrato);

% Confrontiamo con isequal
are_equal = isequal(img_erosa_test, img_erosa_matlab);

fprintf('\n--- Test di Correttezza ---\n');
if are_equal
    fprintf('RISULTATO: La mia funzione my_erode (con origine centrale) produce un output IDENTICO a imerode di MATLAB.\n');
else
    fprintf('RISULTATO: La mia funzione my_erode (con origine centrale) produce un output DIVERSO da imerode di MATLAB. C''è un errore.\n');
end