(in;out):(*'`i$;::)@'(`j?1:"../../examples/json/ch-1.json").(`examples;`in`out)

f:{[d;u;l] $[d+u;$[d;o[d-1;u;l,'0];()],$[u;o[d+1;u-1;l,'1];()];l]}
out~{"DU"@f[0;x;,""]}'in
