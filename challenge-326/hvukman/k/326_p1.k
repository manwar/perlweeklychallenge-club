div4: {(0=100!x ;4!x)}
first: {2=+/1 0 = (div4 x)}
second: {0=400!x}
check: {(first x;second x)}

// if divisible by 400 or by 4
// 0<+/check 2002
// 0<+/check 2000

nonleap: 31 28 31 30 31 30 31 31 30 31 30 31
leap: 31 29 31 30 31 30 31 31 30 31 30 31

date:.'"-"\"2025-02-02"
day: {$[ 0<+/check x[0];(+/(x[1]-12+1)_leap)+x[2];(+/(x[1]-12+1)_nonleap)+x[2] ]}
day date

date:.'"-"\"2025-04-10"
day date

date:.'"-"\"2025-09-07"
day date
