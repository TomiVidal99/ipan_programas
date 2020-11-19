# create set of random data from natural logarithm 

function [data] = ln_data_set(data_length, multiplier)
  data = multiplier*rand(2, data_length);
  for (i = 1:data_length)
    new_val = log(data(2,i));
    data(2, i) = new_val;
  endfor
endfunction