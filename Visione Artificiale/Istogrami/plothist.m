function h = plothist(img)
    % Funzione per visualizzare un istogramma come immagine + barra di grigi

    h = imhist(uint8(img), 256); % Istogramma a 256 livelli
    m = 101 - ceil(100 * single(h) / single(max(h))); % Riga di partenza di ogni barra

    out = uint8(ones(120, 256) * 255); % Immagine bianca (120 righe, 256 colonne)

    % Disegna le barre nere dell'istogramma
    for i = 1:256
        out(m(i):100, i) = 0; % Barre verticali nere dalla riga m(i) a 100
    end

    % Disegna la barra del gradiente in basso (livelli di grigio)
    for i = 1:256
        out(102:120, i) = i - 1; % Riga 102–120: gradient bar (valori 0–255)
    end

    figure;
    imshow(out);
    title('Istogramma con funzione personalizzata');
end
