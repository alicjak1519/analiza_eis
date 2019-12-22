function err = oblicz_sume_bledow_bez_dodatnich(Z_exp, moduly, parametry, czestotliwosci)

Z_sym = wykonaj_symulacje(moduly, parametry, czestotliwosci);

liczba_punktow_pomiarowych = length(Z_exp);

for i = 1:liczba_punktow_pomiarowych
    if imag(Z_exp(i)) > 0
        error_diff = Z_sym - Z_exp;
    end
end

error_sum = sum(abs(error_diff).^2);
liczba_uwzglednianych_pomiarow = length(error_diff);
err = error_sum/liczba_uwzglednianych_pomiarow;

end