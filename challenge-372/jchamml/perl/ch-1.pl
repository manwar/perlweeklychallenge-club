#Write a script to rearrange the spaces so that there is an equal number of
#spaces between every pair of adjacent words and that number is maximised. If
#you can’t distribute, place the extra spaces at the end. Finally return the
#string.
use strict;
use warnings;

sub rearrange($) {
    my $wordcount;
    my $string = $_[0];
    my @words = split(' ',$string);
    my $spaceCount = $string =~ s/\s//g ;
    my $wordGaps = (@words-1);
    my $spacesBetween = ($wordGaps == 0) ? 0 : int($spaceCount/$wordGaps);
    my $spacesAfter = $spaceCount - $spacesBetween * $wordGaps;
    return join (' ' x $spacesBetween, @words) . (' ' x $spacesAfter);
}

for my $str ("  challenge  ", "coding  is  fun", "a b c  d", "  team      pwc  ", "   the  weekly  challenge  "){
    my $reString = rearrange($str);
    print "\"$str\" becomes \"$reString\"\n";
}
