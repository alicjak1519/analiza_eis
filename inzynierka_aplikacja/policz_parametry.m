function liczba_parametrow = policz_parametry(moduly)

liczba_parametrow = 0;

for znak = 1:length(moduly)
    switch moduly(znak)
        case 'R'
            liczba_parametrow = liczba_parametrow + 1;

        case 'C'
            liczba_parametrow = liczba_parametrow + 1;

        case 'L'
            liczba_parametrow = liczba_parametrow + 1;

        case 'P'
            liczba_parametrow = liczba_parametrow + 3;

        case 'W'
            liczba_parametrow = liczba_parametrow + 1;
            
        case 'S'
            liczba_parametrow = liczba_parametrow + 2;
            
        case 'X'
            liczba_parametrow = liczba_parametrow + 3;

    end

end
end