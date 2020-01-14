classdef nowe_gui_optymalizacja2_exported < matlab.apps.AppBase

    % Properties that correspond to app components
    properties (Access = public)
        UIFigure                        matlab.ui.Figure
        WybierzplikButton               matlab.ui.control.StateButton
        WprowadmodulyEditFieldLabel     matlab.ui.control.Label
        WprowadmodulyEditField          matlab.ui.control.EditField
        STARTButton                     matlab.ui.control.Button
        UIAxes                          matlab.ui.control.UIAxes
        Optymalizacja                   matlab.ui.control.Label
        WprowadzPocztkoweWartosciEditFieldLabel  matlab.ui.control.Label
        WprowadzPocztkoweWartosciEditField  matlab.ui.control.EditField
        WartobduLabel                   matlab.ui.control.Label
        Label_3                         matlab.ui.control.Label
        WartociparametrwLabel           matlab.ui.control.Label
        Label_2                         matlab.ui.control.Label
        TemperaturaCLabel               matlab.ui.control.Label
        Label                           matlab.ui.control.Label
        WynikiLabel                     matlab.ui.control.Label
        OptymalizacjaautomatycznaLabel  matlab.ui.control.Label
        WprowaddolnegraniceEditFieldLabel  matlab.ui.control.Label
        WprowaddolnegraniceEditField    matlab.ui.control.EditField
        WybrzakresuczstotliwociLabel    matlab.ui.control.Label
        ZakresczstotliwociLabel         matlab.ui.control.Label
        NumerpomiaruSliderLabel         matlab.ui.control.Label
        NumerpomiaruSlider              matlab.ui.control.Slider
        ZapiszwynikdlawybranegopomiaruButton  matlab.ui.control.Button
        ZapiszwszystkoButton            matlab.ui.control.Button
        MinSliderLabel                  matlab.ui.control.Label
        MinSlider                       matlab.ui.control.Slider
        MaxSliderLabel                  matlab.ui.control.Label
        MaxSlider                       matlab.ui.control.Slider
        OKButton                        matlab.ui.control.Button
        MinManual                       matlab.ui.control.NumericEditField
        MaxManual                       matlab.ui.control.NumericEditField
        WprowadgrnegraniceEditFieldLabel  matlab.ui.control.Label
        WprowadgrnegraniceEditField     matlab.ui.control.EditField
        Switch                          matlab.ui.control.Switch
    end

    
    properties (Access = private)
        nazwa_pliku;
        sciezka_pliku;
        wynik_zrodlo;
        wynik_kopia;
        nowy_wynik_temp;
        onoff = 0;
        czestotliwosci;
        liczba_pomiarow;
        min_czestotliwosc;
        max_czestotliwosc;
        dolna_granica;
        gorna_granica;
        wykres;
       
    end
    

    methods (Access = private)

        % Value changed function: WybierzplikButton
        function WybierzplikButtonValueChanged(app, event)
            [app.nazwa_pliku,app.sciezka_pliku] = uigetfile('*.LCR');
            figure(app.UIFigure);
            app.Optymalizacja.Text = app.nazwa_pliku;
            
            [app.wynik_zrodlo, app.liczba_pomiarow] = wczytaj_LRC2(strcat(app.sciezka_pliku,app.nazwa_pliku));
            app.NumerpomiaruSlider.Limits = [1 app.liczba_pomiarow];       
            
            app.czestotliwosci = wczytaj_czestotliwosci2(strcat(app.sciezka_pliku,app.nazwa_pliku));
            app.MaxSlider.Limits = [log10(app.czestotliwosci(1)) log10(app.czestotliwosci(end))];
            app.MinSlider.Limits = [log10(app.czestotliwosci(1)) log10(app.czestotliwosci(end))];
            
            app.onoff = 0;

        end

        % Button pushed function: STARTButton
        function STARTButtonPushed(app, event)
            moduly = app.WprowadmodulyEditField.Value;
            
            if isempty(app.WprowaddolnegraniceEditField.Value)
               [app.dolna_granica, app.gorna_granica] = wyznacz_granice(moduly);
            else
                app.dolna_granica = str2double(strsplit(app.WprowaddolnegraniceEditField.Value,','));
                app.gorna_granica = str2double(strsplit(app.WprowadgrnegraniceEditField.Value,','));
            end
                        
            if strcmp(app.Switch.Value,'algorytm genetyczny')
                app.wynik_zrodlo = main_ga(strcat(app.sciezka_pliku,app.nazwa_pliku), moduly, app.dolna_granica, app.gorna_granica);
               
            else
                parametry = str2double(strsplit(app.WprowadzPocztkoweWartosciEditField.Value,','));
                app.wynik_zrodlo = main_granice(strcat(app.sciezka_pliku,app.nazwa_pliku), moduly, parametry, app.dolna_granica, app.gorna_granica);

            end
            
            app.wynik_kopia = app.wynik_zrodlo;
            
            app.onoff = 1;
                      
        end

        % Value changed function: NumerpomiaruSlider
        function NumerpomiaruSliderValueChanged(app, event)
            value = app.NumerpomiaruSlider.Value;
            wynik_aktualny = app.wynik_zrodlo(round(value));
            disableDefaultInteractivity(app.UIAxes);
            
            if app.onoff == 0
                plot(app.UIAxes, real(wynik_aktualny.imp), -imag(wynik_aktualny.imp), 'r.');
                app.Label.Text = num2str(wynik_aktualny.temperature);

            else
                plot(app.UIAxes, real(wynik_aktualny.impedancja.Z_exp), -imag(wynik_aktualny.impedancja.Z_exp), 'r.', real(wynik_aktualny.impedancja.Z_sym), -imag(wynik_aktualny.impedancja.Z_sym), 'b-')
                app.Label_3.Text = num2str(wynik_aktualny.blad, 5);
                app.Label_2.Text = num2str(wynik_aktualny.wektor);
                app.Label.Text = num2str(wynik_aktualny.temperatura);
                
            end
            
            app.NumerpomiaruSlider.Value = round(value);
            
        end

        % Value changed function: MinSlider
        function MinSliderValueChanged(app, event)
            value = app.MinSlider.Value;
            if value > app.MaxSlider.Value
                app.MinSlider.Value = app.MaxSlider.Value;
            end
            
            app.MinManual.Value = value;
        end

        % Value changed function: MaxSlider
        function MaxSliderValueChanged(app, event)
            value = app.MaxSlider.Value;
            if value < app.MinSlider.Value
                app.MaxSlider.Value = app.MinSlider.Value;
            end
                
            app.MaxManual.Value = value;
        end

        % Value changed function: MinManual
        function MinManualValueChanged(app, event)
            value = app.MinManual.Value;
            app.min_czestotliwosc = 10^value;
            app.MinSlider.Value = value;
        end

        % Value changed function: MaxManual
        function MaxManualValueChanged(app, event)
            value = app.MaxManual.Value;
            app.max_czestotliwosc = 10^value;
            app.MaxSlider.Value = value;
        end

        % Button pushed function: OKButton
        function OKButtonPushed(app, event)
            app.nowy_wynik_temp = uwzglednij_wskaznik_czestotliwosci(app.wynik_zrodlo, app.NumerpomiaruSlider.Value, app.WprowadmodulyEditField.Value, 10^app.MinManual.Value, 10^app.MaxManual.Value);
            
            app.Label_3.Text = num2str(app.nowy_wynik_temp.blad, 5);
            app.Label_2.Text = num2str(app.nowy_wynik_temp.wektor);
          
            plot(app.UIAxes, real(app.wynik_zrodlo(app.NumerpomiaruSlider.Value).impedancja.Z_exp), -imag(app.wynik_zrodlo(app.NumerpomiaruSlider.Value).impedancja.Z_exp), 'r.', real(app.nowy_wynik_temp.impedancja.Z_sym), -imag(app.nowy_wynik_temp.impedancja.Z_sym), 'bo')

        end

        % Button pushed function: ZapiszwszystkoButton
        function ZapiszwszystkoButtonPushed(app, event)
            nazwa_zapisywanego_pliku = uiputfile;
            
            assignin('base', nazwa_zapisywanego_pliku, app.wynik_zrodlo);
            
            zapisz_wynik(nazwa_zapisywanego_pliku);
        end

        % Value changed function: Switch
        function SwitchValueChanged(app, event)
            
            if strcmp(app.Switch.Value,'algorytm genetyczny')
                app.WprowadzPocztkoweWartosciEditField.Visible = 'off';
                app.WprowadzPocztkoweWartosciEditFieldLabel.Text = ' ';
            else
                app.WprowadzPocztkoweWartosciEditField.Visible = 'on';
                app.WprowadzPocztkoweWartosciEditFieldLabel.Text = 'Wprowadź początkowe wartości ';

            end
            
        end

        % Button pushed function: ZapiszwynikdlawybranegopomiaruButton
        function ZapiszwynikdlawybranegopomiaruButtonPushed(app, event)
            nazwa_zapisywanego_pliku = uiputfile;
           
            assignin('base', nazwa_zapisywanego_pliku, app.nowy_wynik_temp);
            
            zapisz_wynik(nazwa_zapisywanego_pliku);
        end
    end

    methods (Access = public)

        % Construct app
        function app = nowe_gui_optymalizacja2_exported

            % Create and configure components
            createComponents(app)

            % Register the app with App Designer
            registerApp(app, app.UIFigure)

            if nargout == 0
                clear app
            end
        end

        % Code that executes before app deletion
        function delete(app)

            % Delete UIFigure when app is deleted
            delete(app.UIFigure)
        end
    end
end