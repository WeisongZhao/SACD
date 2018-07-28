function Result= MPAC(image,plane,n)
%-----------------------------------------------
%Source code for generating stacks of blinking frames
%Inputs:
% image     diffraction limit image sequence
% plane     multiplan number{example:4}
%n            Auto-correlation cumulant order  {example:2}
%------------------------------------------------
%Output:
% Result   MPAC reconstruct result
%reference:
%[1].T. Dertinger, R. Colyer, G. Iyer, S. Weiss, and J. Enderlein, "Fast,
% background-free, 3D super-resolution optical fluctuation imaging
% (SOFI)," Proc. Natl. Acad. Sci. 106(52), 22287¨C22292 (2009).

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
%%
if nargin < 2 || isempty(plane)
    plane=round(log2(size(image,3)));
end
if nargin < 3 || isempty(n)
    n=2;
end
[a,b,c]=size(image);
image0=reshape(image, a* b, c);
[aa,bb]=size(image0);
%%%%%%%%%%2^plane
image_xulie=zeros(aa,bb,plane);
image_xulie(:,:,1)=image0;
if plane~=1
    for image_z=2:1:plane
        for image_y=2:2:bb
            image_xulie(:,image_y/2,image_z)=image_xulie(:,image_y,image_z-1)+image_xulie(:,image_y-1,image_z-1);
        end
    end
end
Result0=zeros(a,b);
for i=1:plane %
    im=reshape(image_xulie(:,:,i), a,b,c);
%     im=im0(:,:,1:round(c/plane));
    switch n
        case 2
            cum = mean(im(:,:,1:end-1).*im(:,:,2:end),3);
        case 3
            cum = mean(im(:,:,1:end-2).*im(:,:,2:end-1).*im(:,:,3:end),3);
        case 4
            cum = -mean(im(:,:,1:end-3).*im(:,:,4:end),3).*mean(im(:,:,2:end-2).*im(:,:,3:end-1),3)-mean(im(:,:,1:end-3).*im(:,:,3:end-1),3).*mean(im(:,:,2:end-2).*im(:,:,4:end),3)-mean(im(:,:,1:end-3).*im(:,:,2:end-2),3).*mean(im(:,:,3:end-1).*im(:,:,4:end),3)+mean(im(:,:,1:end-3).*im(:,:,2:end-2).*im(:,:,3:end-1).*im(:,:,4:end),3);
        case 5
            cum = -mean(im(:,:,4:end-1).*im(:,:,5:end),3).*mean(im(:,:,1:end-4).*im(:,:,2:end-3).*im(:,:,3:end-2),3)-mean(im(:,:,3:end-2).*im(:,:,5:end),3).*mean(im(:,:,1:end-4).*im(:,:,2:end-3).*im(:,:,4:end-1),3)-mean(im(:,:,3:end-2).*im(:,:,4:end-1),3).*mean(im(:,:,1:end-4).*im(:,:,2:end-3).*im(:,:,5:end),3)-mean(im(:,:,2:end-3).*im(:,:,5:end),3).*mean(im(:,:,1:end-4).*im(:,:,3:end-2).*im(:,:,4:end-1),3)-mean(im(:,:,2:end-3).*im(:,:,4:end-1),3).*mean(im(:,:,1:end-4).*im(:,:,3:end-2).*im(:,:,5:end),3)-mean(im(:,:,2:end-3).*im(:,:,3:end-2),3).*mean(im(:,:,1:end-4).*im(:,:,4:end-1).*im(:,:,5:end),3)-mean(im(:,:,1:end-4).*im(:,:,5:end),3).*mean(im(:,:,2:end-3).*im(:,:,3:end-2).*im(:,:,4:end-1),3)-mean(im(:,:,1:end-4).*im(:,:,4:end-1),3).*mean(im(:,:,2:end-3).*im(:,:,3:end-2).*im(:,:,5:end),3)-mean(im(:,:,1:end-4).*im(:,:,3:end-2),3).*mean(im(:,:,2:end-3).*im(:,:,4:end-1).*im(:,:,5:end),3)-mean(im(:,:,1:end-4).*im(:,:,2:end-3),3).*mean(im(:,:,3:end-2).*im(:,:,4:end-1).*im(:,:,5:end),3)+mean(im(:,:,1:end-4).*im(:,:,2:end-3).*im(:,:,3:end-2).*im(:,:,4:end-1).*im(:,:,5:end),3);
        case 6
            cum = 2.*mean(im(:,:,1:end-5).*im(:,:,6:end),3).*mean(im(:,:,2:end-4).*im(:,:,5:end-1),3).*mean(im(:,:,3:end-3).*im(:,:,4:end-2),3)+2.*mean(im(:,:,1:end-5).*im(:,:,5:end-1),3).*mean(im(:,:,2:end-4).*im(:,:,6:end),3).*mean(im(:,:,3:end-3).*im(:,:,4:end-2),3)+2.*mean(im(:,:,1:end-5).*im(:,:,6:end),3).*mean(im(:,:,2:end-4).*im(:,:,4:end-2),3).*mean(im(:,:,3:end-3).*im(:,:,5:end-1),3)+2.*mean(im(:,:,1:end-5).*im(:,:,4:end-2),3).*mean(im(:,:,2:end-4).*im(:,:,6:end),3).*mean(im(:,:,3:end-3).*im(:,:,5:end-1),3)+2.*mean(im(:,:,1:end-5).*im(:,:,5:end-1),3).*mean(im(:,:,2:end-4).*im(:,:,4:end-2),3).*mean(im(:,:,3:end-3).*im(:,:,6:end),3)+2.*mean(im(:,:,1:end-5).*im(:,:,4:end-2),3).*mean(im(:,:,2:end-4).*im(:,:,5:end-1),3).*mean(im(:,:,3:end-3).*im(:,:,6:end),3)+2.*mean(im(:,:,1:end-5).*im(:,:,6:end),3).*mean(im(:,:,2:end-4).*im(:,:,3:end-3),3).*mean(im(:,:,4:end-2).*im(:,:,5:end-1),3)+2.*mean(im(:,:,1:end-5).*im(:,:,3:end-3),3).*mean(im(:,:,2:end-4).*im(:,:,6:end),3).*mean(im(:,:,4:end-2).*im(:,:,5:end-1),3)+2.*mean(im(:,:,1:end-5).*im(:,:,2:end-4),3).*mean(im(:,:,3:end-3).*im(:,:,6:end),3).*mean(im(:,:,4:end-2).*im(:,:,5:end-1),3)+2.*mean(im(:,:,1:end-5).*im(:,:,5:end-1),3).*mean(im(:,:,2:end-4).*im(:,:,3:end-3),3).*mean(im(:,:,4:end-2).*im(:,:,6:end),3)+2.*mean(im(:,:,1:end-5).*im(:,:,3:end-3),3).*mean(im(:,:,2:end-4).*im(:,:,5:end-1),3).*mean(im(:,:,4:end-2).*im(:,:,6:end),3)+2.*mean(im(:,:,1:end-5).*im(:,:,2:end-4),3).*mean(im(:,:,3:end-3).*im(:,:,5:end-1),3).*mean(im(:,:,4:end-2).*im(:,:,6:end),3)+2.*mean(im(:,:,1:end-5).*im(:,:,4:end-2),3).*mean(im(:,:,2:end-4).*im(:,:,3:end-3),3).*mean(im(:,:,5:end-1).*im(:,:,6:end),3)+2.*mean(im(:,:,1:end-5).*im(:,:,3:end-3),3).*mean(im(:,:,2:end-4).*im(:,:,4:end-2),3).*mean(im(:,:,5:end-1).*im(:,:,6:end),3)+2.*mean(im(:,:,1:end-5).*im(:,:,2:end-4),3).*mean(im(:,:,3:end-3).*im(:,:,4:end-2),3).*mean(im(:,:,5:end-1).*im(:,:,6:end),3)-mean(im(:,:,1:end-5).*im(:,:,5:end-1).*im(:,:,6:end),3).*mean(im(:,:,2:end-4).*im(:,:,3:end-3).*im(:,:,4:end-2),3)-mean(im(:,:,1:end-5).*im(:,:,4:end-2).*im(:,:,6:end),3).*mean(im(:,:,2:end-4).*im(:,:,3:end-3).*im(:,:,5:end-1),3)-mean(im(:,:,1:end-5).*im(:,:,4:end-2).*im(:,:,5:end-1),3).*mean(im(:,:,2:end-4).*im(:,:,3:end-3).*im(:,:,6:end),3)-mean(im(:,:,1:end-5).*im(:,:,3:end-3).*im(:,:,6:end),3).*mean(im(:,:,2:end-4).*im(:,:,4:end-2).*im(:,:,5:end-1),3)-mean(im(:,:,1:end-5).*im(:,:,3:end-3).*im(:,:,5:end-1),3).*mean(im(:,:,2:end-4).*im(:,:,4:end-2).*im(:,:,6:end),3)-mean(im(:,:,1:end-5).*im(:,:,3:end-3).*im(:,:,4:end-2),3).*mean(im(:,:,2:end-4).*im(:,:,5:end-1).*im(:,:,6:end),3)-mean(im(:,:,1:end-5).*im(:,:,2:end-4).*im(:,:,6:end),3).*mean(im(:,:,3:end-3).*im(:,:,4:end-2).*im(:,:,5:end-1),3)-mean(im(:,:,1:end-5).*im(:,:,2:end-4).*im(:,:,5:end-1),3).*mean(im(:,:,3:end-3).*im(:,:,4:end-2).*im(:,:,6:end),3)-mean(im(:,:,1:end-5).*im(:,:,2:end-4).*im(:,:,4:end-2),3).*mean(im(:,:,3:end-3).*im(:,:,5:end-1).*im(:,:,6:end),3)-mean(im(:,:,1:end-5).*im(:,:,2:end-4).*im(:,:,3:end-3),3).*mean(im(:,:,4:end-2).*im(:,:,5:end-1).*im(:,:,6:end),3)-mean(im(:,:,5:end-1).*im(:,:,6:end),3).*mean(im(:,:,1:end-5).*im(:,:,2:end-4).*im(:,:,3:end-3).*im(:,:,4:end-2),3)-mean(im(:,:,4:end-2).*im(:,:,6:end),3).*mean(im(:,:,1:end-5).*im(:,:,2:end-4).*im(:,:,3:end-3).*im(:,:,5:end-1),3)-mean(im(:,:,4:end-2).*im(:,:,5:end-1),3).*mean(im(:,:,1:end-5).*im(:,:,2:end-4).*im(:,:,3:end-3).*im(:,:,6:end),3)-mean(im(:,:,3:end-3).*im(:,:,6:end),3).*mean(im(:,:,1:end-5).*im(:,:,2:end-4).*im(:,:,4:end-2).*im(:,:,5:end-1),3)-mean(im(:,:,3:end-3).*im(:,:,5:end-1),3).*mean(im(:,:,1:end-5).*im(:,:,2:end-4).*im(:,:,4:end-2).*im(:,:,6:end),3)-mean(im(:,:,3:end-3).*im(:,:,4:end-2),3).*mean(im(:,:,1:end-5).*im(:,:,2:end-4).*im(:,:,5:end-1).*im(:,:,6:end),3)-mean(im(:,:,2:end-4).*im(:,:,6:end),3).*mean(im(:,:,1:end-5).*im(:,:,3:end-3).*im(:,:,4:end-2).*im(:,:,5:end-1),3)-mean(im(:,:,2:end-4).*im(:,:,5:end-1),3).*mean(im(:,:,1:end-5).*im(:,:,3:end-3).*im(:,:,4:end-2).*im(:,:,6:end),3)-mean(im(:,:,2:end-4).*im(:,:,4:end-2),3).*mean(im(:,:,1:end-5).*im(:,:,3:end-3).*im(:,:,5:end-1).*im(:,:,6:end),3)-mean(im(:,:,2:end-4).*im(:,:,3:end-3),3).*mean(im(:,:,1:end-5).*im(:,:,4:end-2).*im(:,:,5:end-1).*im(:,:,6:end),3)-mean(im(:,:,1:end-5).*im(:,:,6:end),3).*mean(im(:,:,2:end-4).*im(:,:,3:end-3).*im(:,:,4:end-2).*im(:,:,5:end-1),3)-mean(im(:,:,1:end-5).*im(:,:,5:end-1),3).*mean(im(:,:,2:end-4).*im(:,:,3:end-3).*im(:,:,4:end-2).*im(:,:,6:end),3)-mean(im(:,:,1:end-5).*im(:,:,4:end-2),3).*mean(im(:,:,2:end-4).*im(:,:,3:end-3).*im(:,:,5:end-1).*im(:,:,6:end),3)-mean(im(:,:,1:end-5).*im(:,:,3:end-3),3).*mean(im(:,:,2:end-4).*im(:,:,4:end-2).*im(:,:,5:end-1).*im(:,:,6:end),3)-mean(im(:,:,1:end-5).*im(:,:,2:end-4),3).*mean(im(:,:,3:end-3).*im(:,:,4:end-2).*im(:,:,5:end-1).*im(:,:,6:end),3)+mean(im(:,:,1:end-5).*im(:,:,2:end-4).*im(:,:,3:end-3).*im(:,:,4:end-2).*im(:,:,5:end-1).*im(:,:,6:end),3);
    end
    Result0=cum+Result0;
end
% Result=Result0(1:a-2,2:b-1)+Result0(2:a-1,1:b-2)+Result0(2:a-1,2:b-1)+Result0(1:a-2,1:b-2);
Result=abs(Result0);
Result=Result./max(max(Result));