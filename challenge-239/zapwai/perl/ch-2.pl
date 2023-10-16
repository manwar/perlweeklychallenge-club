use v5.30;
my @str = ("ad", "bd", "aaab", "baa", "badab");
my $allowed = "ab";
# @str = ("a", "b", "c", "ab", "ac", "bc", "abc");
# my $allowed = "abc";
# @str = ("cc", "acd", "b", "ba", "bac", "bad", "ac", "d");
# my $allowed = "cad";
my $count = 0;
my @good = split "", $allowed;
foreach my $word (@str) {
    my @let = split "", $word;
    my $cnt = 0;
  letter: foreach my $l (@let) {
	foreach my $g (@good) {
	    if ($l eq $g) {
		$cnt++;
		next letter;
	    }
	}
    }
    $count++ if ($cnt == $#let + 1);
}
say "Input:  \@str = (" . join(",",@str).")\n\t\$allowed = $allowed";
say "Output: $count";
