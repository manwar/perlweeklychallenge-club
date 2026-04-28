#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub missing_letter(@seq) {
    my %diff;
    my $qi = (grep '?' eq $seq[$_], 0 .. $#seq)[0];

    my @n = map ord, @seq;
    $_ != $qi && $_ - 1 != $qi and ++$diff{ $n[$_] - $n[ $_ - 1 ] }
        for 1 .. $#n;

    if (2 == keys %diff) {
        my $di = $qi + ($qi >= 2 ? - 2 : 1 + $qi % 2);
        delete $diff{ $n[ $di + 1 ] - $n[$di] };
    }

    return chr($qi == 0 ? $n[1] - (keys %diff)[0]
                        : $n[ $qi - 1 ] + (keys %diff)[0])
}

use Test::More tests => 5 + 8;


is missing_letter(qw( a c ? g i )), 'e', 'Example 1';
is missing_letter(qw( a d ? j m )), 'g', 'Example 2';
is missing_letter(qw( a e ? m q )), 'i', 'Example 3';
is missing_letter(qw( a c f ? k )), 'h', 'Example 4';
is missing_letter(qw( b e g ? l )), 'j', 'Example 5';

is missing_letter(qw( ? c e g i )), 'a', 'Beginning constant';
is missing_letter(qw( a ? e g i )), 'c', 'Second constant';
is missing_letter(qw( a c e ? i )), 'g', 'Fourth constant';
is missing_letter(qw( a c e g ? )), 'i', 'End constant';
is missing_letter(qw( ? c f h k )), 'a', 'Beginning alternating';
is missing_letter(qw( a ? f h k )), 'c', 'Second alternating';
is missing_letter(qw( a c ? h k )), 'f', 'Fourth alternating';
is missing_letter(qw( a c f h ? )), 'k', 'End alternating';
