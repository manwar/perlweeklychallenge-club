#!/usr/bin/perl
# The Weekly Challenge Task 2
# Decimal String
# Usage: ch-2.pl $N $D
use strict;
use warnings;

sub min {
    return $_[0] > $_[1] ? $_[1] : $_[0];
}
sub max {
    return $_[0] < $_[1] ? $_[1] : $_[0];
}

#089 task except
sub gcd {
    my ($a,$b) = ($_[0], $_[1]);
    ($a, $b) = ($b, $a) if $a < $b;
    return !($a % $b) ? $b :  gcd($b , $a % $b);
}

my $pow_two = 0;
my $pow_five = 0;
my $z;

#049 task except modified
sub is_terminating {
    $z = $_[0];
    while ( $z % 2 == 0) {
        $z /= 2;
        $pow_two++;
    }
    while ( $z % 5 == 0) {
        $z /= 5;
        $pow_five++;
    }
    return ($z == 1);
}

my ($N, $D) = ($ARGV[0], $ARGV[1]);

die "Please input numerator and denominator." if (!defined $N);
print "0\n" if $N == 0;
exit if $N == 0;
die "Please input denominator." if (!defined $D);
die "NaN\n" if $D == 0;

my $common = gcd($N,$D);
my ($n, $d) = ($N/$common, $D/$common);

if (is_terminating($d)) {print(($n)/($d+0.0),"\n"); exit;}

my $pow_max = max($pow_two,$pow_five);
my $pow_min = min($pow_two,$pow_five);
my $pow_dif = $pow_max-$pow_min;
my $remain = 0;
my $after_dot_zeros = "0" x $pow_min;
$d /= 10**$pow_min;

my $_n = $n;
my $extend = 1;
if ($pow_dif > 0) {
    $extend = (2**($pow_two-$pow_min)) * (5**($pow_five-$pow_min));
    $n *= $extend;
    $d *= $extend;
    $_n *= $extend;
}

my $integral_part = int ($n / $d);

my $new = $n % $d;

my $checker = undef;
my @cd = ($new,);
my $i = 0;
my $j;
my @after_dot;

do {
    $new = $new * 10;
    push @after_dot , int $new / $d;
    $remain = $new % $d;
    push @cd, $remain; 
    $new = $remain;
    $i++;
    $j = 0;
    while ($j < $i && !$checker) {
        $checker = ($cd[$j] == $remain) || $checker;
        $j++ if !$checker;
    }
} while (!$checker);


print $integral_part;
print "." , $after_dot_zeros;
if ($j != 0) {print @after_dot[0..$j-1];}
print "(",@after_dot[$j..$i-1],")", "\n";
