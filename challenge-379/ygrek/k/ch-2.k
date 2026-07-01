len:1|+/|\0< / number of digits without leading zeroes
f:{[base;limit]&a={+/*/(len[x])#,x}'+base\a:!limit}
f[10;1000]
f[7;1000]
f[16;1000]
