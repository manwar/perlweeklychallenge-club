#!/usr/bin/perl6

sub MAIN(*$A, *$B) {
    my ($smaller, $larger) = $A.chars < $B.chars ?? ($A, $B) !! ($B, $A);
    my @base_strings;

    for 1 .. $smaller.chars -> $c {
        if  ($larger.chars %% $c) {
            my $l = $larger;
            my $s = $smaller.substr(0, $c);
            $l ~~ s:g/ $s //;
            if ($l eq q{}) {
                @base_strings.push($s);
            }
        }
    }

    say sort @base_strings;
}