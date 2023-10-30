#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my %seen;
    my $loops = 1;
    my $current = 0;

    while %seen.keys.elems != @ints.elems {
        if %seen{$current}:exists {
            $loops++;

            for 0 .. @ints.end -> $i {
                if %seen{$i}:!exists {
                    $current = $i;
                    last;
                }
            }
        }

        %seen{$current} = True;
        $current = @ints[$current];
    }

    say $loops;
}