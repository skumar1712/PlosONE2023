clear 

load('xgrid.mat')
load('ygrid.mat')
global xloc yloc 

[xloc, yloc] = meshgrid(xcoor, ycoor) ;

% Construct a square grid
xsq = linspace(-1, 1, 101);
ysq = linspace(-1, 1, 101);
[xxs, yys] = meshgrid(xsq, ysq) ;
% Center of the square shaped domain
% xc0 = 0.15; yc0 = 0.08 ;
xc0 = 0.02; yc0 = 0.08 ;
xxs = 0.01*xxs + xc0 ;
yys = 0.01*yys + yc0 ;
% Choose indices correponding to a circle
index = sqrt((xxs-xc0).^2+(yys-yc0).^2)>0.01 ;
xxs(index) = 0 ;
yys(index) = 0 ; 
xxs = xxs(:) ;
xs = xxs(xxs~=0) ;
yys = yys(:) ;
ys = yys(yys~=0) ;

Xtraj_b = [xs ys] ;

% Xtraj_f = [xs ys] ;

for j = 90 : -1 : 10
% for j = 71
    
    if max(abs(xs))>1e2
        j
        break
        
    end
    load(['U_T' num2str(j) '.mat']);
    load(['V_T' num2str(j) '.mat']);
    expression1 = ['u' num2str(j) ]; 
    expression2 = ['v' num2str(j) ]; 
    
    umesh = eval(expression1) ; 
    vmesh = eval(expression2) ;

    [uxc,  uyc] = velocity(xs, ys, umesh, vmesh, 1); 
    h = 0.1 ;
    t_start = j ; 
    t_end =  j-1 ;
    [X,Y,T]= RungeKutta_b(t_start, t_end, h, xs, ys, umesh, vmesh) ;
    
    % Xtraj_f = [Xtraj_f X Y] ;
    Xtraj_b = [Xtraj_b X Y] ;
    xs = X ;
    ys = Y ;
end



function [ux,uy] = velocity(x,y, umesh, vmesh, iiT)

global xloc yloc 

ux = interp2(xloc, yloc, umesh', x, y, 'linear');
uy = interp2(xloc, yloc, vmesh', x, y, 'linear');

ux(isnan(ux)) = 0 ;
uy(isnan(uy)) = 0 ;

% ux(index) = nan ;
% uy(index) = nan ; 

end

function [x, y, T]= RungeKutta_b(t0, t1, h, x0, y0, umesh, vmesh)

t = t0;
delta_t = abs(t1 - t0);

[ux,  uy] = velocity(x0, y0, umesh, vmesh, 1); 

x = x0 - delta_t * h * ux;
y = y0 - delta_t * h * uy;
    
T=t-1;
end

function [x, y, T]= RungeKutta_f(t0, t1, h, x0, y0, umesh, vmesh)

t = t0;
delta_t = abs(t1 - t0);

[ux,  uy] = velocity(x0, y0, umesh, vmesh, 1); 

x = x0 + delta_t * h * ux;
y = y0 + delta_t * h * uy;
    
T=t+1;
end
