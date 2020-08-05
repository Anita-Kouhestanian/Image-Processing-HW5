function [result] = myfscs(image)
image   = double(image);
B       = max(image(:));
A       = min(image(:));
K       = 256;
P       = (K-1) / (B-A);
L       = - A * (K-1) / (B-A);
result  = P.*image + L;
result(result>=K) = K-1;
result(result<0)  = 0;

result = uint8(result);