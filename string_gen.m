function [out_string] = string_gen(tow,week,satellite_data,l)

    %Transform string extracted from the .csv file and the time info to separeted bits
    %STRING FORMAT
    %8 bits for SAT_ID
    %12 bits for week
    %20 bits for tow
    %32 bits for each eci_pos component
    %32 bits for each eci_v component
    %32 bits for each ecef_pos component
    %32 bits for each ecef_v component
    %Random bits to reach 1000 bits per packet
    
    sat_id = rmmissing(str2double(split(dec2bin(satellite_data{1,1},8),'')))';
    eci_pos = rmmissing(str2double(strsplit(strrep(strrep(cell2mat(satellite_data{1,3}),'[',''),']',''))));
    eci_pos_x = rmmissing(str2double(split(dec2bin(eci_pos(1),32),'')))';
    eci_pos_y = rmmissing(str2double(split(dec2bin(eci_pos(2),32),'')))';
    eci_pos_z = rmmissing(str2double(split(dec2bin(eci_pos(3),32),'')))';
    eci_v = rmmissing(str2double(strsplit(strrep(strrep(cell2mat(satellite_data{1,4}),'[',''),']',''))));
    eci_v_x = rmmissing(str2double(split(dec2bin(eci_v(1),32),'')))';
    eci_v_y = rmmissing(str2double(split(dec2bin(eci_v(2),32),'')))';
    eci_v_z = rmmissing(str2double(split(dec2bin(eci_v(3),32),'')))';
    ecef_pos = rmmissing(str2double(strsplit(strrep(strrep(cell2mat(satellite_data{1,5}),'[',''),']',''))));
    ecef_pos_x = rmmissing(str2double(split(dec2bin(ecef_pos(1),32),'')))';
    ecef_pos_y = rmmissing(str2double(split(dec2bin(ecef_pos(2),32),'')))';
    ecef_pos_z = rmmissing(str2double(split(dec2bin(ecef_pos(3),32),'')))';
    ecef_v = rmmissing(str2double(strsplit(strrep(strrep(cell2mat(satellite_data{1,6}),'[',''),']',''))));
    ecef_v_x = rmmissing(str2double(split(dec2bin(ecef_v(1),32),'')))';
    ecef_v_y = rmmissing(str2double(split(dec2bin(ecef_v(2),32),'')))';
    ecef_v_z = rmmissing(str2double(split(dec2bin(ecef_v(3),32),'')))';
    week_str = str2double(split((dec2bin(week,12)), '')');
    week_str2 = week_str(2:end-1);
    tow_str = str2double(split((dec2bin(tow,20)), '')');
    tow_str2 = tow_str(2:end-1);
    data_str = [sat_id week_str2 tow_str2 eci_pos_x eci_pos_y eci_pos_z eci_v_x eci_v_y eci_v_z ...
                               ecef_pos_x ecef_pos_y ecef_pos_z ecef_v_x ecef_v_y ecef_v_z];
    out_string = randi([0 1],1,l);
    out_string(1:length(data_str)) = data_str;
end

