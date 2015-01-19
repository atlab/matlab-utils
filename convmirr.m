% this performs a fast FIR filter with boundary mirroring to
% reduce boundary artifacts.
% Dimitri Yatsenko, 2010-09-07

function x = convmirr(x, k)
assert( size(k,2)==1, 'kernel must be a column' );
l = size(x,1);
n = length(k);
assert(l>n, 'kernel must be shorter than signal');

% mirror boundaries in time
n = floor(n/2);
x = [x(n+2-(1:n),:); x; x(end-(1:n),:)];
x = fftfilt(k,x);  % apply filter
x = x(2*n+1:end,:);  % take valid values only