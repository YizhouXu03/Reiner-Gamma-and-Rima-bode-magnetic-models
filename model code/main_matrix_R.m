function[]=main_matrix_R()
clear;clc;
load s1.mat;
Jmin=295;Jmax=310;Wmin=0;Wmax=15;
fpath1='D:\';
dw=0.3;dh=-2;
b=[s1(:,4);s1(:,5);s1(:,6)];
save([fpath1,'model\matrix_R\b.mat'],'b');
[x0 y0 z0]=dipole_model(Jmin,Jmax,Wmin,Wmax,dw);
D=[x0 y0 z0];
a1=length(D(:,1))
save([fpath1,'model\matrix_R\dipole_location.mat'],'D');
D=[];
x=s1(:,1);
y=s1(:,2);
z=s1(:,3);
R=sqrt(x.^2+y.^2+z.^2);
m=length(x)
n=length(x0)
x0=x0';y0=y0';z0=z0';
XX=bsxfun(@minus,x,x0);
YY=bsxfun(@minus,y,y0);
ZZ=bsxfun(@minus,z,z0);
r=sqrt(XX.^2+YY.^2+ZZ.^2);
r3=1./(r.^3);r5=1./(r.^5);
for kk=1:1:3
    switch kk
        case 1
            Gz=300.*XX.*ZZ.*r5;
            Gy=300.*XX.*YY.*r5;
            Gx=-100.*r3+300.*XX.*XX.*r5;
            fpath2=[fpath1,'model\matrix_R\x\'];
        case 2
            Gz=300.*YY.*ZZ.*r5;
            Gy=-100.*r3+300.*YY.*YY.*r5;
            Gx=300.*XX.*YY.*r5;
            fpath2=[fpath1,'model\matrix_R\y\'];
        case 3
            Gz=-100.*r3+300.*ZZ.*ZZ.*r5;
            Gy=300.*YY.*ZZ.*r5;
            Gx=300.*XX.*ZZ.*r5;
            fpath2=[fpath1,'model\matrix_R\z\'];
    end
    save([fpath2,'Gz'],'Gz');
    save([fpath2,'Gy'],'Gy');
    save([fpath2,'Gx'],'Gx');
    Gz=[];
    Gy=[];
    Gx=[];
end    