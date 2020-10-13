#!/bin/env raku

sub MAIN(Str:D $A, Str:D $B) {
    my @answers;

    my $lena = $A.chars;
    my $lenb = $B.chars;
    my $lenc = $lena gcd $lenb;

    my Str $c = $A.substr(0, $lenc);
    @answers.push($c) if $c x ($lena / $lenc) eq $A and $c x ($lenb / $lenc) eq $B;

    for (1..$lenc/2).grep({ $lenc %% $_ }) -> $i {
        my Str $d = $c.substr(0, $i);
        @answers.push($d) if $d x ($lenc / $i) eq $c;
    }

    say @answers;
}
