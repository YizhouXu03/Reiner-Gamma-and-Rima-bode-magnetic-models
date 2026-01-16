function[x0,y0,z0]=dipole_model(Jmin,Jmax,Wmin,Wmax,dw)
A1=[];
jian=0.3;
h=-10;
for j=(Jmin-jian):dw:(Jmax+jian-dw)
    for w=(Wmin-jian):dw:(Wmax+jian-dw)
        J=j+dw/2;W=w+dw/2;
        A1=[A1;J,W,h;];
    end
end
A=A1;
J=A(:,1);
W=A(:,2);
H=A(:,3);
n=length(H);
D=ones(n,1);
D=1737*D;
r=D+H;
x0=1000*r.*cos(2*pi*W/360).*cos(2*pi*J/360);
y0=1000*r.*cos(2*pi*W/360).*sin(2*pi*J/360);
z0=1000*r.*sin(2*pi*W/360);       