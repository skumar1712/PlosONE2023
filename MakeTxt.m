% The code reads a 2D velocity vector field data generated from OpenFOAM simulations 
% and converts it into a format needed for LCS_Calculation.m and saves it in
% .txt files for each sample time.


clear;
tic
 
% Units of variables in .mat
% lon, lat   : degree
% time       : day
% vLat, vLon : degree/day

load('NewESF01\Case2\NewESF01\VarCase2PlaneX0_t10.mat')

dx = 3e-3; ax=-0.22; bx=0.22; % YZ plane
% dx = 3e-3; ax=-0.15; bx=0.15; % XZ plane
nx = round((bx-ax)/dx);
x = linspace(ax, bx, nx+1) ; x = x(:) ;
dy = dx; ay = 0; by = 0.15;
ny = round((by-ay)/dy);
y = linspace(ay, by, ny+1) ; y = y(:) ;

% nx = 125; x = linspace(-0.2, 0.2, nx) ; x = x(:) ;
% ny = 50; y = linspace(0, 0.1676, ny) ; y = y(:) ;

% nx = 100 ; x = linspace(0, 0.1, nx) ; x = x(:) ;
% ny = 100 ; y = linspace(0, 0.1, ny) ; y = y(:) ;

tt = 0 : 0.1 : 10 ; tt = tt(:) ; 
[tq, xq, yq] = meshgrid(tt, x, y); 

u = griddata(time, X2all, X3all, U2all, tq, xq, yq) ; % YZ plane
v = griddata(time, X2all, X3all, U3all, tq, xq, yq) ; % YZ plane

% u = griddata(time, X1all, X3all, U1all, tq, xq, yq) ; % XZ plane
% v = griddata(time, X1all, X3all, U3all, tq, xq, yq) ; % XZ plane


u(isnan(u)) = 0 ;
v(isnan(v)) = 0 ;

u = permute(u,[2 1 3]) ;
u = permute(u,[1 3 2]) ;
% u = -u ; 
v = permute(v,[2 1 3]) ;
v = permute(v,[1 3 2]) ;
M = zeros((nx+1)*(ny+1), 4) ;

for ti = 1 : 100
    M = [] ;
    for j = 1 : nx
        M = [M; x(j)*ones(ny+1,1) y u(ti,:,j).' v(ti,:,j).'] ;    
    end
    M = M.' ; 
    fileID = fopen(['Vart' num2str(ti) '.txt'],'w');
    fprintf(fileID,'%6.4f %6.4f %6.4f %6.4f \n', M);
    fclose(fileID) ;
end


