function [I, R] = homomorphicFilter(img, mode, var)
%WINNERFILTER Summary of this function goes here
%   Detailed explanation goes here

% if mode==''
%     mode='gaussian';
% end

mode = 'gaussian';
if length(size(img))==3
    img = rgb2gray(img);
end


img = im2double(img);

[m, n] = size(img);
%fourier transform
f = img+0.0001;
z = log(f);
z = fftshift(fft2(z));
%mask
v1 = m; v2 = n; %var = 15;
h = mat2gray(fspecial(mode,[v1, v2], var));

ref=z.*(1-h);
lum=z.*h;

reflectance = exp(ifft2(fftshift(ref)));
illumination = exp(ifft2(fftshift(lum)));

R = abs(reflectance);
I = abs(illumination);

% 
% figure,
% subplot(2,2,1),imshow(reflectance), title('reflectance')
% subplot(2,2,2),imshow(illumination), title('illumination')
% subplot(2,2,3),imshow(R), title('abs(reflectance)')
% subplot(2,2,4),imshow(I), title('abs(illumination)')
end







