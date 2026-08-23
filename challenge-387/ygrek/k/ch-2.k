
m:,/((`c$"A"+!26)!`U; (`c$"a"+!26)!`L; (`c$"0"+!10)!`N; "()"!`P) / map alphabet into classes
f:{
p:(&{$[(y=`U)&x=`L;0;(x=`N)&y=`N;0;1]}':m@x)_x / break into separate string pieces
/ introduce structure
/ pair elements with quantities and keep opening brackets and closing bracket multipliers (int) as group markers
g::({$[`U=m@*y; $[`N=m@*x;(,y),`I$x;(,y),1]; y~,"("; "("; y~,")"; $[`N=m@*x;`I$x;1]; 0N]}':(p,0N))^0N
i:&g~'"("
j:&`i=@'g
mul:*/,/'(1,'(g@j),'1) * (0,'i,'j)_\:(#g)#1 / compute final multipliers for each position
s:{$[x=1;"";$x]}'+/{(,x)!y*z}.'{`A=@'g}#g,'mul / keep only pairs, multiply, aggregate and drop "1"s
:,//+(!s;.s)@\:<!s / sort by keys
}

(in;out):*''(`j?1:"../../examples/json/ch-2.json").(`examples;`in`out)
`exit@~&/out~' \f' \in
