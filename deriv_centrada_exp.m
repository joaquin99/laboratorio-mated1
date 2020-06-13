function [y0] = deriv_centrada(x,h,c0,c1);
y0 = exp(c0)*(exp(c1*(x+h))-exp(c1*(x-h)))/(2*h)
end
