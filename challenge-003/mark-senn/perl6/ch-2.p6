# Perl Weekly Challenge - 003
# Challenge #2
#
# See
#     http://bit.ly/pwc-003
# for more information.

# Run using Perl 6.
use v6;

sub MAIN(Int $y where * >= 3)
{
    my $x = ($y/2).floor;

    my $max-value = binom($y, $x);
    my $w = $max-value.chars;

    for (0..$y) -> $n
    {
        # Start each row with ($y-$n) * (1+$w) spaces followed by a 1.
        print ' ' x ($y-$n) * (1+$w);
        print '1';

        # Each subsequent column should be
        #     o  prefixed by a space
        #     o  followed by $w spaces (for the missing number in that column)
        #     o  followed by another space
        #     o  followed by the column value right-justified in a field $w characters wide
        for (1..$n) -> $k
        {
            print ' ';
            print ' ' x $w;
            print ' ';
            printf "%{$w}d", binom($n,$k);
        }    
        print "\n";
    }
}

sub binom($n, $k)
{
    fact($n) / (fact($k) * fact($n-$k))
}

sub fact($n)
{
    ($n == 0)
    ??  1
    !!  [*] (1..$n)
}

sub USAGE()
{
    note "usage: perl6 {$*PROGRAM-NAME} non-negative_integer_of_at_least_three";
}
