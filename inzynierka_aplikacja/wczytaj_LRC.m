function [wynik_pomiaru, liczba_pomiarow] = wczytaj_LRC(filename)


%% Initialize variables.
% filename = '/home/aak/Documents/inzynierka/test 2.LCR';
startRow = 18;

%% Read columns of data as text:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%16s%17s%17s%22s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', '', 'WhiteSpace', '', 'TextType', 'string', 'HeaderLines', startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric text to numbers.
% Replace non-numeric text with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = mat2cell(dataArray{col}, ones(length(dataArray{col}), 1));
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[1,2,3,4]
    % Converts text in the input cell array to numbers. Replaced non-numeric
    % text with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1)
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData(row), regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if numbers.contains(',')
                thousandsRegExp = '^[-/+]*\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(numbers, thousandsRegExp, 'once'))
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric text to numbers.
            if ~invalidThousandsSeparator
                numbers = textscan(char(strrep(numbers, ',', '')), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch
            raw{row, col} = rawData{row};
        end
    end
end


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),raw); % Find non-numeric cells
raw(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
all = cell2mat(raw);
wynik_pomiaru = [];

for i = 1:1:size(all)

    if any(isnan(all(i,:)))
        start_row = all(i,:);
        liczba_pomiarow = start_row(1);
        wynik_pomiaru(liczba_pomiarow).number = start_row(1);
        wynik_pomiaru(liczba_pomiarow).temperature = start_row(2);
        j = 1;
    else
        wynik_pomiaru(liczba_pomiarow).results.Z(j) = all(i,1);
        wynik_pomiaru(liczba_pomiarow).results.teta(j) = all(i,2);
        wynik_pomiaru(liczba_pomiarow).results.E_1(j) = all(i,3);
        wynik_pomiaru(liczba_pomiarow).results.E_2(j) = all(i,4);
        
        j = j + 1;
        
    end
    
end

    for i = 1:liczba_pomiarow
        wynik_pomiaru(i).results.Z = (wynik_pomiaru(i).results.Z)';
        wynik_pomiaru(i).results.teta = (wynik_pomiaru(i).results.teta)';
        wynik_pomiaru(i).results.E_1 = (wynik_pomiaru(i).results.E_1)';
        wynik_pomiaru(i).results.E_2 = (wynik_pomiaru(i).results.E_2)';      
    end

%% Calc impedation

    for i = 1:liczba_pomiarow
        
%         test_result(i).imp = test_result(i).results.Z .* exp(1j.*(test_result(i).results.teta)*360/(2*pi));
        wynik_pomiaru(i).imp = wynik_pomiaru(i).results.Z .* exp(1j.*(wynik_pomiaru(i).results.teta));

    end

%% Clear temporary variables
clearvars all i j start_row filename startRow endRow formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp R;

end

