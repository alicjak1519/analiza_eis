function wskaznik = dobierz_wskaznik_czestotliwosci(zrodlo, numer_pomiaru, liczba_pomiarow, min_czestotliwosc, max_czestotliwosc)

wskaznik = [];

for licznik = 1:liczba_pomiarow
    
    if zrodlo(numer_pomiaru).impedancja.czestotliwosc(licznik) < min_czestotliwosc
        wskaznik = [wskaznik; 0];
    elseif zrodlo(numer_pomiaru).impedancja.czestotliwosc(licznik) > max_czestotliwosc
        wskaznik = [wskaznik; 0];
    else
        wskaznik = [wskaznik; 1];
    end
    
end

end
