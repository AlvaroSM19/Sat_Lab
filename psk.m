function [s] = psk(msg_in,cardinality,fs,tbit,power)
        
        %Define variables

        tsim = tbit * log2(cardinality);
        fsim = 1/tsim;
        r = ceil(length(msg_in)/log2(cardinality));
        msg_in = [msg_in zeros(1,r*log2(cardinality) - length(msg_in))];
        psk2_phase = linspace(0,pi*(2-2/2),2);
        psk4_phase = linspace(0,pi*(2-2/4),4);
        psk8_phase = linspace(0,pi*(2-2/8),8);
        psk16_phase = linspace(0,pi*(2-2/16),16);
        psk32_phase = linspace(0,pi*(2-2/32),32);
        
        %Gray sequence used (indicates the position of the symbol n.index, 
        %for example symbol number 3 is in the second position (starting from 0)

        gray_sequence = [0, 1, 3, 2, 7, 6, 4, 5, 15, 14, 12, 13, 8, 9, 11, 10, 31, 30, 28, 29, 24, 25, 27, 26, 16, 17, 19, 18, 23, 22, 20, 21];

        %Define matrix with amplitudes and phases for each  PSK modulation

        psk_matrix = [sqrt(2*power)*1*exp(1*1i.*psk2_phase) zeros(1,30);...
            sqrt(2*power)*1*exp(1*1i.*psk4_phase) zeros(1,28);...
            sqrt(2*power)*1*exp(1*1i.*psk8_phase) zeros(1,24);...
            sqrt(2*power)*1*exp(1*1i.*psk16_phase) zeros(1,16);... 
            sqrt(2*power)*1*exp(1*1i*psk32_phase) ];
        
        %Create output vectors

       i_out = zeros(1,tbit*fs*length(msg_in));
       q_out = zeros(1,tbit*fs*length(msg_in));

       %For loop to write for each group of bits (depending on
       %cardinality), the correct sampled symbol, taken from the
       %psk_matrix, and taking into account the gray_sequence
      for z = 1 : (length(msg_in)/log2(cardinality))

        i_out((fs/fsim)*(z-1)+1:z*fs/fsim) = (linspace(real(psk_matrix(log2(cardinality),1+gray_sequence(1+bin2dec(num2str(msg_in(log2(cardinality)*(z-1)+1:log2(cardinality)*z)))))),...
            real(psk_matrix(log2(cardinality),1+gray_sequence(1+bin2dec(num2str(msg_in(log2(cardinality)*(z-1)+1:log2(cardinality)*z)))))),fs/fsim));

        q_out((fs/fsim)*(z-1)+1:z*fs/fsim) = (linspace(imag(psk_matrix(log2(cardinality),1+gray_sequence(1+bin2dec(num2str(msg_in(log2(cardinality)*(z-1)+1:log2(cardinality)*z)))))),...
            imag(psk_matrix(log2(cardinality),1+gray_sequence(1+bin2dec(num2str(msg_in(log2(cardinality)*(z-1)+1:log2(cardinality)*z)))))),fs/fsim));

      end
      
      s = i_out +1i*q_out;  %Output of the function (I-Q samples)
end