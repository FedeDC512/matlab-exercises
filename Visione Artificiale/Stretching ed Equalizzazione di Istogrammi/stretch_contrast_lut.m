function out_img = stretch_contrast_lut(img)
    % Implementazione dello stretching tramite LOOKUP TABLE (LUT).
    % Molto più efficiente su immagini grandi.

    % Trova il minimo e il massimo (lavora su uint8 per efficienza)
    min_g = double(min(img(:)));
    max_g = double(max(img(:)));
    
    % Caso limite
    if max_g == min_g
        out_img = img;
        return;
    end
    
    % Creazione della LUT
    lut = zeros(256, 1, 'uint8'); % Pre-allochiamo la LUT
    for g = 0:255
        % Calcola il nuovo valore per ogni possibile livello di grigio
        new_val = (g - min_g) / (max_g - min_g) * 255;
        % Memorizza nella LUT (g+1 per l'indicizzazione di MATLAB)
        lut(g + 1) = uint8(round(new_val));
    end
    
    % Applicazione della LUT
    % Questa operazione è vettorizzata e molto veloce.
    % Per ogni pixel in 'img', prende il valore corrispondente dalla LUT.
    out_img = lut(img + 1);
end