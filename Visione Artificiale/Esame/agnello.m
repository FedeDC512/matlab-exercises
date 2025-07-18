close all; 

img = game;

colors = 256;

[X,cmap] = rgb2ind(img, colors);
figure; imshow(img); title("Immagine Originale");
figure; imshow(X, cmap); title(['Quantizzazione usando rgb2ind con ', num2str(colors), ' colori']);

test =img(1, 1, 1);
[immagine_quantizzata,final_colormap] = quantizzazione_custom(img, colors);
figure; imshow(immagine_quantizzata, final_colormap); title('Quantizzazione manuale');

function [immagine_quantizzata,final_colormap] = quantizzazione_custom(rgb_image, colors)

    immagine_quantizzata = rgb_image;
    [h, w, ~] = size(rgb_image);
    current_colormap = [0 0 0];
    current_img = zeros (h, w);

    % Scorro l'immagine
    for i = 1:h
        for j = 1:w
                
            r = rgb_image(i, j, 1);
            g = rgb_image(i, j, 2);
            b = rgb_image(i, j, 3);
            current_color = [r g b]; % Nuovo colore

            is_new_color = true;
            [c_h, ~, ~] = size(current_colormap);

            for w = 1:c_h % Scorro la palette
                % Se non è presente, lo segno
                if current_color == current_colormap(w, :)
                    is_new_color = false;
                end
            end
                
            if is_new_color
                 % Altrimenti non lo inserisco nella current_colormap
                current_colormap = aggiungi_colore_palette(current_color, current_colormap);

                % Salvo nella nuova immagine (current_img) in coordinate i j
                % la riga del colore inserito nella palette (current_colormap)
            end

        end
    end

    % current_colormap è la nuova palette

    % Creo n parallelepipedi nel cubo rgb per gli n colori della nuova 
    % palette

    % Restringo i parallelepipedi il più possibile

    % Prendo il valore rappresentante per ogni parallelepipedo, come
    % media dei valori o prendendo il valore presente nell'immagine più
    % vicino al centro del parallelepipedo (migliore)

    % Creo una nuova palette in cui i colori dell'immagine originale
    % contenuti in uno specifico parallelepipedo sono sostituiti da quello
    % rappresentante

    % Applico la nuova palette alla nuova immagine che contiene i valori
    % delle posizioni dei colori nella palette

    [immagine_quantizzata,final_colormap] = imapprox(current_img,current_colormap,colors);
end

function new_palette = aggiungi_colore_palette(colore, palette)
    [h, ~] = size(palette);
    
    new_palette = zeros(h, 3);
    new_palette(:,:) = palette(:,:);
    new_palette(h,:) = colore;
end