function wynik_dla_temperatury = uwzglednij_zakres_czestotliwosci(wynik, numer_pomiaru, liczba_pomiarow, min_czestotliwosc, max_czestotliwosc)

liczba_elementow = 0;

for licznik = 1:liczba_pomiarow    
    
    if (wynik(numer_pomiaru).impedancja.czestotliwosc(licznik) < min_czestotliwosc) || (wynik(numer_pomiaru).impedancja.czestotliwosc(licznik) > max_czestotliwosc)
        
        wynik(numer_pomiaru).impedancja.czestotliwosc(licznik) = NaN;
        wynik(numer_pomiaru).impedancja.Z_exp(licznik) = NaN;
        wynik(numer_pomiaru).impedancja.Z_sym(licznik) = NaN;
    end
   
end

wynik_dla_temperatury = wynik(numer_pomiaru);

end
