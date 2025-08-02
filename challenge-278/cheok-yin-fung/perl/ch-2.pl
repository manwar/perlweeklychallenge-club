# The Weekly Challenge 278
# Task 2 Reverse Word
use v5.30.0;
use warnings;

sub re_word {
    my $str = $_[0];
    my $chr = $_[1];
    my $ind = index($str, $chr);
    if ($ind > -1) {
        my $first = substr($str, 0, $ind+1);
        my $second = substr($str, $ind+1);
        my $nstr = (join "", sort {$a cmp $b} split "", $first). $second;
        return $nstr;
    }
    else {
        return $str;
    }
}

use Test::More tests=>3;
ok re_word("challenge", "e") eq "acehllnge";
ok re_word("programming", "a") eq "agoprrmming";
ok re_word("champion", "b") eq "champion";
