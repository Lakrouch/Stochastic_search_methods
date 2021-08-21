clear all;
close all;
N= 1000;

xs = -4:(8/N):4;
[A,B]=meshgrid(xs,xs);
F = 20+(A.^2-10*cos(A.*2*pi))+(B.^2-10*cos(B.*2*pi));
surfc(xs, xs, F);

X = -4 +(4+4)*rand(N, 1);
Y = -4 +(4+4)*rand(N, 1);
F = 20+(X.^2-10*cos(X.*2*pi))+(Y.^2-10*cos(Y.*2*pi));
Arr = [X,Y];
GLmin = Arr(find(F==min(F)),:);

Tn =  50;
Tk = 0.001;
v = 0.99;
l = 0;
Xn = [(-4 +(4+4)*rand()),(-4 +(4+4)*rand())];
Xk = Xn;
e = true;
while e==true
    z=2;
    l = l+1;
    while z>1 || z<0
        z=normrnd(0,1);
    end;
    Xk_s = [Xk(1)+z*Tn*((1+l/Tn)^(2*rand()-1)-1),
                Xk(2)+z*Tn*((1+l/Tn)^(2*rand()-1)-1)];
    while abs(Xk_s(1))>=4 || abs(Xk_s(2))>=4
        while z>1 || z<0
            z=normrnd(0,1);
        end;
        Xk_s = [Xk(1)+z*Tn*((1+l/Tn)^(2*rand()-1)-1),
                Xk(2)+z*Tn*((1+l/Tn)^(2*rand()-1)-1)];
    end;
    F = 20+(Xk(1)^2-10*cos(Xk(1)*2*pi))+(Xk(2)^2-10*cos(Xk(2)*2*pi));
    Fk = 20+(Xk_s(1)^2-10*cos(Xk_s(1)*2*pi))+(Xk_s(2)^2-10*cos(Xk_s(2)*2*pi));
    dE = Fk - F;
    if dE<0
        Xk=Xk_s;
        if Tn<Tk
            break;
        end;
    else
        P = exp(-dE/Tn);
        if rand()<P
            Xk=Xk_s;
        else
            Tn = v*Tn;
        end;
    end;
end;

