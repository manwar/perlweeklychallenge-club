#!/usr/bin/raku

sub MAIN(
    $arr1,
    $arr2
) {
    my @merged = "$arr1 $arr2".words.sort({$^a <=> $^b});
    my $len = @merged.elems;

    if $len %% 2 {
        my $mid = $len / 2;
        say (@merged[$mid] + @merged[$mid - 1]) / 2;
    } else {
        say @merged[$len / 2];
    }
}
