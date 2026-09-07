#!/usr/bin/raku

sub MAIN(
    $composer,
    $notes,
    $permutation
) {
    my %reorder = $permutation.words Z=> $notes.words;
    say $composer.uc, ' => ',
        %reorder.keys.sort({ $^a <=> $^b }).map({ %reorder{$_} }).join(q{ }); 
}
