function output_img = my_close(input_img, SE_struct)

% 1. Esegui la dilatazione con l'SE originale
img_dilatata = my_dilate(input_img, SE_struct);

% 2. Ribalta l'elemento strutturante (operatore cappello S_hat)
flipped_SE = flip_se(SE_struct);

% 3. Esegui l'erosione sull'immagine dilatata usando l'SE ribaltato
output_img = my_erode(img_dilatata, flipped_SE);

end