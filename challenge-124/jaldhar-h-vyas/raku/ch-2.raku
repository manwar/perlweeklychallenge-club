#!/usr/bin/raku

sub MAIN(
    *@n     #= a list of integers
) {
    my $part1 = @n.elems div 2;
    my $part2 = @n.elems - $part1;
    my (@best1, @best2);
    my $bestdiff = Inf;

    for @n.permutations -> @perm {
        my @subset1 = @perm[0 .. $part1 - 1];
        my @subset2 = @perm[$part2 - 1 .. *];
        my $total1 = [+] @subset1;
        my $total2 = [+] @subset2;
        my $diff =  abs($total1 - $total2);
        if $diff < $bestdiff {
            $bestdiff = $diff;
            @best1 = @subset1;
            @best2 = @subset2;
            if $bestdiff == 0 {
                last;
            }
        }
    }

    say "Subset 1 = (", @best1.sort.join(q{, }), q{)};
    say "Subset 2 = (", @best2.sort.join(q{, }), q{)};
}

