function [] = write_file(data,sat)

    f_i = fopen("sat_"+num2str(sat)+"_i.bin","w");  
    f_q = fopen("sat_"+num2str(sat)+"_q.bin","w");
    fwrite(f_i, real(data), 'float32');
    fwrite(f_q, imag(data), 'float32');
    fclose(f_i);
    fclose(f_q);
    
end