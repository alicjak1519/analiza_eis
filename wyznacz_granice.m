function [lb, ub] = wyznacz_granice(moduly)

liczba_modulow = length(moduly);

lb = [];
ub = [];

for litera = 1:liczba_modulow
    
    switch moduly(litera)
        case 'R'
            lb = [lb, 0];
            ub = [ub, 7];
        case 'C'
            lb = [lb, -11];
            ub = [ub, -7];
        
        case 'W'
            lb = [lb, -11];
            ub = [ub, -3];
            
        case 'S'
            lb = [lb, -11];
            ub = [ub, -7];
            
        case 'P'
            lb = [lb 0, -11];
            ub = [ub 7, -3];
    end
end
end
