#Write a script to return the length of the largest substring between two equal
#characters excluding the two characters. Return -1 if there is no such
#substring.

use strict;
use warnings;

sub subx($) {
    my $string = $_[0];
    my $lengt;
    my $long=0;
    my $longest;
    for (split //,$string) {
        $string=~m/$_(.*)$_/ ;
        $lengt = defined $1 ? length($1) : 0 ;
        $long = $long>$lengt ? $long : $lengt;
        $longest = $long>$lengt ? $longest : $1;
    }
    return $long==0 ? 0 : $longest;
}

for my $s ("aaaaa", "abcdeba", "abbc", "abcaacbc", "laptop") {
    my $ss=subx($s);
    print "longest substring between two equal characters in \"$s\" is \"$ss\"\n";
}
