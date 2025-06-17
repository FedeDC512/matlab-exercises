function out_img = stretch_contrast(img)
    % Implementazione DIRETTA dello stretching del contrasto.
    % Applica la formula a ogni pixel.

    % Converte in double per i calcoli in virgola mobile
    img_double = double(img);
    
    % Trova il minimo e il massimo valore di grigio nell'immagine
    min_g = min(img_double(:));
    max_g = max(img_double(:));

    % Caso limite: immagine a colore costante per evitare divisione per zero
    if max_g == min_g
        out_img = img;
        return;
    end

    % Applica la formula di stretching
    % p_new = (p_old - min_g) / (max_g - min_g) * 255
    out_img_double = (img_double - min_g) / (max_g - min_g) * 255;
    
    % Riconverte a uint8, arrotondando il risultato
    out_img = uint8(round(out_img_double));
end