clear all
close all

%Read Scenario Manager .ini file and Define all variables
%Read satellites info .csv file

fs = 10000;
ini = ini2struct("scenario_manager.ini"); %ini2struc is an extern function to read the file (not made by me)
satellites = readtable('visible_satellites.csv');
power = str2double(ini.transmittedSignalParameters.p_tx);
bit_rate = 1000*str2double(ini.messageParameters.rb);
tbit = 1/bit_rate;
sim_time = str2double(ini.simulationParameters.t_sim);
date = datetime(ini.simulationParameters.t0);
n_orbit = str2double(ini.satelliteOrbitalParameters.n_orb_planes);
sat_orbit = str2double(ini.satelliteOrbitalParameters.n_sat);
nsat = n_orbit*sat_orbit;
modulation = ini.transmittedSignalParameters.modulation;

%Select Modulation Function and Cardinality
%Not all the possible modulations are included yet

switch modulation
    case '4-PSK'
        mod_function = @psk;  % @ allows to point to a function, so you can access it by another name(mod_function in this case)
        cardinality = 4;
    case '8-PSK'
        mod_function = @psk;
        cardinality = 8;
    case '16-PSK'
        mod_function = @psk;
        cardinality = 16;
    case '32-PSK'
        mod_function = @psk;
        cardinality = 3;
end

%More variable definitions

pkt_rate = str2double(ini.messageParameters.rpkt);
l = bit_rate/pkt_rate;
df = 8/(tbit*log2(cardinality));
full_msg = zeros(nsat,sim_time*fs); % Matrix which will contain the samples transmitted by each satellite (Each row for a different satellite)
mac = ini.transmittedSignalParameters.mac;

%Select Medium Access Function
%CDMA is not included yet

switch mac
    case 'FDMA'
        mac_function = @fdma;
end

%For loop - One iteration each second of simulation (works for pckrate = 1)

for i = 1 : sim_time
    disp("Simulating Second "+(i)) %Indicator for runtime
    [week,tow] = date2gps(date);   %Calculate week and tow
    satellites_t = satellites(satellites.Time == date,:);   %Filter satellites in view at that instant

    %For loop - One iteration for each satellite in view at that instant
    for sat_n = 1 : height(satellites_t)        
    msg = string_gen(tow,week,satellites_t(sat_n,:),l);     %Generate bitstream for an specific satellite
    msg_mod = psk(msg,cardinality,fs,tbit,power);  %Modulates de bitstream
    msg_mac = fdma(msg_mod,df,fs,satellites_t{sat_n,1},nsat); % Applies MAC to the modulated samples of an specific satellite
    full_msg(satellites_t{sat_n,1},fs*(i-1)+1:fs*i) = msg_mac;   %Includes de samples on the main matrix
    end
    date = update_time(date,1);     %Increments the date by 1 second
end

% For loop - Writes the data from the main matrix to .bin file.
%One file for each satellite and one file for each I-Q component
for sat_n = 1:nsat
    disp("Writing data of satellite " + (sat_n))    %Indicator for runtime
    write_file(full_msg(sat_n,1:end),sat_n);        %Function to write I-Q samples of an specific satellite
end
