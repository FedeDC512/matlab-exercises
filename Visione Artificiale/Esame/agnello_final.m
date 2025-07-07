clear; close all;

img = imread('../imgs/peppers.png');
img = img(1:200, 1:200, :);
colors = 256;

[X,cmap] = rgb2ind(img, colors);
figure; imshow(img); title("Immagine Originale");
figure; imshow(X, cmap); title(['Quantizzazione usando rgb2ind con ', num2str(colors), ' colori']);

[immagine_quantizzata,final_colormap] = quantizzazione_custom(img, colors);
figure; imshow(immagine_quantizzata, final_colormap); title('Quantizzazione manuale');

function [immagine_quantizzata,final_colormap] = quantizzazione_custom(rgb_image, colors)

    immagine_quantizzata = rgb_image;
    [h, w, ~] = size(rgb_image);
    current_colormap = zeros(0, 3);
    current_img = zeros (h, w);

    index = 1;

    % Scorro l'immagine
    for i = 1:h
        for j = 1:w
            fprintf('Currently in px (%d, %d)\n', i, j); % Debug
                
            r = rgb_image(i, j, 1);
            g = rgb_image(i, j, 2);
            b = rgb_image(i, j, 3);
            current_color = [r g b]; % Nuovo colore

            is_new_color = true;
            [c_h, ~] = size(current_colormap);

            for p = 1:c_h % Scorro la palette
                % Se non è presente, lo segno
                if isequal(current_color, current_colormap(p, :))
                    is_new_color = false;
                    index = p;
                end
            end
                
            if is_new_color
                 % Altrimenti lo inserisco nella current_colormap
                current_colormap = [current_colormap; current_color];

                % Salvo nella nuova immagine (current_img) in coordinate i j
                % la riga del colore inserito nella palette (current_colormap)
                index = size(current_colormap, 1);
            end
            current_img(i, j) = index;
        end
    end

    % Normalizzo la palette (0-255 → 0-1)
    current_colormap = double(current_colormap); 
    current_colormap = current_colormap / 255;
    % Riduco il numero di colori nella palette
    [immagine_quantizzata,final_colormap] = imapprox(current_img,current_colormap,colors);

    fprintf("Colori nell'immagine originale: %d\n", size(current_colormap, 1));
    fprintf('Colori nella palette quantizzata: %d\n', size(final_colormap, 1));
end