#!/usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

use JSON 'decode_json';
use List::MoreUtils 'first_index';

sub find_index( $lst, $val ) {
    # Find the position of val in lst. If it does not appear, return the
    #  length of the list
    my $idx = first_index { $_ == $val } @$lst;
    return $idx == -1 ? scalar(@$lst) : $idx;
}

sub main ($lists) {
    my $list1 = $lists->[0];
    my $list2 = $lists->[1];

   # Sort the first list, in the order they appear in the second list. If
   # it doesn't appear in the second list, append to the end in numerical order.
    my @solution = sort {
        find_index( $list2, $a ) <=> find_index( $list2, $b )
          or $a <=> $b
    } @$list1;
    say '(', join( ', ', @solution ), ')';
}

main( decode_json( $ARGV[0] ) );