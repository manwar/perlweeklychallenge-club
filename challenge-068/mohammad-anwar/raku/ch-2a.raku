#!/usr/bin/env raku

#
# Perl Weekly Challenge - 068
#
# Task #2: Reorder List
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-068
#

class Node {
    has Int  $.v is rw;
    has Node $.c is rw;

    method show-link() {
        my $c = $!c;
        my @v = $!v;

        while defined $c {
            @v.push: $c.v;
            $c = $c.c;
        }

        return @v.join(' -> ');
    }
}

use Test;

is reorder-list('1 -> 2 -> 3 -> 4').show-link,
   '1 -> 4 -> 2 -> 3',
   'testing 1 -> 2 -> 3 -> 4';
is reorder-list('1 -> 2 -> 3 -> 4 -> 5').show-link,
   '1 -> 5 -> 2 -> 4 -> 3',
   'testing 1 -> 2 -> 3 -> 4 -> 5';
is reorder-list('1 -> 2 -> 3 -> 4 -> 5 -> 6').show-link,
   '1 -> 6 -> 2 -> 5 -> 3 -> 4',
   'testing 1 -> 2 -> 3 -> 4 -> 5 -> 6';

done-testing;

sub reorder-list(Str $linked-list is copy) {

    $linked-list ~~ s:g/\s//;
    my @list = $linked-list.split('->');
    my $head = Node.new(v => @list.shift.Int);
    my @link = $head;

    # prepare singly linked list
    for @list -> $v {
        my $node = Node.new(v => $v.Int);
        @link.tail.c = $node;
        @link.push: $node;
    }

    # reorder linked list
    my Int $min = 0;
    my Int $max = (@list.elems/ 2).Int;
    my Int $i   = 1;
    for $min .. $max-1 {
        my $last = @link.pop;
        @link.splice($i, 0, $last);
        @link.tail.c    = Node;
        @link[$i - 1].c = $last;
        @link[$i].c     = @link[$i + 1];
        $i += 2;
    }

    return $head;
}
