%% Question 2

I = imread('Mickey_in_jail.tif');



I_F = fft2(double(I)); 
I_F_shift = fftshift(I_F);

for j = 1112:1128
    
    for n = 14:1650
        I_F_shift(j,n) = 255; 

    end
end

for j = 1706:1954
    
    y=uint8(-0.4*j+1861);
    I_F_shift(j,y) = 0; 
    I_F_shift(j+1,y) = 0; 
            I_F_shift(j,y+1) = 0; 

end
for j = 1706:1954
 
    y=uint8(0.4*j+1861);
    I_F_shift(j,y) = 0; 
    I_F_shift(j+1,y) = 0; 
            I_F_shift(j,y+1) = 0; 

end


I_NEW = real(ifft2(ifftshift(I_F_shift)));
figure,subplot(1,2,1),imshow(I),subplot(1,2,2),imshow(I_NEW,[]);
%% Question 3
% do correlation to have the same output as the last homework
I = imread('hw4_im5.tif');
    I_Filter = double(imread('hw4_mask5.tif'));
    [r,c]=size(I);
    p=padded(size(I));
    [r1,c1]=size(I_Filter);
    Izero = padarray(I, [(p(1)-r), (p(2)-c)], 0, 'post');
    
    I = im2double(Izero);
    I_F = fftshift(fft2(I));

    IFzero = padarray(I_Filter, [(p(1)-r1), (p(2)-c1)], 0, 'post');
    
    I_F_F = fftshift(fft2(im2double(IFzero)));
    I_F_F_C = conj(I_F_F);

    figure,subplot(3,2,1),imshow(I,[]),title('Original Image'),...
    subplot(3,2,2),imshow(IFzero),title('Mask Filter');
    R = (I_F.*I_F_F_C);
    
    I_New=ifft2(ifftshift(R));
    I_NEW=real(I_New);
    I_New=my_fscs(I_NEW);

    R=mat2gray(real(I_New));
    Imb=double(im2bw(R,0.8));

    subplot(3,2,3),imshow(R),title('Correlation Output');
    subplot(3,2,4),imshow(Imb),title('Correlation Threshold Output');
    

    I2=imcrop(I,[78,58,856,566]);
    I_F = imfuse(I2,Imb);
    subplot(3,2,5),imshow(I_F),...
    title('Overlay of Original & Correlation Threshold Output'); 
    I3=imcrop(I_F,[0,0,812,542]);
    subplot(3,2,6),imshow(I3),...
    title('Cropped Overlay of Original & Correlation Threshold Output'); 