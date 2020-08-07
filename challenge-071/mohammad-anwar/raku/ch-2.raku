#!/usr/bin/env raku

#
# Perl Weekly Challenge - 071
#
# Task #2: Trim Linked List
#
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-071/
#

class Node {
    has Int  $.v is rw;
    has Node $.p is rw;

    method trim(Int $position) {

        die "ERROR: Invalid position [$position].\n"
            unless $position ~~ /^\d+$/;

        my $tail  = self;
        my $count = 1;
        my $node;

        while $tail.p {
            if $position > $count {
                $node = $tail;
            }
            elsif $position == $count {
                if $node.defined {
                    # Remove current node by making the
                    # parent of  current node as parent
                    # of previous node
                    $node.p = $tail.p;
                }
                else {
                    # If you're taking first from the end
                    # then return the parent of last node
                    return $tail.p;
                }
            }

            $tail = $tail.p;
            $count++;
        }

        # Take the first node off if and only if:
        # a) you reached the first node or
        # b) given position is more than the total nodes
        $node.p = Nil if $count <= $position;

        return self;
    }

    method show() {
        my $p = $!p;
        my @v = $!v;

        while defined $p {
            @v.push: $p.v;
            $p = $p.p;
        }

        return @v.reverse.join(' -> ');
    }
}

sub MAIN(Str :$list = '1 -> 2 -> 3 -> 4 -> 5', Int :$position = 2) {
    create-linked-list($list).trim($position).show.say;
}

sub create-linked-list(Str $list is copy) {

    $list ~~ s:g/\s//;
    my @list = $list.split('->');
    my $node = Node.new(v => @list.pop.Int);
    my $tail = $node;

    while @list {
        my $_node = Node.new(v => @list.pop.Int);
        $tail.p = $_node;
        $tail = $_node;
    }

    $node.show.say;

    return $node;
}
