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

    # my implementation
    method _show-link() {
        my $c = $!c;
        my @v = $!v;

        while defined $c {
            @v.push: $c.v;
            $c = $c.c;
        }

        return @v.join(' -> ');
    }

    # contributed by Moritz Lenz
    method show-link() {
        return join ' -> ', (self, *.c ...^ !*.defined).map: *.v;
    }
}

sub MAIN(Str :$linked-list = '1 -> 2 -> 3 -> 4 -> 5') {
    reorder-list($linked-list).show-link.say;
}

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
        my $node = @link.pop;
        @link.splice($i, 0, $node);

        # remove child from the last node
        @link.tail.c = Nil;

        # link new node to previous node
        @link[$i - 1].c = $node;

        # make the next node as child of new node
        $node.c = @link[$i + 1];

        $i += 2;
    }

    return $head;
}
