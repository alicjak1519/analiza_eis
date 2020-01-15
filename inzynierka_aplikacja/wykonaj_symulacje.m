function Z_sym = wykonaj_symulacje(moduly, parametry, czestotliwosci)

liczba_modulow = length(moduly);
aktualny_indeks = 1;

w = czestotliwosci;

wynik_symulacji = zeros([length(w) 1]);

for sign = 1:liczba_modulow
    
    switch moduly(sign)
        case 'R'
            r = 10^(parametry(aktualny_indeks));
            impedancja_pomiaru = oblicz_impedancje_R(r);
            aktualny_indeks = aktualny_indeks + 1;
            
        case 'C'
            c = 10^(parametry(aktualny_indeks));
            impedancja_pomiaru = oblicz_impedancje_C(c, w);
            aktualny_indeks = aktualny_indeks + 1;
            
        case 'W'
            Z0 = 10^(parametry(aktualny_indeks));
            impedancja_pomiaru = oblicz_impedancje_W(Z0, w);
            aktualny_indeks = aktualny_indeks + 1;
            
        
        case 'S'
            A = parametry(aktualny_indeks);
            Y0 = 10^(parametry(aktualny_indeks + 1));
            impedancja_pomiaru = oblicz_impedancje_S(A,Y0, w);
            aktualny_indeks = aktualny_indeks + 2;
            
        case 'X'
            R = 10^parametry(aktualny_indeks);
            A = parametry(aktualny_indeks+1);
            Y0 = 10^(parametry(aktualny_indeks + 2));
            impedancja_pomiaru = oblicz_impedancje_X(R,A,Y0, w);
            aktualny_indeks = aktualny_indeks + 3;
            
        case 'P'
            R = 10^parametry(aktualny_indeks);
            A = parametry(aktualny_indeks+1);
            Y0 = 10^(parametry(aktualny_indeks + 2));
            impedancja_pomiaru = oblicz_impedancje_P(R,A,Y0, w);
            aktualny_indeks = aktualny_indeks + 3;
            
    end
    
    wynik_symulacji = wynik_symulacji + impedancja_pomiaru;

end


Z_sym = wynik_symulacji;

end
