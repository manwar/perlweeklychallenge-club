use v6;

sub divisors (Int $num) {
    return 1, | grep { $num %% $_ }, 2 .. (1 + ($num / 2).Int);
}
my $num = 1;
my @triangular-numbers = 1,  * + ++$num ...^ * > 10000 ;
.say if $_ == [+] divisors $_ for @triangular-numbers;
say now - INIT now;
