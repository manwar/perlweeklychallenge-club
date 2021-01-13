#!/usr/bin/perl
use warnings;
use strict;

sub extend {
    my ($length, $short, $long) = @_;
    my %next;
    @next{@$short} = ();
    for my $i (0 .. $#$short) {
        for my $j (0 .. $#$short) {
            my $new = 0 + ($short->[$i] . $short->[$j]);
            next if $length < length $new;
            if (length($new) < $length) {
                undef $next{$new};
            } else {
                undef $long->{$new};
            }
        }
    }
    return keys %$long if @$short == keys %next;

    return extend($length, [keys %next], $long)
}

sub find {
    my ($length, $greater, @list) = @_;
    my @long = grep $length == length $_, @list;
    my %long; @long{@long} = ();
    return grep $greater > $_,
           extend($length, \@list, \%long);
}

use Test::More;
use Test::Deep;

cmp_deeply [ find(2, 21, 0, 1, 2, 5) ],
           bag(10, 11, 12, 15, 20);

cmp_deeply [ find(4, 3111, 1, 2, 3) ],
           bag(glob '{{1,2}{1,2,3}}{{1,2,3}{1,2,3}}');

cmp_deeply [ find(5, 20000, 0, 1) ],
           bag(glob '1{0,1}{0,1}{0,1}{0,1}');

cmp_deeply [ find(3, 222, 2) ],
           [];

cmp_deeply [ find(10, 2000000022, 0, 2) ],
           bag(2000000000, 2000000002, 2000000020);

cmp_deeply [ find(5, 30000, 1, 20, 300) ],
           bag(11111, 11120, 11201, 11300, 12011, 12020,
               13001, 20111, 20120, 20201, 20300);

cmp_deeply [ find(3, 789, 123, 456, 1000) ],
           bag(123, 456);

done_testing();
