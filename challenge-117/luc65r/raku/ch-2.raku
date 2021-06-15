#!/usr/bin/env raku

enum Move <H L R>;

class Node {
    also is Hash[Node, Move:D];

    method dirs(Node:D: --> Iterable) {
        gather {
            for self.kv -> $k, $v {
                with $v {
                    my @d = .dirs;
                    take $k ~ $_ for @d ?? @d !! '';
                }
            }
        }
    }
}

sub MAIN(UInt:D $size) {
    my $top = construct-triangle($size);
    .say for $top.dirs;
}

sub construct-triangle(UInt:D $size --> Node) {
    my Node @line;
    for $size … 0 -> $j {
        for 0 .. $j -> $i {
            @line[$i] = Node.new(
                (H) => try { @line[$i - 1] },
                (L) => @line[$i + 1],
                (R) => @line[$i],
            );
        }
    }
    @line[0]
}
