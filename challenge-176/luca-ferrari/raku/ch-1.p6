#!raku

# Perl Weekly Challenge 176

sub MAIN() {

    for 1 .. Inf -> $current {
        my @values = (1 .. 6).map: { $current * $_ };
        # compute the permutations of the current number
        my @permutations = $current.comb.permutations.map: *.join.Int;

        my $found = 0;
        for @values {
            $found++ if $_ == any(@permutations);
        }

        $current.say and last if $found == @values.elems;
    }
}
