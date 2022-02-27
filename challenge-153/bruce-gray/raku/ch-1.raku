my @fact = 1, |[\*] 1 .. *;
my @left =     [\+] @fact;

say join ', ', @left.head(10);

# Output: 1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114
