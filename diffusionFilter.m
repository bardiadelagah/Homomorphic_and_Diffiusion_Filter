function [output] = diffusionFilter(img, N, K, method, sigma, Deltat)
%DIFFUSIONFILTER Summary of this function goes here
%   Detailed explanation goes here

img = im2double(img);
if length(size(img))==3
    img = rgb2gray(img);
end


% N=8;
% K=5;
% method='pm2';
% sigma=0.1;
% Deltat=0.25;

[SY, SX]=size(img);
for i = 1:N
    if(sigma>0)
        Io=img;
        g4=fspecial('gaussian',3,sigma);
        img=imfilter(img,g4,'replicate');
    end
    dn=[img(1,:); img(1:SY-1,:)]-img;
    ds=[img(2:SY,:); img(SY,:)]-img;
    de=[img(:,2:SX) img(:,SX)]-img;
    dw=[img(:,1) img(:,1:SX-1)]-img;
    
    if (strcmp(method,'pm1'))
        rn=exp(-(abs(dn)/K).^2);
        rs=exp(-(abs(ds)/K).^2);
        re=exp(-(abs(de)/K).^2);
        rw=exp(-(abs(dw)/K).^2);
    %elseif (method=='pm2')
    elseif (strcmp(method,'pm2'))
        rn=1./(1+(abs(dn)/K).^2);
        rs=1./(1+(abs(ds)/K).^2);
        re=1./(1+(abs(de)/K).^2);
        rw=1./(1+(abs(dw)/K).^2);
    end
    if (sigma>0)
        dn=[Io(1,:); Io(1:SY-1,:)]-Io;
        ds=[Io(2:SY,:); Io(SY,:)]-Io;
        de=[Io(:,2:SX) Io(:,SX)]-Io;
        dw=[Io(:,1) Io(:,1:SX-1)]-Io;
        
        img = Io;
    end
    img = img + Deltat*(rn.*dn+rs.*ds+re.*de+rw.*dw);
end

output = img;
% figure(1),imshow(img)
        


end

