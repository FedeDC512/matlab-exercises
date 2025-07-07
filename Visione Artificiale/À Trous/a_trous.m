clear; close all; clc;

immagine_originale = double(imread('cameraman.tif'));

% Kernel B-spline bicubico 5x5 (per smussare l'immagine)
kernel_bicubico = (1/256) * [ ...
    1,  4,  6,  4, 1;
    4, 16, 24, 16, 4;
    6, 24, 36, 24, 6;
    4, 16, 24, 16, 4;
    1,  4,  6,  4, 1 ];

% Numero di livelli wavelet
num_livelli = 3;

% Inizializza immagine corrente e piani wavelet
immagine_corrente = immagine_originale;
piani_wavelet = cell(1, num_livelli);

% Ciclo sui livelli
for livello = 1:num_livelli
    % Dilata il kernel con zeri secondo il livello (à trous)
    fattore_dilatazione = 2^(livello - 1);
    kernel_dilatato = dilata_kernel_con_zeri(kernel_bicubico, fattore_dilatazione);

    % Smussa immagine e calcola dettaglio (differenza)
    immagine_smussata = conv2(immagine_corrente, kernel_dilatato, 'same');
    piani_wavelet{livello} = immagine_corrente - immagine_smussata;

    % Aggiorna immagine corrente
    immagine_corrente = immagine_smussata;
end

% Residuo finale (immagine molto smussata)
residuo_finale = immagine_corrente;

% Ricostruzione: somma residuo + tutti i dettagli
immagine_ricostruita = residuo_finale;
for livello = 1:num_livelli
    immagine_ricostruita = immagine_ricostruita + piani_wavelet{livello};
end

% Visualizzazione
figure, imshow(uint8(immagine_originale)), title('Immagine Originale');
figure, imshow(residuo_finale, []), title('Residuo (smussato)');
figure, imshow(uint8(immagine_ricostruita)), title('Immagine Ricostruita');
for livello = 1:num_livelli
    figure, imshow(piani_wavelet{livello}, []), title(['Dettaglio Livello ', num2str(livello)]);
end

% Funzione: dilata il kernel base con zeri secondo lo spacing (à trous)
function kernel_dilatato = dilata_kernel_con_zeri(kernel_originale, spaziatura)
    % Calcola la nuova dimensione del kernel dilatato
    [righe, colonne] = size(kernel_originale);
    nuove_righe = 1 + (righe - 1) * spaziatura;
    nuove_colonne = 1 + (colonne - 1) * spaziatura;

    % Crea una matrice piena di zeri della dimensione desiderata
    kernel_dilatato = zeros(nuove_righe, nuove_colonne);

    % Inserisce i valori del kernel originale nelle posizioni giuste
    kernel_dilatato(1:spaziatura:end, 1:spaziatura:end) = kernel_originale;
end

