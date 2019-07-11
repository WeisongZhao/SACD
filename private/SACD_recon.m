function result=SACD_recon(data,NA,pixel,lamda,iter,mag,squre,order)
%-----------------------------------------------
%Inputs:
%data      diffraction limit image sequence
%NA        NA {example:1.49}
%pixel     pixel size {example:65*10^-9}
%lamda    wavelength {example:532*10^-9}
%iter      Maximum deconvolution iterations {example:20}
%mag      magnification times  {example:8}
%squre    PSF^2 {example:2}
%order     Auto-correlation cumulant order  {example:2}

%------------------------------------------------
%Output:
% result     SACD reconstruct result

%-------------------------------------------------------------------------------------
%   Copyright  2018 Weisong Zhao et al, "Faster super-resolution imaging
%   with autocorrelation two-step deconvolution ," Opt. Express... 
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
if size(data,3)<2
    disp('Number of data frame is smaller than 2, SACD cannot generate')
end
if nargin < 2 || isempty(NA)
    disp('Parameter is not enough: NA')
end
if nargin < 3 || isempty(pixel)
    disp('Parameter is not enough: pixel size')
end
if nargin < 4 || isempty(lamda)
    disp('Parameter is not enough: wavelength')
end
if nargin < 5 || isempty(iter)
    iter=10;
end
if nargin < 6 || isempty(mag)
    mag=8;
end
if nargin < 7 || isempty(squre)
    squre=2;
end
if nargin < 8 || isempty(order)
    order=2;
end
%%
tic
siz=size(data,3);
fprintf('\nSACD reconstruct starting\n')
fprintf('-------------------------------\n')
fprintf('Start generate PSF\n')
if size(data,1)>128*2+1&&size(data,2)>128*2+1
    n=128;
else
    n=32;
end
psf=Generate_PSF(pixel/mag,lamda,NA,n);
fprintf('PSF done\n')
fprintf('Interpolation and deconvolution for each frame\n')
fprintf('-------------------------------------------------------\n')
for i=1:siz
    I0=Fourier_interpolation(data(:,:,i),(mag-1)*size(data,1),(mag-1)*size(data,2));
    I(:,:,i)=Accelaration_DeconvLucy(I0,psf,10,'Acce3');
    I(:,:,i)=abs(I(:,:,i));
    I(:,:,i)=I(:,:,i)./max(max(I(:,:,i)));
    fprintf('Frame %d(Total frames: %d): %d percent\n',i,siz,uint8(100*(i/siz)))
    fprintf('------------------------------------------\n')
end
fprintf('Deconvolution and fourier interpolation done\n')
fprintf('Generate cumulant\n\n')
imag=MPAC(I,round(log2(siz)),order);
fprintf('Cumulant done\n\n')
result=Accelaration_DeconvLucy(imag,psf.^squre,iter,'Acce3');
result=result./max(max(result));
ttime =toc;
fprintf(['SACD reconstruction finished, time cost : ' num2str(ttime) ' recs. \nThank you for your waiting!\n'])
