#!/usr/bin/raku

sub MAIN(
    *@words
) {
    my %groups;

    for @words -> $word {
        my @ords = $word.comb.map({ .ord });
        my @difference;

        for 1 .. @ords.end -> $i {
            @difference.push(@ords[$i] - @ords[$i - 1]);
        }

        my $signature = @difference.join(q{,});
        %groups{$signature} //= [];
        %groups{$signature}.push($word);
    }

    for %groups.values -> @group {
        if @group.elems == 1 {
            say @group[0];
            last;
        }
    }
}
