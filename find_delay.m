function delay = find_delay(a,b)

[c,lags] = xcorr(a,b);

[~,i] = max(c);

delay = -lags(i);