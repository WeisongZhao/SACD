function Ipsf=Generate_PSF(pixel,lamda,NA,n,z)
%-----------------------------------------------
%Source code for generating PSF
%pixel     pixel size {example:65*10^-9}
%lamda   wavelength {example:532*10^-9}
%NA        NA {example:1.49}
%n          number of psf {example:64}
%z          defocus length {example:1*10^-6}
%------------------------------------------------
%Output:
% Ipsf    PSF

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
if nargin < 4 || isempty(n)
    n=32;
end
if nargin < 5 || isempty(z)
    z=0;
end
sin2=((1-(1-NA^2))/2);
u=8*pi*z*sin2/lamda;
h=@(r,p) 2*exp((1i*u*(p.^2))/2).*besselj(0,2*pi*r*NA/lamda.*p);
x=-n*pixel:pixel:n*pixel;
[X,Y]=meshgrid(x,x);
[~,s1]=cart2pol(X,Y);
idx=s1<=1;
IP=zeros(size(X));
k=1;
for f=1:1:size(s1)
    for j=1:1:size(s1)
        if idx(f,j)==0
            IP(f,j)=0;
        else
            o=s1(idx);
            r=o(k);
            k=k+1;
            II=@(p)h(r,p);
            IP(f,j)=integral(II,0,1);
        end
    end
end
Ipsf=abs(IP.^2);
Ipsf=Ipsf./sum(sum( Ipsf));