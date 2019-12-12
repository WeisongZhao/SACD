function image=Fourier_interpolation (image0,N1,N2)
%-----------------------------------------------
%Source code for generating fourier interpolation
%image0    single image waiting for inpolation
%N1           X  magnification times
%N2           Y  magnification times
%------------------------------------------------
%Output:
% image    image after fourier interpolation

%-------------------------------------------------------------------------------------
%   Copyright  2018 Weisong Zhao et al, "Faster super-resolution imaging
%   with autocorrelation two-step deconvolution ,"
%
%    This program is free software: you can redistribute it and/or modify
%    it under the terms of the GNU General Public License as published by
%    the Free Software Foundation, either version 3 of the License, or
%    (at your option) any later version.
%
%    This program is distributed in the hope that it will be useful,
%    but WITHOUT ANY WARRANTY; without even the implied warranty of
%    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%    GNU General Public License for more details.
%
%    You should have received a copy of the GNU General Public License
%    along with this program.  If not, see <http://www.gnu.org/licenses/>.
%-------------------------------------------------------------------------------------
%%
imagehuge=[image0,image0;image0,image0];
image0fft=fftshift(fft2(imagehuge));
[a,b]=size(image0fft);
imagebig=zeros(a+2*N1,b+2*N2);
imagebig(1+N1:end-N1,1+N2:end-N2)=image0fft;
imagebig=ifftshift(imagebig);
imagehuge0=ifft2(imagebig);
[c,d]=size(imagehuge0);
image=imagehuge0(1:c/2,1:d/2);
image=abs(image);
image=image/max(max(image));
