#!/usr/bin/env perl6

use Test;

is cmp-version('0.1',   '1.1'),   -1, '0.1   cmp 1.1';
is cmp-version('2.0',   '1.2'),    1, '2.0   cmp 1.2';
is cmp-version('1.2',   '1.2_5'), -1, '1.2   cmp 1.2_5';
is cmp-version('1.2.2', '1.2_1'),  1, '1.2.2 cmp 1.2_1';
is cmp-version('1.2_1', '1.2_1'),  0, '1.2_1 cmp 1.2_1';
is cmp-version('1.2.1', '1.2.1'),  0, '1.2.1 cmp 1.2.1';

done-testing;

sub cmp-version(Str $v1, Str $v2) {

    # Short circuit, good idea?
    return 0 if ($v1 eq $v2);

    my @v1 = $v1.split(".");
    my @v2 = $v2.split(".");

    my $max = @v1.elems > @v2.elems ?? @v1.elems !! @v2.elems;
    my $i = 0;

    my $v1_alpha;
    my $v2_alpha;

    while $i < $max {
        @v1[$i] = 0 unless defined @v1[$i];
        @v2[$i] = 0 unless defined @v2[$i];

        if @v1[$i] ~~ / <[_]> / {
            (@v1[$i], $v1_alpha) = @v1[$i].split("_");
        }
        if @v2[$i] ~~ / <[_]> / {
            (@v2[$i], $v2_alpha) = @v2[$i].split("_");
        }

        if defined @v1[$i] && defined @v2[$i] {
            if @v1[$i] > @v2[$i] {
                return 1;
            }
            elsif @v1[$i] < @v2[$i] {
                return -1;
            }
        }

        $i++;
    }

    if defined $v1_alpha && defined $v2_alpha {
        if $v1_alpha > $v2_alpha {
            return 1;
        }
        elsif $v1_alpha < $v2_alpha {
            return -1;
        }
    }
    else {
        if defined $v1_alpha {
            return 1;
        }
        if defined $v2_alpha {
            return -1;
        }
    }

    return 0;
}
