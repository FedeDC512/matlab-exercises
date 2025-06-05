function tmp=convoluzione_prof(img,k)
[h,w]=size(img);
tmp=zeros(h,w,'single');

% 7 è il bordo dato dalla dimensione del kernel diviso 2, arrotondato per difetto
for j=1+7:h-7
    for i=1+7:w-7
        t=0;
        for x=-7:7
            for y=-7:7
                t=t+img(j-y,i-x)*k(y+1+7,x+1+7);
            end
        end
        tmp(j,i)=t;
    end
end