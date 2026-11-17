#!/usr/bin/env raku

use Test;

my @examples = (
    {
        in  => ["AACCGGTT","AACCGGTA",
                "AACCGCTA","AAACGGTA"],
        out => -1,
    },
    {
        in  => ["AACCGGTT","AACCGGAA",
                "AACCGGTA","AACCGGAA","AACCGCTA","AACCCTAA","AACCGTAA"],
        out => 2,
    },
    {
        in  => ["AAAAAAAA","AAAAACCC",
                "CAAAAAAA","CCAAAAAA","AAAAAAAC"],
        out => -1,
    },
    {
        in  => ["GAAAAAAA","GCCCCCCC",
                "GCAAAAAA","GCCAAAAA","GCCCAAAA","GCCCCAAA","GCCCCCAA","GCCCCCCA","GCCCCCCC"],
        out => 7,
    },
    {
        in  => ["AACCGGTT","AACCGGTT",
                "AACCGGTA"],
        out => 0,
    },
);

is min-mutation(|$_<in>), $_<out> for @examples;

done-testing;

sub min-mutation($start, $end, *@bank) {
    return 0 if $start eq $end;

    my %bank = map { $_ => True }, @bank;
    return -1 unless %bank{$end};

    my @queue;
    @queue.push([$start, 0]);

    my %visited;
    %visited{$start} = True;

    while @queue {
        my $item  = @queue.shift;
        my $curr  = $item[0];
        my $steps = $item[1];

        return $steps if $curr eq $end;

        for 0 .. $curr.chars - 1 -> $i {
            my $orig = $curr.substr($i, 1);
            for <A C G T> -> $c {
                next if $c eq $orig;
                my $next = $curr;
                $next.substr-rw($i, 1) = $c;

                if %bank{$next} && not %visited{$next}:exists {
                    %visited{$next} = True;
                    @queue.push([$next, $steps + 1]);
                }
            }
        }
    }
    return -1;
}
