clc;
clear;

% modules = input("Give a string ", 's');
modules='PP';

% parameters = input("Give parameters in square brackets (P = R C) ");
parameters=[ 2, -8, 2, -9 ];
lb = [];
ub = [];

[result, lb, ub]=str_to_vector(modules, parameters, lb, ub);


% save('wyniki_symulacji_PP', 'result');

function [ vector_of_parameter, lb, ub ] = str_to_vector(modules, parameters, lb, ub)


number_of_modules = length(modules);
actual_index = 1;
i = 0:0.1:6;
i = i';
w = 10.^i;

sumOfZZ = zeros([length(i) 1]);

for sign = 1:number_of_modules
    
    switch modules(sign)
        case 'R'
            r = 10^(parameters(actual_index));
            ZZ = getZfromR(r);
            actual_index = actual_index + 1;
            
            lb = [lb, 2];
            ub = [ub, 7];
        case 'C'
            c = 10^(parameters(actual_index));
            ZZ = getZfromC(c, w);
            actual_index = actual_index + 1;
            
            lb = [lb, -11];
            ub = [ub, -7];
        case 'L'
            l = 10^(parameters(actual_index));
            ZZ = getZfromL(l, w);
            actual_index = actual_index + 1;
            
            lb = [lb, -11];
            ub = [ub, -7];
        case 'P'
            r = 10^(parameters(actual_index));
            c = 10^(parameters(actual_index + 1));
            ZZ = getZfromP(r, c, w);
            actual_index = actual_index + 2;
            
            lb = [lb 2, -11];
            ub = [ub 7, -7];
        case 'W'
            z0 = 10^(parameters(actual_index));
            ZZ = getZfromW(z0, w);
            actual_index = actual_index + 1;
            
        case 'S'
            A = 10^(parameters(actual_index));
            Y0 = 10^(parameters(actual_index +1));
            ZZ = getZfromS(A, Y0, w);
            actual_index = actual_index + 2;
            
            lb = [lb, -11];
            ub = [ub, -2];
    end
    
    sumOfZZ = sumOfZZ + ZZ;

end

% sumOfZZ;

vector_of_parameter = sumOfZZ;

% Nyquist

plot(real(sumOfZZ),-imag(sumOfZZ),'bo')
xlabel("Z'")
ylabel("-Z''")

% Bode
% 
% module = sqrt((real(sumOfZZ)).^2 + (imag(sumOfZZ)).^2);
% plot(log10(module), log10(w/(2*pi)));
% xlabel("log(f)")
% ylabel("log(|Z|)")

function ZC = getZfromC(C,w)

ZC = -1j./(w.*C);

end

function ZS = getZfromS(A,Y0,w)

ZS = 1./((1j*w).^A *Y0 );

end

function ZL = getZfromL(L,w)

ZL = j.*(w.*L);

end

function ZR = getZfromR(R)

ZR = R;

end

function ZP = getZfromP(R,C,w)
 
ZR = getZfromR(R);
ZC = getZfromC(C,w);

S =  1/ZR + 1./ZC;
 
ZP = 1./S;

 
end

function ZW = getZfromW(Z0,w)
 
ZW = ((1 - 1j)*Z0)./sqrt(w);
 
end

end