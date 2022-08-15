#!/usr/bin/env raku
use Test;

# 1, 2i, -4, -8i, 16, 32i, -64, -128i, 256, 512i...*
my $left-seq := [Z*] (1, 2, 4...*), |(1, 1, -1, -1) xx *, |(1, i) xx *;

# -1/2i, -1/4, 1/8i, 1/16, -1/32i, -1/64, 1/128i, 1/256, -1/512i...*
my $right-seq := [Z*] (1/2, 1/4, 1/8...*), |(-1, -1, 1, 1) xx *, |(i, 1) xx *;

test();

sub quater2decimal($n)
{
    my ($a, $b)  = $n.split('.'); $b or $b = '';
    my (@a, @b) := ($a.comb, $b.comb);

    my @left  = $left-seq.cache.head(@a).reverse;
    my @right = $right-seq.cache.head(@b);

    [+] |(@a Z* @left), |(@b Z* @right)
}

multi decimal2quater($n where * ~~ Real)
{
    negaquaternary($n).comb.join(0)
}

multi decimal2quater($n where * ~~ Complex)
{
    my @imag = negaquaternary(($n.im / 2).ceiling).comb;
    my @real = $n.re ?? negaquaternary($n.re).comb !! 0 xx @imag;
    roundrobin(@imag, @real).comb(/\d/).join ~ ($n.im %% 2 ?? '' !! '.2')
}

sub negaquaternary($n)
{
    ($n + 0xCCCCCCCC +^ 0xCCCCCCCC).base(4)
}

sub test
{
    my @n = 1..16;
    my @base-ten = |@n, |(@n >>*>> -1), |(@n >>*>> i), |(@n >>*>> -i);
    my @base-two-i = < 1 2 3 10300 10301 10302 10303 10200 10201 10202 10203 
                       10100 10101 10102 10103 10000 103 102 101 100 203 202 
                       201 200 303 302 301 300 1030003 1030002 1030001 1030000 
                       10.2 10.0 20.2 20.0 30.2 30.0 103000.2 103000.0 103010.2
                       103010.0 103020.2 103020.0 103030.2 103030.0 102000.2 
                       102000.0 0.2 1030.0 1030.2 1020.0 1020.2 1010.0 1010.2 
                       1000.0 1000.2 2030.0 2030.2 2020.0 2020.2 2010.0 2010.2 
                       2000.0 >;

    for @base-two-i Z @base-ten -> ($a, $b)
    {
        ok quater2decimal($a) == $b, "quater2decimal($a) == $b"
    }

    for @base-ten Z @base-two-i -> ($a, $b)
    {
        ok decimal2quater($a) == $b, "decimal2quater($a) == $b"
    }
}
