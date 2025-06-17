function output_img = my_open(input_img, SE_struct)

% 1. Esegui l'erosione con l'SE originale
img_erosa = my_erode(input_img, SE_struct);

% 2. Ribalta l'elemento strutturante (operatore cappello S_hat)
flipped_SE = flip_se(SE_struct);

% 3. Esegui la dilatazione sull'immagine erosa usando l'SE ribaltato
output_img = my_dilate(img_erosa, flipped_SE);

end