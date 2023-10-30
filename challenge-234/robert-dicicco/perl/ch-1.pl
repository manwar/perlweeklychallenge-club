#!/usr/bin/env perl
=begin comment
------------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-09-13
Challenge 234 Task 1 Common Characters ( Perl )
------------------------------------------------
=cut
use v5.38;

my @wordlist = (["java", "javascript", "julia"],["bella", "label", "roller"],["cool", "lock", "cook"]);

for my $wds ( @wordlist) {
    my $wordnum = scalar @$wds;
    say "wordnum = $wordnum";
    my %seen = ();
    my $charlist = "";
    say "Input: \@words = (@$wds)";
    my $cnt = 0;
    while($cnt < 3) {
        $charlist .= @$wds[$cnt];
        $cnt++;
    }
    my @arr = split("",$charlist);
    for my $c ( @arr) {
        $seen{$c} += 1;
    }
    print "Output: (";
    for my $key (keys %seen) {
        if ($seen{$key} == ($wordnum * 2)) {
            print "$key $key ";
        } elsif (( $seen{$key} >= $wordnum) && ( $seen{$key} < ($wordnum * 2))) {
            print "$key ";
        }
    }
    print ")\n\n";
}

=begin comment
------------------------------------------------
SAMPLE OUTPUT
perl .\CommonCharacters.pl

wordnum = 3
Input: @words = (java javascript julia)
Output: (a j )

wordnum = 3
Input: @words = (bella label roller)
Output: (e l l )

wordnum = 3
Input: @words = (cool lock cook)
Output: (o c )
------------------------------------------------
=cut


