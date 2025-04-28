barbara = rgb2gray(img);  
imshow(barbara);            

% Aggiungo rumore Sale e Pepe
p = randperm(262144, 2*26214);  % Estraggo a caso 2*26214 pixel dall'immagine (262144 = 512*512 pixel)

barbara(p(1:26214)) = 0;        % I primi 26214 pixel diventano neri (0)
barbara(p(26214+1:end)) = 255;  % Gli altri 26214 pixel diventano bianchi (255)

imshow(barbara);               

% Applico Filtro Mediano
tmp = medfilt2(barbara);        

imshow(tmp);                    

% 7. Immagine originale
figure;
imshow(barbara);

barbara2 = barbara;             % Creo una copia

% Indici dei pixel bianchi (255) e neri (0):
b = find(barbara == 255);       % Trovo dove l'immagine rumorosa è bianca
n = find(barbara == 0);         % Trovo dove è nera

% Correggo solo quei pixel con il valore filtrato
barbara2(b) = tmp(b);           
barbara2(n) = tmp(n);           

figure;
imshow(barbara2);

% Applico un Filtro Mediano più grande (11x11)
barbara2 = medfilt2(barbara, [11 11]); 

figure;
imshow(barbara2);

% Applico convoluzione con un filtro di media 11x11
barbara3 = conv2(single(barbara), fspecial('average', [11 11]), 'same');

figure;
imshow(barbara3);
