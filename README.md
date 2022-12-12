## SACD(**S**uper-resolution method based on **A**uto-**C**orrelation two-step **D**econvolution)

## Attention
This is an archived repository. The updated version can be found in [SACDm](https://github.com/WeisongZhao/SACDm) or [SACDj](https://github.com/WeisongZhao/SACDj)

### Introduction
>This profile includding source code of the work: " **Faster super-resolution imaging with autocorrelation two-step deconvolution** ".<br />
>This program is free software: you can redistribute it and/or modify it under the terms of the **GNU** General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version. This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details.<br />
You are free to use this software package to analyse your fluctuation and all density of SMLM data, or generate your own algorithm. Please site the paper: coming soon...

### [[Project]](https://weisongzhao.github.io/SACD/)|[[Arxiv]](https://arxiv.org/abs/1809.07410)
### Denpendency
* >Matlab 7.0

### 1.Fluctuation data result 
<table >
  
  <div align=center><center><img src="./images/1.jpg" height="580"></center>
  
</table>

#### Image description
`SACD result of fluctuation images and comparison between SACD and SRRF using live-cell imaging data.`<br />
```python
(a) Mean wide-field image,
(b) SRRF reconstructed image with 200 frames, 
(c) SRRF reconstructed image with 16 frames SACD recons-tructed image, 
(d) SACD reconstructed image,
(e) Right: MPAC and error map between MPAC and AC image; left: SACD reconstructed image without first and second deconvolution step. (f) Normalized line profiles taken from the regions between the yellow arrowheads for corresponding images in (a), (b) and (d) showing separated features. 
Scale bar 1.5 μm. AC: auto-correlation.
```
<br />

### 2.High density SMLM data result 
<table >
  
  <div align=center><center><img src="./images/2.jpg" height="580"></center>
  
</table>

#### Image description
`SACD result of high density SMLM images and comparison with the other super-resolution methods. `
```python
(a)-(b) The meaned wide-field image and the reconstructed images: 256 and 16 frames. 
(c) The magnified result of white boxed region. 
(d) Profiles of the projection through the dotted lines in (a). 
Scale bar (a) 2 μm; (c) 500 nm.
```
<br />

### Reference
> [1].RHenriques-Lab, "NanoJ-SRRF, https://bitbucket.org/rhenriqueslab/nanoj-srrf/downloads/,".<br />
> [2].B. I. Group, "Benchmarking of Single-Molecule Localization Microscopy Software (EPFL, Lausanne, 2015). http://bigwww.epfl.ch/smlm/,".<br />
> [3].M. Ovesný, P. Křížek, J. Borkovec, Z. Švindrych, and G. M. Hagen, "ThunderSTORM: A comprehensive ImageJ plug-in for PALM and STORM data analysis and super-resolution imaging," Bioinformatics 30(16), 2389–2390 (2014).<br />
> [4].M. Leutenegger, "Balanced SOFI toolbox, (EPFL). http://documents.epfl.ch/users/l/le/leuteneg/www/BalancedSOFI/index.html,".<br />
> [5].I. Yahiatene, S. Hennig, M. Müller, and T. Huser, "Entropy-based super-resolution imaging (ESI): from disorder to fine detail," ACS Photonics 2(8), 1049–1056 (2015).<br />
> [6].D. S. C. Biggs and M. Andrews, "Acceleration of iterative image restoration algorithms," Appl. Opt. 36(8), 1766–1775 (1997).<br />
> [7].T. Dertinger, R. Colyer, G. Iyer, S. Weiss, and J. Enderlein, "Fast, background-free, 3D super-resolution optical fluctuation imaging (SOFI)," Proc. Natl. Acad. Sci. 106(52), 22287–22292 (2009).<br />


