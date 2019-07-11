clc;clear;close all;warning off;
%Example of SACD reconstruction
%-------------------------------------------------------------------------------------
%   Copyright  2018 Weisong Zhao et al, "Temporal resolution enhancement in
%   super-resolution imaging with auto-correlation two-step deconvolution
%   ," Opt. Express... 
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
load HDT.mat
image=SACD_recon(HDT(:,:,1:256),1.3,100*10^-9,488*10^-9,60);
imshow(image,[0.01,0.15],'Colormap',hot,'border','tight','initialmagnification','fit')
set(gcf,'Position',[0,0,size(image,1),size(image,2)])
