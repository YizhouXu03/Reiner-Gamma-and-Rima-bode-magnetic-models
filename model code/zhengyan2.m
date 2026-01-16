function[]=zhengyan2()
clear;clc;close all;
Jmin=295;Jmax=310;Wmin=0;Wmax=15;  
H=0;
dw=0.1;
fpath1='D:\';
fpath=[fpath1,'model\matrix_R\'];
load([fpath,'Xk_fixed'],'Xk_fixed');
load([fpath1,'model\matrix_R\dipole_location'],'D');
G1z=[];
for kk=1:1:3 
    h=H
    k=1;
    A=[];
    for i=Jmin:dw:Jmax
        for j=Wmin:dw:Wmax
            A(k,:)=[i,j,h];
            k=k+1;
        end
    end
    k
    C=weizhi(A);
    x=C(:,1);
    y=C(:,2);
    z=C(:,3);
    R=sqrt(x.^2+y.^2+z.^2);
    x0=D(:,1);
    y0=D(:,2);
    z0=D(:,3);
    m=length(x)
    n=length(x0)
    G1=zeros(m,n);
    x0=x0';y0=y0';z0=z0';
    XX=bsxfun(@minus,x,x0);
    YY=bsxfun(@minus,y,y0);
    ZZ=bsxfun(@minus,z,z0);
    r=sqrt(XX.^2+YY.^2+ZZ.^2);
    r3=1./(r.^3);r5=1./(r.^5);
    switch kk
        case 1
            Gz=300.*XX.*ZZ.*r5;
            Gy=300.*XX.*YY.*r5;
            Gx=-100.*r3+300.*XX.*XX.*r5;
            G1x=[Gx,Gy,Gz];
        case 2
            Gz=300.*YY.*ZZ.*r5;
            Gy=-100.*r3+300.*YY.*YY.*r5;
            Gx=300.*XX.*YY.*r5;
            G1y=[Gx,Gy,Gz];
        case 3
            Gz=-100.*r3+300.*ZZ.*ZZ.*r5;
            Gy=300.*YY.*ZZ.*r5;
            Gx=300.*XX.*ZZ.*r5;
            G1z=[Gx,Gy,Gz];
    end
   
end
bz=G1z*Xk_fixed;
bx=G1x*Xk_fixed;
by=G1y*Xk_fixed;
bpc_xyzrg=[A(:,1),A(:,2) ,bx,by,bz];
save([fpath,'bpc_xyzrg.mat'],'bpc_xyzrg');