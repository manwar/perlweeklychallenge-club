# Create a script that prints Prime Decomposition of a given number. 
# The prime decomposition of a number is defined as a list of prime numbers 
# which when all multiplied together, are equal to that number. For example, 
# the Prime decomposition of 228 is 2,2,3,19 as 228 = 2 * 2 * 3 * 19.
use strict;
use warnings;
use 5.010;

my @r;
my $n   = $ARGV[0];
my $m   = $n;
die "Usage: ch-2.pl <n> \n\tn is a postive number\n" if !@ARGV;
die "n must be a postive number\n" if $n<1;

#Backticks solution using factor, works both on windows and linux :D
say "Using backticks and factor system command:";
say `factor $n`=~s/.+: //r;

#Using ntheory module
say "Using module nthoery";
use ntheory 'factor';
@r = factor $m;
say "@r\n";

#But I feel like I should do a non-backtick/module solution so here we go:
#It's slow(and inaccurate) on very large numbers
say "Using non-backticks solution (trial division/modulo):";
@r = ();
while ($n % 2<1) {
    push @r, 2;
    $n /= 2;
}
my $f = 3;
while ($f*$f<=$n) {
    while ($n % $f<1) {
        push @r, $f;
        $n /= $f;
    }
    $f+=2;
}
$n>1 && push @r, $n;
say "@r\n";
