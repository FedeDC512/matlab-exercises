function output_img = my_erode(input_img, SE_struct)

% Estrai maschera e origine dalla struct
se_mask = SE_struct.mask;
origin = SE_struct.origin;

% Ottieni le dimensioni dell'immagine e dell'SE
[img_h, img_w] = size(input_img);
[se_h, se_w] = size(se_mask);

% Pre-alloca l'immagine di output con zeri.
% Lavoriamo con double per i calcoli per evitare problemi con i tipi interi.
output_img = zeros(img_h, img_w, 'double');

% Usiamo un doppio ciclo for per scorrere l'immagine. Questo approccio è
% meno efficiente rispetto alla vettorizzazione ("ragionare in matlabese"),
% ma è molto più semplice da leggere e comprendere, rispecchiando la
% definizione teorica dell'operazione.

% Scansiona ogni pixel dell'immagine di output
for r_img = 1:img_h
    for c_img = 1:img_w
        
        % Per ogni pixel (r_img, c_img), troviamo il minimo nel suo intorno
        % definito dall'SE.
        
        min_val = 255; % Inizializza al valore massimo possibile per uint8
        
        % Scansiona l'elemento strutturante
        for r_se = 1:se_h
            for c_se = 1:se_w
                
                % Considera solo i pixel "attivi" (a 1) nell'SE
                if se_mask(r_se, c_se) == 1
                    
                    % Calcola le coordinate del pixel corrispondente
                    % nell'immagine di input, basandosi sull'origine dell'SE.
                    r_vicino = r_img + (r_se - origin(1));
                    c_vicino = c_img + (c_se - origin(2));
                    
                    % GESTIONE DEI BORDI:
                    % Ignora i vicini che cadono fuori dall'immagine.
                    if (r_vicino >= 1 && r_vicino <= img_h && ...
                        c_vicino >= 1 && c_vicino <= img_w)
                        
                        % Aggiorna il valore minimo
                        pixel_val = double(input_img(r_vicino, c_vicino));
                        if pixel_val < min_val
                            min_val = pixel_val;
                        end
                    end
                end
            end
        end
        
        % Assegna il minimo trovato al pixel di output
        output_img(r_img, c_img) = min_val;
    end
end

% Riconverti l'immagine di output al tipo originale
output_img = cast(output_img, class(input_img));

end