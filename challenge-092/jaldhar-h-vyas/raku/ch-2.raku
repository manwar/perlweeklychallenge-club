#!/usr/bin/raku

sub toArray(Str $arg) {
    $arg ~~ m/ \( (\d+) \, (\d+) \) /;
    return [$0.Int, $1.Int];
}

sub MAIN(
    *@S #= A set of sorted non-overlapping intervals enclosed in
        #= parentheses and separated by commas. The last pair will
        #= be merged into the rest.
    where { @S.elems > 1 }
) {
    my @intervals = @S.map( { toArray($_) } ).sort({@^a[0] <=> @^b[0]});

    my $size = @intervals.elems;
    my @merged;

    loop (my $i = 0; $i < $size; $i++) {
        my $start = @intervals[$i][0];
        my $end = @intervals[$i][1];

        while $i < $size - 1 && $end ~~ @intervals[$i + 1].minmax {
            $end = @intervals[$i + 1][1];
            $i++;
        }

        push @merged, [$start, $end];
    }

    @merged.map({ "[$_[0],$_[1]]"; }).join(q{, }).say;
}