/ add dash to element 0 and 1
adddash: {(x[0],"-";x[1],"-";x[2])}
/ convert int to binary string
bin: {|,//${$[0=2!x;0;1]}'{x>1}{_x%2}\x}
{,//adddash (bin'.'"-"\x)}'("2025-07-26";"2000-02-02";"2024-12-31")
