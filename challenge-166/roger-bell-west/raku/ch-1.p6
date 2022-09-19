#! /usr/bin/perl6

use Test;

plan 6;

is(hexwords(2,8,8).elems(),1463,'example 1');

is(hexwords(8,8,8).elems(),164,'example 2');

is(hexwords(2,8,0).elems(),45,'example 3');

is(hexwords(2,8,1).elems(),244,'example 4');

is(combiwords(hexwords(4,4,0),8).elems(),144,'example 5');

is(combiwords(hexwords(3,5,0),8).elems(),274,'example 6');

sub hexwords($lo,$hi,$sb) {
    my @out;
    for 'dictionary.txt'.IO.lines -> $line {
        if ($line.chars() >= $lo && $line.chars() <= $hi) {
            my $valid = True;
            my $sbc = 0;
            for $line.comb() -> $c {
                if ($c ~~ /<[oilst]>/) {
                    $sbc++;
                    if ($sbc > $sb) {
                        $valid = False;
                    }
                } elsif ($c lt 'a' || $c gt 'f') {
                    $valid = False;
                }
                unless ($valid) {
                    last;
                }
            }
            if ($valid) {
                @out.push($line);
            }
        }
    }
    return @out;
}

sub combiwords(@wl,$l) {
    my %wh;
    for @wl -> $w {
        %wh{$w.chars()}.push($w);
    }
    my @tmap=[[],];
    my @omap;
    while (@tmap.elems() > 0) {
        my @c=@tmap.pop().flat;
        my $s=@c.sum();
        for (1..$l-$s-1) -> $j {
            if (%wh{$j}:exists) {
                my @cc = @c».List.flat;
                @cc.push($j);
                @tmap.push(@cc);
            }
        }
        if (%wh{$l-$s}:exists) {
            @c.push($l-$s);
            @omap.push(@c);
        }
    }
    my @out;
    for @omap -> @pat {
        my @c = %wh{@pat[0]}.List;
        for (1..@pat.elems()-1) -> $i {
            @c = @c X %wh{@pat[$i]}.List;
        }
        for @c -> @ww {
            @out.push(@ww.join(''));
        }
    }
    return @out;
}
