use v5.30.0;
my @list1 = ("Perl", "Raku", "Love");
my @list2 = ("Raku", "Perl", "Hate");

#my @list1 = ("A", "B", "C");
#my @list2 = ("C", "A", "B");

#my @list1 = ("A", "B", "C");
#my @list2 = ("D", "e", "f");

my (@match, @ind1, @ind2);
for my $i (0 .. $#list1) {
    for my $j (0 .. $#list2) {
	if ($list1[$i] eq $list2[$j]) {
	    push @match, $list1[$i];
	    push @ind1, $i;
	    push @ind2, $j;
	}
    }
}

say "Input:  \@list1 = (".join(", ",@list1).")";
say "\t\@list2 = (".join(", ",@list2).")";
say "Output: (".join(", ",@match).")";

say "There are ".($#match + 1)." common strings: @match";
for my $i (0 .. $#match) {
    say "Index sum of " . $match[$i] . ": $ind1[$i] + $ind2[$i] = ". ($ind1[$i] + $ind2[$i]);
}
