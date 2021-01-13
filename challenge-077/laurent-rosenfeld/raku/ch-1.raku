use v6;

# (Modified task)
my $n = @*ARGS[0]:exists ?? @*ARGS[0] !! 30;
my @fib = 1, 2, * + *  ... ^ * >= $n;
for @fib.combinations -> $s {
    say $s if $n == [+] $s;
}
