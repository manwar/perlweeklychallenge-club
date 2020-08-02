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

use Test;

my Str $list   = '1 -> 2 -> 3 -> 4 -> 5';
my %test-cases = (
    'testing $N = 1' => { n => 1, o => '1 -> 2 -> 3 -> 4' },
    'testing $N = 2' => { n => 2, o => '1 -> 2 -> 3 -> 5' },
    'testing $N = 3' => { n => 3, o => '1 -> 2 -> 4 -> 5' },
    'testing $N = 4' => { n => 4, o => '1 -> 3 -> 4 -> 5' },
    'testing $N = 5' => { n => 5, o => '2 -> 3 -> 4 -> 5' },
    'testing $N = 6' => { n => 6, o => '2 -> 3 -> 4 -> 5' },
);

for %test-cases.keys.sort -> $test {
    is(
        create-linked-list($list).trim(%test-cases{$test}{"n"}).show,
        %test-cases{$test}{"o"},
        $test
    );
}

done-testing;

#
#
# METHOD

sub create-linked-list(Str $list is copy) {

    $list ~~ s:g/\s//;
    my @list = $list.split('->');
    my $node = Node.new(v => @list.pop.Int);
    my $tail = $node;

    while @list {
        my $node = Node.new(v => @list.pop.Int);
        $tail.p = $node;
        $tail = $node;
    }

    return $node;
}
