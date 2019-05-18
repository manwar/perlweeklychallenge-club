use v6;

sub divisors (Int $num) {
    return 1, | grep { $num %% $_ }, 2 .. (1 + ($num / 2).Int);
}
my $num = 1;
my @triangular-numbers = 1,  * + ++$num ... *;
for @triangular-numbers -> $triangular-num {
    last if $triangular-num > 10000;
    say $triangular-num if $triangular-num == [+] divisors $triangular-num;
}
say now -  INIT now;
