use v5.30.0;
my @words = qw( Hello Alaska Dad Peace );
#my @words = qw( OMG bye );
my $str1 = 'qwertyuiop';
my $str2 = 'asdfghjkl';
my $str3 = 'zxcvbnm';
my @onerows;
for my $word (@words) {
    if (tally(lc $word) != 0) {
	push @onerows, $word;
    }
}
sub tally {
    my $word = shift;
    my ($t1, $t2, $t3);
    foreach (split("",$word)) {
	$t1++ if ($str1 =~ $_) ;
	$t2++ if ($str2 =~ $_) ;
	$t3++ if ($str3 =~ $_) ;    
    }
    return 1 if ($t1 == length $word);
    return 2 if ($t2 == length $word);
    return 3 if ($t3 == length $word);
    0
}
say "Input: \@words = (".join(", ",@words).")";
say "Output: (".join(", ",@onerows).")";
