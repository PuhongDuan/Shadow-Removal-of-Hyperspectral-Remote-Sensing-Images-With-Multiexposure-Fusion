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

% Contruction of Gaussian pyramid
% 高斯金字塔的构造
% Arguments:
%   image 'I'
%   'nlev', number of levels in the pyramid (optional)金字塔中的层数
%
% tom.mertens@gmail.com, August 2007
%

function pyr = gaussian_pyramid(I,nlev)

r = size(I,1);
c = size(I,2);

if ~exist('nlev')
    %compute the highest possible pyramid计算可能的最高金字塔
    nlev = floor(log(min(r,c)) / log(2));%向下取整数 8
end

% start by copying the image to the finest level首先将图像复制到最好的水平
pyr = cell(nlev,1);
pyr{1} = I;

% recursively downsample the image递归地向下采样图像
filter = pyramid_filter;
for l = 2:nlev
    I = downsample(I,filter);
    pyr{l} = I;
end