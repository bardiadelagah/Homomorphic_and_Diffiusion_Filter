clc; clear all; close all;

img = imread('noise.jpg');
img = im2double(img);
if length(size(img))==3
    img = rgb2gray(img);
end
Io=img;

N=8;
K=5;
method='pm2';
sigma=0.1;
Deltat=0.25;
homovar = 15;

diffusionFilterimg = diffusionFilter(img, N, K, method, sigma, Deltat);

[I, R] = homomorphicFilter(img,'gaussian',homovar);

diffusionFilterI = diffusionFilter(I, N, K, method, sigma, Deltat);
diffusionFilterR = diffusionFilter(R, N, K, method, sigma, Deltat);

% figure(1),
% subplot(2,2,1),imshow(I),title('I')
% subplot(2,2,2),imshow(R),title('R')
% subplot(2,2,3),imshow(diffusionFilterI),title('I')
% subplot(2,2,4),imshow(diffusionFilterR),title('R')

unsharpR = diffusionFilterR;
unsharpR = double(unsharpR);
mask = fspecial('unsharp', 0.8);
unsharpR = imfilter(unsharpR, mask, 'replicate');
R1 = unsharpR;

unsharpR = double(R1);
mask = fspecial('unsharp', 0.8);
unsharpR = imfilter(unsharpR, mask, 'replicate');
R2 = unsharpR;

gammaI = diffusionFilterI;
gamma=0.9;
gammaI = double(gammaI);
gammaI = imadjust(gammaI,[],[], gamma);

imwrite(diffusionFilterimg,'diffusionFilterimg1.jpg')
figure(1),
subplot(1,2,1),imshow(img),title('img')
subplot(1,2,2),imshow(diffusionFilterimg),title('diffusionFilterimg')
figure(2),
subplot(1,3,1),imshow(diffusionFilterI.*diffusionFilterR),title('diffusionFilterI.*diffusionFilterR')
subplot(1,3,2),imshow(diffusionFilterI.*R1),title('diffusionFilterI.*R1')
subplot(1,3,3),imshow(diffusionFilterI.*R2),title('diffusionFilterI.*R2')
figure(3),
subplot(1,3,1),imshow(gammaI.*diffusionFilterR),title('ammaI.*diffusionFilterR')
subplot(1,3,2),imshow(gammaI.*R1),title('gammaI.*R1')
subplot(1,3,3),imshow(gammaI.*R2),title('gammaI.*R2')


%======================
method='pm1';

diffusionFilterimg = diffusionFilter(img, N, K, method, sigma, Deltat);

[I, R] = homomorphicFilter(img,'gaussian',homovar);

diffusionFilterI = diffusionFilter(I, N, K, method, sigma, Deltat);
diffusionFilterR = diffusionFilter(R, N, K, method, sigma, Deltat);



unsharpR = diffusionFilterR;
unsharpR = double(unsharpR);
mask = fspecial('unsharp', 0.8);
unsharpR = imfilter(unsharpR, mask, 'replicate');
R1 = unsharpR;

unsharpR = double(R1);
mask = fspecial('unsharp', 0.8);
unsharpR = imfilter(unsharpR, mask, 'replicate');
R2 = unsharpR;

gammaI = diffusionFilterI;
gamma=0.9;
gammaI = double(gammaI);
gammaI = imadjust(gammaI,[],[], gamma);

imwrite(diffusionFilterimg,'diffusionFilterimg2.jpg')
figure(4),
subplot(1,2,1),imshow(img),title('img')
subplot(1,2,2),imshow(diffusionFilterimg),title('diffusionFilterimg')
figure(5),
subplot(1,3,1),imshow(diffusionFilterI.*diffusionFilterR),title('diffusionFilterI.*diffusionFilterR')
subplot(1,3,2),imshow(diffusionFilterI.*R1),title('diffusionFilterI.*R1')
subplot(1,3,3),imshow(diffusionFilterI.*R2),title('diffusionFilterI.*R2')
figure(6),
subplot(1,3,1),imshow(gammaI.*diffusionFilterR),title('ammaI.*diffusionFilterR')
subplot(1,3,2),imshow(gammaI.*R1),title('gammaI.*R1')
subplot(1,3,3),imshow(gammaI.*R2),title('gammaI.*R2')




