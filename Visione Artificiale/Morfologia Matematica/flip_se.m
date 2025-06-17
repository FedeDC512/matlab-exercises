function flipped_SE = flip_se(SE_struct)

% Estrai maschera e origine
se_mask = SE_struct.mask;
origin = SE_struct.origin;
[h, w] = size(se_mask);

% 1. Ribalta la maschera (rotazione di 180 gradi)
flipped_mask = rot90(se_mask, 2);

% 2. Calcola la nuova posizione dell'origine nella maschera ribaltata
flipped_origin = [h - origin(1) + 1, w - origin(2) + 1];

% 3. Ricrea la struct con i dati ribaltati
flipped_SE.mask = flipped_mask;
flipped_SE.origin = flipped_origin;

end