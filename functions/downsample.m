%{
Copyright (c) 2015, Tom Mertens
All rights reserved.

Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:

* Redistributions of source code must retain the above copyright notice, this
  list of conditions and the following disclaimer.

* Redistributions in binary form must reproduce the above copyright notice,
  this list of conditions and the following disclaimer in the documentation
  and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
%}

% Downsampling procedure.
%
% Arguments:
%   grayscale I image
%   downsampling filter 'filter', should be a 1D separable filter.
%   'border_mode' should be 'circular', 'symmetric', or 'replicate'. See 'imfilter'.
%
% If image width W is odd, then the resulting image will have width (W-1)/2+1,
% Same for height.
%将采样过程。

%参数:

%灰度图像

%下采样滤波器'filter'，应该是一个1D可分离滤波器。

% 'border_mode'应该是'circular'、'symmetric'或'replicate'。看到“imfilter”。

%如果图像宽度W是奇数，那么结果图像的宽度(W-1)/2+1，高度相同。
% tom.mertens@gmail.com, August 2007
%

function R = downsample(I, filter)

border_mode = 'replicate';

% low pass, convolve with separable filter低通，可分离滤波器卷积
R = imfilter(I,filter,border_mode);     %horizontal
R = imfilter(R,filter',border_mode);    %vertical

% decimate
r = size(I,1);
c = size(I,2);
R = R(1:2:r, 1:2:c, :);  