function [lb, ub] = wyznacz_granice(moduly)

liczba_modulow = length(moduly);

lb = [];
ub = [];

for litera = 1:liczba_modulow
    
    switch moduly(litera)
        case 'R'
            lb = [lb, -10];
            ub = [ub, 7];
            
        case 'C'
            lb = [lb, -10];
            ub = [ub, -5];
        
        case 'W'
            lb = [lb, -11];
            ub = [ub, -3];
            
        case 'S'
            lb = [lb, 0, -11];
            ub = [ub, 1, 0];
            
        case 'X'
            lb = [lb, -10, 0, -11];
            ub = [ub, 7, 2, 0];
            
        case 'P'
            lb = [lb, 0, 0, -10];
            ub = [ub, 7, 1, -5];
        end
end