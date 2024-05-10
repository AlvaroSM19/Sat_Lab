function [output_msg] = fdma(input_msg,df,fs,sat_n,nsat)
t = 0:1/fs:length(input_msg)/fs - 1/fs; %Define time vector
df_n = sat_n - floor(nsat/2);   %Set the frequency offset for the specific satellite
output_msg = input_msg.*exp(1i*2*pi*df_n*df*t); %Frequency offset of df_n*df Hz

end

%%HOW IS DF CALCULATED%%

% df = 8/(tbit*log2(cardinality));

%%FOR EACH SATELLITE

%df_n = sat_n - floor(nsat/2);

%%FREQUENCY OFFSET for SAT_N is DF*DF_N