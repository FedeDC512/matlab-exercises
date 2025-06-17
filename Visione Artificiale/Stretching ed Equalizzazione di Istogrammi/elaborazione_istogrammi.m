clear;
clc;
close all;

% Carica un'immagine di test a basso contrasto
% 'pout.tif' è un'immagine standard di MATLAB
img = imread('pout.tif');

%% Stretching del Contrasto (Dilatazione)
img_stretched = stretch_contrast(img);

% --- Visualizzazione dei risultati ---
figure('Name', 'Stretching del Contrasto', 'NumberTitle', 'off');

% Immagine Originale
subplot(2, 2, 1);
imshow(img);
title('Immagine Originale');

% Istogramma Originale
subplot(2, 2, 2);
imhist(img);
title('Istogramma Originale');
ylim([0 3000]); % Imposta un limite sull'asse y per una migliore visualizzazione

% Immagine con Stretching
subplot(2, 2, 3);
imshow(img_stretched);
title('Immagine dopo Stretching');

% Istogramma dopo Stretching
subplot(2, 2, 4);
imhist(img_stretched);
title('Istogramma dopo Stretching');
ylim([0 3000]);

%% Equalizzazione dell'Istogramma

% Applichiamo la nostra funzione di equalizzazione
% Nota: MATLAB ha una funzione built-in 'histeq', ma qui usiamo la nostra
% per scopi didattici. Il risultato è praticamente identico.
img_equalized = equalize_histogram(img);

% --- Visualizzazione dei risultati ---
figure('Name', 'Equalizzazione dell''Istogramma', 'NumberTitle', 'off');

% Immagine Originale
subplot(2, 2, 1);
imshow(img);
title('Immagine Originale');

% Istogramma Originale
subplot(2, 2, 2);
imhist(img);
title('Istogramma Originale');
ylim([0 3000]);

% Immagine Equalizzata
subplot(2, 2, 3);
imshow(img_equalized);
title('Immagine Equalizzata');

% Istogramma Equalizzato
subplot(2, 2, 4);
imhist(img_equalized);
title('Istogramma Equalizzato');
ylim([0 3000]);

%% Istogramma Cumulativo (CDF)
% La CDF di un'immagine equalizzata tende ad essere una linea retta (rampa)

% Calcola gli istogrammi
hist_originale = imhist(img);
hist_equalized = imhist(img_equalized);

% Calcoliamo le CDF (istogrammi cumulativi normalizzati)
num_pixels = numel(img);
cdf_originale = cumsum(hist_originale) / num_pixels;
cdf_equalized = cumsum(hist_equalized) / num_pixels;

% --- Visualizzazione della CDF ---
figure('Name', 'Verifica con Istogramma Cumulativo (CDF)', 'NumberTitle', 'off');
plot(0:255, cdf_originale, 'b-', 'LineWidth', 2);
hold on;
plot(0:255, cdf_equalized, 'r--', 'LineWidth', 2);
hold off;
title('Confronto tra CDF Originale e Equalizzata');
xlabel('Livello di Grigio');
ylabel('Probabilità Cumulativa');
legend('CDF Originale', 'CDF Equalizzata (quasi lineare)');
grid on;
axis([0 255 0 1]);

%% Ottimizzazione con LUT
%
% Nell'implementazione dello stretching con una LUT, il risultato visivo è identico ma è molto più efficiente.

img_stretched_lut = stretch_contrast_lut(img);

% Verifichiamo che i risultati siano identici
differenza = sum(abs(img_stretched(:) - img_stretched_lut(:)));
if differenza == 0
    disp('Risultato con LUT è identico a quello con calcolo diretto. Ottimizzazione riuscita!');
else
    disp('I risultati sono leggermente diversi a causa di approssimazioni numeriche.');
end
