#! /usr/bin/perl
use warnings;
use strict;

sub _partition {
    my ($string) = @_;
    my @p;
    for my $pos (1 .. 3) {
        next if $pos > length $string;

        my $prefix = substr $string, 0, $pos;
        next if $prefix > 255 || (
            1 < length $prefix 
            && 0 == index $prefix, '0');

        if ($pos == length $string) {
            push @p, [$prefix];
        } else {
            push @p, grep @$_ <= 4,
                     map [$prefix, @$_],
                     _partition(substr $string, $pos);
        }
    }
    return @p
}

sub partition {
    my ($string) = @_;
    [ map { join '.', @$_ } grep 4 == @$_, _partition($string) ]
}

use Test::More;
use Test::Deep;

cmp_deeply partition('25525511135'),
           bag(qw( 255.255.11.135 255.255.111.35 ));

cmp_deeply partition('1234'), bag(qw( 1.2.3.4 ));
cmp_deeply partition('123405'),
           bag(qw( 1.23.40.5 1.234.0.5 12.3.40.5 12.34.0.5 123.4.0.5 ));

done_testing();
