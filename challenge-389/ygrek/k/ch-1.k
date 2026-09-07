(in;out):(`j?1:"../../examples/json/ch-1.json").(`examples;`in`out)

up:{`c$x+("A"-"a")*~"a">x}
f:{[name;notes;perm] " "/(,up name," =>"),notes@<`i$perm-1}
(f.*)'in
*'out
