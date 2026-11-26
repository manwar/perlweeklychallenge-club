#! /usr/bin/raku

use Test;

sub fractionaladditionsubstraction($a) {
    my @terms;
    my $state = 0;
    my $n = 0;
    my $num = 0;
    my $sign = 0;
    my @cv = $a.comb;
    my $i = 0;
    while ($i < @cv.elems) {
        given $state {
            when 0 {
                given @cv[$i] {
                    when "+" {
                        $state = 0;
                        $i++;
                    }
                    when "0".."9" {
                        $sign = 1;
                        $state = 1;
                        $n = 0 + @cv[$i];
                        $i++;
                    }
                    when "-" {
                        $sign = -1;
                        $state = 1;
                        $n = 0;
                        $i++;
                    }
                }
            }
            when 1 {
                given @cv[$i] {
                    when "0".."9" {
                        $n = 10 * $n + @cv[$i];
                        $i++;
                    }
                    when "/" {
                        $num = $n * $sign;
                        $n = 0;
                        $state = 2;
                        $i++;
                    }
                }
            }
            when 2 {
                given @cv[$i] {
                    when "0".."9" {
                        $n = 10 * $n + @cv[$i];
                        $i++;
                    }
                    default {
                        @terms.push(Rat.new($num, $n));
                        $state = 0;
                    }
                }
            }
        }
    }
    if ($state == 2) {
        @terms.push(Rat.new($num, $n));
    }
    my $out = @terms[0].clone;
    for @terms.skip(1) -> $nt {
        $out = $out + $nt;
    }
    $out.numerator ~ '/' ~ $out.denominator;
}

plan 5;

is(fractionaladditionsubstraction('1/2+3/2'), '2/1', 'example 1');
is(fractionaladditionsubstraction('-5/2-3/2'), '-4/1', 'example 2');
is(fractionaladditionsubstraction('5/3-5/3'), '0/1', 'example 3');
is(fractionaladditionsubstraction('10/10-1/10+2/5'), '13/10', 'example 4');
is(fractionaladditionsubstraction('1/6+1/6+1/6'), '1/2', 'example 5');
