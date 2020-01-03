function startRow = znajdzStartRow(filename)

%% Initialize variables.
delimiter = ' ';
startRow = 4;
endRow = 4;

%% Format for each line of text:
formatSpec = '%f%*s%*s%*s%*s%*s%*s%*s%*s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to the format.
dataArray = textscan(fileID, formatSpec, endRow-startRow+1, 'Delimiter', delimiter, 'MultipleDelimsAsOne', true, 'TextType', 'string', 'HeaderLines', startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');

%% Close the text file.
fclose(fileID);

%% Create output variable
liczbaCzestotliwosci = [dataArray{1:end-1}];
%% Clear temporary variables
clearvars filename delimiter startRow endRow formatSpec fileID dataArray ans;

liczbaWierszyCzest = idivide(liczbaCzestotliwosci, int32(8)) + 1;


startRow = 4 + liczbaWierszyCzest + 1

end