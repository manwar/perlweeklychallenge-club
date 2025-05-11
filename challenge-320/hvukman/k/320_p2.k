ints: 1 23 4 5
split: {.'(#x;1)#x }
abs:{x|-x}
abs(+/,//split'$ints)-(+/ints)
ints: 1 2 3 4 5
abs(+/,//split'$ints)-(+/ints)
ints: 1 2 34
abs(+/,//split'$ints)-(+/ints)
