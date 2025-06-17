function output_img = my_dilate(input_img, SE_struct)

% Estrai maschera e origine dalla struct
se_mask = SE_struct.mask;
origin = SE_struct.origin;

% Ottieni le dimensioni
[img_h, img_w] = size(input_img);
[se_h, se_w] = size(se_mask);

% Pre-alloca l'immagine di output
output_img = zeros(img_h, img_w, 'double');

% Scansiona ogni pixel dell'immagine di output
for r_img = 1:img_h
    for c_img = 1:img_w
        
        % Inizializza al valore minimo possibile
        max_val = 0; 
        
        % Scansiona l'elemento strutturante
        for r_se = 1:se_h
            for c_se = 1:se_w
                
                if se_mask(r_se, c_se) == 1
                    % Calcola coordinate del vicino nell'input
                    r_vicino = r_img + (r_se - origin(1));
                    c_vicino = c_img + (c_se - origin(2));
                    
                    % Gestione dei bordi
                    if (r_vicino >= 1 && r_vicino <= img_h && ...
                        c_vicino >= 1 && c_vicino <= img_w)
                        
                        % Aggiorna il valore massimo
                        pixel_val = double(input_img(r_vicino, c_vicino));
                        if pixel_val > max_val
                            max_val = pixel_val;
                        end
                    end
                end
            end
        end
        
        % Assegna il massimo trovato al pixel di output
        output_img(r_img, c_img) = max_val;
    end
end

% Riconverti l'immagine di output al tipo originale
output_img = cast(output_img, class(input_img));

end