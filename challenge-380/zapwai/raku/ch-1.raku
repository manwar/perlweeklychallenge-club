use v6;

sub proc($s) {
    say "Input: \"$s\"";
    my @V = ($s.comb).grep({$_ ~~ /<[aeiou]>/});
    my @C = ($s.comb).grep({$_ !~~ /<[aeiou]>/});
    my %v = @V.Bag;			#vowel hash
    my %c = @C.Bag;			#consonant hash
    my ($vowel_max, $cons_max) = ((0, values(%v)).max, (0,values(%c)).max);
    say "Output: ", $vowel_max + $cons_max;
}

my $s = "banana";
proc($s);
$s = "teestett";
proc($s);
$s = "aeiouuaa";
proc($s);
$s = "rhythm";
proc($s);
$s = "x";
proc($s);
