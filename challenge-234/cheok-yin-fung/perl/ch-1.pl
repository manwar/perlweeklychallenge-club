# The Weekly Challenge 234
# Task 1 Common Characters

use v5.30.0;
use warnings;

sub cc {
    my @words = @_;

#   my @s_words = map {join "", sort {$a cmp $b} split "", $_} @words;
#   #Then may use longest common subsequence algorithm.

    my %occurence;
    for my $alphabet ('a'..'z', 'A'..'Z' ) {
        $occurence{$alphabet} = grep {$alphabet eq $_} split "", $words[0];
        for my $word (@words[1..$#words]) {
            my $temp = grep {$alphabet eq $_} split "", $word;
            if ($occurence{$alphabet} > $temp) {
                $occurence{$alphabet} = $temp;
            }
        }
    }
    my $final_str = "";
    for my $alphabet ('a'..'z', 'A'..'Z' ) {
        $final_str .= $alphabet x $occurence{$alphabet};
    }
    return [split "", $final_str];
}

say join " ", cc("java", "javascript", "julia")->@*;      # a, j
say join " ", cc("bella", "label", "roller")->@*;         # e, l, l
say join " ", cc("cool", "lock", "cook")->@*;             # c, o

