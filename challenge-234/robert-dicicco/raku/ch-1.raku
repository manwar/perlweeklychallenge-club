#!/usr/bin/env raku
=begin comment
------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-13
Challenge 234 Task 1 Common Characters ( Raku )
------------------------------------------------
=end comment

use v6;

my @wordlist = (["java", "javascript", "julia"],["bella", "label", "roller"],["cool", "lock", "cook"]);

for (@wordlist) -> @wds {
    my $wordnum = @wds.elems;
    my %seen = ();
    my $charlist = "";
    say "Input: \@words = ",@wds;
    my $cnt = 0;
    while $cnt < 3 {
        $charlist ~= @wds[$cnt];
        $cnt++;
    }
    my @arr = split("",$charlist);
    for ( @arr) -> $c {
        %seen{$c} += 1;
    }

    print "Output: (";
    for %seen.keys -> $k {
        if $k ne ' ' {
            if %seen{$k} >= $wordnum && %seen{$k} < (2 * $wordnum) {
                print "$k ";
            } elsif %seen{$k} == (2 * $wordnum) {
                print "$k $k "
            }
        }
    }
    print ")\n\n";
}

=begin comment
------------------------------------------------
SAMPLE OUTPUT
raku .\CommonCharacters.rk
Input: @words = [java javascript julia]
Output: (a j )

Input: @words = [bella label roller]
Output: (e l l )

Input: @words = [cool lock cook]
Output: (o c )
------------------------------------------------
=end comment


