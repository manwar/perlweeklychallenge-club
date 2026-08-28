#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

use List::Util qw{ uniq };

sub dyck_words($n) {
    my @words = ("");
    for (1 .. $n) {
        my @new = map "UD$_", @words;
        for my $word (@words) {
            my $pos = 0;
            while (-1 != ($pos = index $word, 'D', $pos + 1)) {
                my $new = $word;
                substr $new, $pos, 0, 'UD';
                push @new, $new;
            }
        }
        @words = @new;
    }
    return sort +uniq(@words)
}

use Test::More tests => 5;


is_deeply [dyck_words(1)], ['UD'], 'Example 1';
is_deeply [dyck_words(2)], ['UDUD','UUDD'], 'Example 2';
is_deeply [dyck_words(3)], ['UDUDUD', 'UDUUDD', 'UUDDUD', 'UUDUDD', 'UUUDDD'],
    'Example 3';
is_deeply [dyck_words(0)], [""], 'Example 4';

is_deeply [dyck_words(4)], ['UDUDUDUD', 'UDUDUUDD', 'UDUUDDUD', 'UDUUDUDD',
                            'UDUUUDDD', 'UUDDUDUD', 'UUDDUUDD', 'UUDUDDUD',
                            'UUDUDUDD', 'UUDUUDDD', 'UUUDDDUD', 'UUUDDUDD',
                            'UUUDUDDD', 'UUUUDDDD'],
    'Example 5';
