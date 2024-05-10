    function [s] = apsk(msg_in,cardinality,fs,tbit,power)
       
        %%Same behaviour than psk function

        tsim = tbit * log2(cardinality);
        fsim = 1/tsim;
        r = ceil(length(msg_in)/log2(cardinality));
        msg_in = [msg_in zeros(1,r*log2(cardinality) - length(msg_in))];
        cardinality = 32;
        psk2_phase = linspace(0,pi*(2-2/2),2);
        psk4_phase = linspace(0,pi*(2-2/4),4);
        psk8_phase = linspace(0,pi*(2-2/8),8);
        psk16_1_phase = linspace(pi/4,pi*(2-2/4 + 1/4),4);
        psk16_2_phase = linspace(pi/12,pi*(2-2/12 + 1/12),12);
        psk32_1_phase = linspace(pi/4,pi*(2-1/4),4);
        psk32_2_phase = linspace(pi/8,pi*(2-1/12),12);
        psk32_3_phase = linspace(0,pi*(2-2/16),16);

        apsk_sequence = [5, 14, 8, 11, 4, 15, 9, 10, 6, 13, 7, 12, 0, 3, 1, 2 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0; ...
                         5, 6, 14, 13, 8, 7, 11, 12, 17, 19, 30, 28, 22, 20, 25, 27, 4, 0, 15, 3, 9, 1, 10, 2, 16, 18, 31, 29, 23, 21, 24, 26];
        apsk_matrix = [sqrt(2*power)*1*exp(1*1i*psk2_phase) zeros(1,30);...
            sqrt(2*power)*1*exp(1*1i*psk4_phase) zeros(1,28);...
            sqrt(2*power)*1*exp(1*1i*psk8_phase) zeros(1,24);...
            sqrt(16/36.56*power)*1*exp(1*1i*psk16_1_phase) sqrt(16/36.56*power)*2.4*exp(1*1i*psk16_2_phase) zeros(1,16);... 
            sqrt(32/164.56*power)*1*exp(1*1i*psk32_1_phase) sqrt(32/164.56*power)*2.4*exp(1*1i*psk32_2_phase) sqrt(32/164.56*power)*4*exp(1*1i*psk32_3_phase)];
      
       i_out = zeros(1,tbit*fs*length(msg_in));
       q_out = zeros(1,tbit*fs*length(msg_in));
      for z = 1 : (length(msg_in)/log2(cardinality))
        i_out((fs/fsim)*(z-1)+1:z*fs/fsim) = (linspace(real(apsk_matrix(log2(cardinality),1+apsk_sequence(1+bin2dec(num2str(msg_in(log2(cardinality)*(z-1)+1:log2(cardinality)*z)))))),...
            real(apsk_matrix(log2(cardinality),1+apsk_sequence(1+bin2dec(num2str(msg_in(log2(cardinality)*(z-1)+1:log2(cardinality)*z)))))),fs/fsim));
        q_out((fs/fsim)*(z-1)+1:z*fs/fsim) = (linspace(imag(apsk_matrix(log2(cardinality),1+apsk_sequence(1+bin2dec(num2str(msg_in(log2(cardinality)*(z-1)+1:log2(cardinality)*z)))))),...
            imag(apsk_matrix(log2(cardinality),1+apsk_sequence(1+bin2dec(num2str(msg_in(log2(cardinality)*(z-1)+1:log2(cardinality)*z))))   )),fs/fsim));
      end

      s = i_out +1*1i*q_out;

    end