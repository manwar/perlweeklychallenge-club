#!/usr/bin/env raku

# ch-1.raku - Bitwise Sum
#
# 2021 Ryan Thompson <rjt@cpan.org>

#| Calcuate bitwise AND unique pairs and sum the results
#  XXX - prefix: operators currently extend compile time.
sub prefix:<⊕>(*@n) {
    [+] @n.combinations(2).map({ [+&] $_ });
}

sub MAIN ( *@n where +* #={ List of integers } ) { 
    say ⊕ @n;
}
