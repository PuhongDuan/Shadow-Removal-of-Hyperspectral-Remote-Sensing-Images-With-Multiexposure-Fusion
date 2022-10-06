% Copyright(c) 2022 Puhong Duan
% All Rights Reserved.
%
% ----------------------------------------------------------------------
% Permission to use, copy, or modify this software and its documentation
% for educational and research purposes only and without fee is here
% granted, provided that this copyright notice and the original authors'
% names appear on all copies and supporting documentation. This program
% shall not be used, rewritten, or adapted as the basis of a commercial
% software or hardware product without first obtaining permission of the
% authors. The authors make no representations about the suitability of
% this software for any purpose. It is provided "as is" without express
% or implied warranty.
%----------------------------------------------------------------------
%
% This is a shadow removal method for hyperspectral remote sensing images 
% which achieved by multi-exposure fusion

% if you use this code, Please cite the following paper:
%
%  P. Duan et al.,"Shadow Removal of Hyperspectral Remote Sensing Images With Multiexposure Fusion"
% IEEE Transactions on Geoscience and Remote Sensing, 2022.
addpath(genpath('./functions'));
%%
clear;clc;close all;
st=cputime;
load Houston_Dataset.mat

shadow = get_shadow(Houston);
ratio = get_ratio(Houston, shadow);

re_img = Houston; 
[r,c,x] = size(re_img);
coff=[0.5;1;1.5];
img2d=reshape(double(re_img),[r*c x]);
fimg{1}=double(re_img);
for i=1:length(coff)
    k=ratio.*coff(i);
    fimg2d=img2d.*k;
    temp=im2uint8(reshape(fimg2d,[r c x]));
    fimg{i+1}=double(temp)./255;
%     figure;imshow(fimg{i+1}(:,:,[59 40 23]));  
end
image_new = exposure_fusion4(fimg,[0 0 1]);
% figure;imshow(image_new(:,:,[59 40 23])*4);

shadow = 1 - shadow;
W = fspecial('gaussian',80,5);
shadow = imfilter(double(shadow), W, 'Symmetric');
% figure;imshow(shadow);
for i = 1:x
    image_new(:,:,i) = re_img(:,:,i) .* (1 - shadow) + image_new(:,:,i) .* shadow;
end
figure;
subplot(211); imshow(re_img(:,:,[59 40 23]) * 4);
subplot(212); imshow(image_new(:,:,[59 40 23])* 4);
et=cputime - st;
