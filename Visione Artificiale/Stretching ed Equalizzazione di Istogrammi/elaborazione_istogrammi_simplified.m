clear; clc; close all;

% Carica immagine standard a basso contrasto
img = imread('pout.tif');

% Stretching del contrasto automatico (funzione built-in)
img_stretched = imadjust(img);

% Equalizzazione dell'istogramma (funzione built-in)
img_equalized = histeq(img);

% Visualizza immagine originale e stretching
figure('Name', 'Stretching del Contrasto');
subplot(2,2,1); imshow(img); title('Originale');
subplot(2,2,2); imhist(img); title('Istogramma Originale');

subplot(2,2,3); imshow(img_stretched); title('Dopo Stretching');
subplot(2,2,4); imhist(img_stretched); title('Istogramma dopo Stretching');

% Visualizza immagine originale e equalizzata
figure('Name', 'Equalizzazione dell''Istogramma');
subplot(2,2,1); imshow(img); title('Originale');
subplot(2,2,2); imhist(img); title('Istogramma Originale');

subplot(2,2,3); imshow(img_equalized); title('Equalizzata');
subplot(2,2,4); imhist(img_equalized); title('Istogramma Equalizzato');

% CDF (funzione cumulativa di distribuzione)
cdf_orig = cumsum(imhist(img)) / numel(img);
cdf_eq = cumsum(imhist(img_equalized)) / numel(img);

figure('Name', 'CDF');
plot(0:255, cdf_orig, 'b', 'LineWidth', 2); hold on;
plot(0:255, cdf_eq, 'r--', 'LineWidth', 2);
legend('Originale', 'Equalizzata'); title('CDF');
xlabel('Livello di Grigio'); ylabel('Probabilità Cumulativa'); grid on;
