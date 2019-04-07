use strict;
use warnings;
use Const::Fast;

const my $ZERO   => ord('0');
const my $NINE   => ord('9');
const my $A      => ord('A');
const my $Y      => ord('Y');
const my @DIGITS => ('0' .. '9', 'A' .. 'Y');
const my @POWERS => get_powers();

while (my $n = <DATA>)
{
    chomp $n;
    my $p = base35to10($n);
    my $q = base10to35($p);
    printf "%8s(35) = %11s(10) = %8s(35)\n", $n, $p, $q;
}

sub base35to10
{
    my ($base35) = @_;
    my  $base10  = 0;
    my  $power   = 1;

    for my $digit (reverse split //, $base35)
    {
        $base10 += digit35to10($digit) * $power;
        $power  *= 35;
    }

    return $base10;
}

sub base10to35
{
    my ($base10) = @_;

    $base10 < $POWERS[-1] or die "Number $base10 too large, stopped";

    my $index  = get_highest_index($base10);
    my $base35 = '';

    for my $i (reverse 0 .. $index)
    {
        my $digit = $DIGITS[ int($base10 / $POWERS[$i]) ];
        $base35  .= $digit;
        $base10  %= $POWERS[$i];
    }

    return $base35;
}

sub get_highest_index
{
    my ($base10) = @_;
    my  $index   = $#POWERS;

    for my $i (reverse 1 .. $#POWERS - 1)
    {
        last if $base10 >= $POWERS[$i];
        $index = $i - 1;
    }

    return $index;
}

sub digit35to10
{
    my ($digit) = @_;
    my  $ord    = ord($digit);

    return  $digit          if $ord >= $ZERO && $ord <= $NINE;
    return ($ord - $A + 10) if $ord >= $A    && $ord <= $Y;

    die "Unknown base-35 digit '$digit', stopped";
}

sub get_powers
{
    my @powers;
    my $power = 1;

    for (1 .. 13)
    {
        push @powers, $power;
        $power *= 35;
    }

    return @powers;
}

__DATA__
10
17
35
52
A
1A
100
ABC
123
36
0
13579BEH
4
