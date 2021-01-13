#!/usr/bin/perl6

sub collatzSequence(Int $n) {
    return ($n, { ($_ % 2) ?? (3 * $_ + 1) !! ($_ / 2) } ... 1);
}

multi sub MAIN() {
    my $maxlength = 0;
    my @longest = ();

    for 1 .. 1e6 -> $n {
        my $length = collatzSequence($n).elems;

        if $length >= $maxlength {
            $maxlength = (@longest.elems) ?? @longest[*-1][1] !! $length;
            @longest.push([$n, $length]);

            @longest = @longest.sort({ $^b[1] <=> $^a[1] });
            if (@longest.elems > 20) {
                @longest.pop;
            } 
        }
    }

    for @longest -> @long {
        say @long[0], ': ', @long[1];
    }
}
