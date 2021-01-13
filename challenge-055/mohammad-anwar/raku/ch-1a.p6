#!/usr/bin/env perl6

use Test;

my $unit-tests = {
    "10001" => "11111 (2,4)",
    "10101" => "10111 (4,4) | 11011 (2,4) | 11101 (2,2)",
    "00101" => "11011 (1,4) | 11101 (1,2)"
};

is(flip-binary($_), $unit-tests{$_}, "Tesing binary $_") for $unit-tests.keys;

done-testing;

sub flip-binary(Str $binary-str) {

    my %result;
    my $size = $binary-str.chars;
    for 1 .. $size -> $left {
        for $left .. $size -> $right {
            my $_binary-str = $binary-str;
            for $left .. $right -> $i is copy {
                --$i;
                my $c = $_binary-str.substr($i, 1);
                $c = ($c eq "1") ?? (0) !! (1);
                $_binary-str.substr-rw($i, 1) = $c;
            }
            my $k = sprintf("%s (%s,%s)", $_binary-str, $left, $right);
            my $v = $_binary-str.comb("1").elems;
            %result{$k} = $v;
        }
    }

    return flipped-binary(%result);
}

sub flipped-binary(%result) {

    my Int $v;
    my @r;
    for %result.sort({ $^b.value <=> $^a.value || $^a.key cmp $^b.key }) -> $pair {

        my $_k = $pair.keys;
        my $_v = $pair.values.Str.Int;

        if (defined $v) {
            if ($_v == $v) {
                push @r, $_k;
            }
        }
        else {
            $v = $_v;
            push @r, $_k;
        }
    }

    return @r.join(" | ");
}
