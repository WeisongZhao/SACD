function result=Accelaration_DeconvLucy(data,psf,iteration,method)
%-----------------------------------------------
%Inputs:
% data      single diffraction limit image
% psf        PSF
%iteration Maximum deconvolution iterations {example:20}
%method accelarate method{'NoAcce'(normal),'Acce1','Acce2','Acce3'}
%------------------------------------------------
%Output:
% result     Lucy-Richardson deconvolution result
%------------------------------------------------
% reference:
% [1].D. S. C. Biggs and M. Andrews, "Acceleration of iterative image restoration
% algorithms," Appl. Opt. 36(8), 1766¨C1775 (1997).

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
psf= psf./sum(sum(psf));
psf0=psf;
B=floor(max(size(data,1),size(data,2))/4);
data=padarray(data, [B,B] , 'replicate');
% move the PSF so that the maximum is at pixel 1 in the corner
psfm=psf;
psf = zeros(size(data,1),size(data,2));
psf(1 : size(psfm,1), 1 : size(psfm,2)) = psfm;
[~,idx] = max(psf(:));
[x,y,~] = ind2sub(size(psf), idx);
psf = circshift(psf, -[x,y,1] + 1);
otf = fftn(psf);
fprintf('Start deconvolution\n')
% Richardson Lucy update rule
rliter = @(estimate, data, otf)fftn(data./ max(ifftn(otf .* fftn(estimate)), 1e-6));
switch method
    case'NoAcce'
        estimate=data;
        estimate=max(estimate,0.001);
        for iter = 1:iteration
            if mod(iter,10)==0
                fprintf('-----------------------iteration %d -----------------------\n',iter)
            end
            estimate= estimate.*ifftn(conj(otf).*rliter(estimate,data,otf));
            estimate=max(estimate,1e-5);
            %             estimate=estimate./max(max(estimate));
        end
        result=estimate(B:end-B, B:end-B)./max(max(estimate(B:end-B, B:end-B)));
    case 'Acce1'
        estimate=data;
        estimate=max(estimate,0.001);
        k=2;
        for iter = 1:iteration
            if mod(iter,10)==0
                fprintf('-----------------------iteration %d -----------------------\n',iter)
            end
            estimate= estimate.*(ifftn(conj(otf).*rliter(estimate,data,otf))).^k;
            %         estimate=estimate./max(max(estimate));
            estimate=max(estimate,1e-5);
        end
        result=estimate(B:end-B, B:end-B)./max(max(estimate(B:end-B, B:end-B)));
    case 'Acce2'
        estimate=data;
        estimate=max(estimate,0.001);
        delta=2;
        for iter = 1:iteration
            if mod(iter,10)==0
                fprintf('-----------------------iteration %d -----------------------\n',iter)
            end
            estimatek=estimate;
            estimate= estimate.*ifftn(conj(otf).*rliter(estimate,data,otf));
            between_k_and_k1=estimate-estimatek;
            estimate=estimate+delta*between_k_and_k1;
            estimate=max(estimate,0.00001);
            estimate=estimate./max(max(estimate));
        end
        result=estimate(B:end-B, B:end-B)./max(max(estimate(B:end-B, B:end-B)));
    case 'Acce3'
        yk=max(data,0.001);
        xk1_stack(:,:,1)=data;
        xk1_stack(:,:,2)=max(yk.*ifftn(conj(otf).*rliter(yk,data,otf)),0);
        alpha=0;
        gk_stack(:,:,1)=zeros(size(data));
        gk_stack(:,:,2)=zeros(size(data));
        for iter = 3:iteration
            if mod(iter,10)==0
                fprintf('iteration %d\n',iter)
            end
            if iter>2
                alpha=sum(sum(gk_stack(:,:,iter-1).*gk_stack(:,:,iter-2)))/(sum(sum(gk_stack(:,:,iter-2).*gk_stack(:,:,iter-2)))+eps);
                alpha=max(min(alpha,1),0);
            end
            yk=max(xk1_stack(:,:,iter-1)+alpha*(xk1_stack(:,:,iter-1)-xk1_stack(:,:,iter-2)),0);
            xk1_stack(:,:,iter)= max(yk.*real(ifftn(conj(otf).*rliter(yk,data,otf)))./real(ifftn(fftn(ones(size(data))).*otf)),0);
            gk_stack(:,:,iter)=max(xk1_stack(:,:,iter)-yk,0);
            %             yk=yk./max(max(yk));
        end
        result=yk(B:end-B, B:end-B)./max(max(yk(B:end-B, B:end-B)));
end