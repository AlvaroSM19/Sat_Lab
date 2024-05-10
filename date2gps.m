function [week,tow] = date2gps(date1)

date2 = datetime('1980-01-07 00:00:00'); % Reference date

difference= date1 - date2; 

sec = seconds(difference); 

week = floor(sec/604800); %Finds week (starting from 0, not sure if its okay)
tow = sec- week*604800;   %Find tow (total seconds - week number* seconds per week)
end

