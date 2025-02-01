% The code plots forward and backward FTLE field by reading it from .txt files
clear 

A = dlmread('C:\MATLAB\LCS-Tool-master\LMK23\FinalComputations\NewESF01\Case2\NewESF01\bFTLElen30nx401ny131t3.txt', '', 3) ;  

B = A ;

Nx = 2*200+1;
Ny = 130+1;

% Arrangning the data in Nx x Ny shape
for i = 1 : Nx
    x(:, i) = A((i-1)*Ny+1:i*Ny, 1);
    y(:, i) = A((i-1)*Ny+1:i*Ny, 2);
    f(:, i) = A((i-1)*Ny+1:i*Ny, 3);
    g(:, i) = B((i-1)*Ny+1:i*Ny, 3);
end

figure; contourf(x, y, f); colorbar
title('Forward FTLE field')
% figure; contourf(x, y, g); colorbar
title('Backward FTLE field')

% Normalizing and considering only FTLE values >=0.75

thres = 0.25 ;          % The threshold value

A1 = A ; 
rangeA = max(A(:,3)) - min(A(:,3)) ; 
A1(:,3)  = (A(:,3) - min(A(:,3))) / rangeA ;
dumA = A1(:,3) ;
dumA(dumA<thres)=0; 
A1(:,3) = dumA ; 

B1 = B; 
rangeB = max(B(:,3)) - min(B(:,3)) ; 
B1(:,3) = (B(:,3) - min(B(:,3))) / rangeB ;

dumB = B1(:,3) ;
dumB(dumB<thres)=0; 
B1(:,3) = dumB ; 

% Filtered data in Nx x Ny shape
for i = 1 : Nx
    f1(:, i) = A1((i-1)*Ny+1:i*Ny, 3);
    g1(:, i) = B1((i-1)*Ny+1:i*Ny, 3);
end

return;
figure; contourf(x, y, f1); colormap('jet'), colorbar, 
title('Forward (filtered) FTLE field')
figure; contourf(x, y, g1); colormap('jet'), colorbar
title('Backward (filtered) FTLE field')

