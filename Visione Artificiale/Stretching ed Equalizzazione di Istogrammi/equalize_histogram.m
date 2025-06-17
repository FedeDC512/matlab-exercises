function out_img = equalize_histogram(img)
    % Implementazione dell'equalizzazione dell'istogramma tramite CDF e LUT.

    % Calcolo dell'istogramma
    hist_counts = imhist(img);
    
    % Numero totale di pixel
    num_pixels = numel(img);
    
    % Calcolo della Funzione di Ripartizione Cumulativa (CDF)
    % cumsum calcola l'istogramma cumulativo.
    % Divide per il totale pixel per normalizzare (valori tra 0 e 1).
    cdf = cumsum(hist_counts) / num_pixels;
    
    % Creazione della LUT dalla CDF
    % La trasformazione è data dalla CDF scalata sull'intervallo 0-255.
    lut = uint8(round(cdf * 255));
    
    % Applicazione della LUT all'immagine
    out_img = lut(img + 1);
end