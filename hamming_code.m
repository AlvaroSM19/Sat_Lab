function [code_out] = hamming_code(code_in,p)

%%Not used in the basic scenario, but alredy implemented.

d = 2^p - p -1;
r = ceil(length(code_in)/d);
code_in = [code_in zeros(1,r*d - length(code_in))];

[~,G] = hammgen(p);
code_out = zeros(1,(p+d)*r);
for i = 1 : (length(code_in)/d)
    code_out((p+d)*(i-1) + 1:i*(p+d)) = round(mod(code_in(d*(i-1)+1:d*i)*G,2));
end

end