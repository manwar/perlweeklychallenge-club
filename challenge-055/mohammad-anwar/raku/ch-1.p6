#!/usr/bin/env perl6

use v6.c;

multi sub MAIN(*@) is hidden-from-USAGE {
    say $*USAGE;
    say "\nERROR: Invalid binary string !!!";
}

multi sub MAIN(Str :$binary-str where { m/^ <[01]>+ $/ }) {
    say ($binary-str, flip-binary($binary-str)).join(" => ");
}

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

    my Int $value;
    my @r;
    for %result.sort({ $^b.value <=> $^a.value || $^a.key cmp $^b.key }) -> $pair {

        my $_k = $pair.keys;
        my $_v = $pair.values.Str.Int;

        if defined $value {
            if $_v == $value {
                push @r, $_k;
            }
        }
        else {
            $value = $_v;
            push @r, $_k;
        }
    }

    return @r.join(" | ");
}
