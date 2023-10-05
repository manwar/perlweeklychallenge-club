#!/usr/bin/raku

sub MAIN(
    *@nums
) {
    my $maxGreatness = 0;

    for @nums.permutations -> $perm {
        my $greatness =  (@nums Z @$perm).grep({ @$_[0] < @$_[1 ]}).elems;
        if $greatness > $maxGreatness {
            $maxGreatness = $greatness;
        }
    }

    say $maxGreatness;
}