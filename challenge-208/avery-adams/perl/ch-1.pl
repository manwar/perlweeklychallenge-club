use strict;
use v5.10;

my @list1 = ("Perl", "Raku", "Love");
my @list2 = ("Raku", "Perl", "Hate");

# my @list1 = ("A", "B", "C");
# my @list2 = ("D", "E", "F");

# my @list1 = ("A", "B", "C");
# my @list2 = ("C", "A", "B");

my $minindex;
my @results;
for (my $index1 = 0; $index1 < scalar @list1; $index1++) {
    for (my $index2 = 0; $index2 < scalar @list2; $index2++) {
        if ($list1[$index1] eq $list2[$index2] && defined($minindex)) {
            if ($index1 + $index2 < $minindex) {
                @results = ($list1[$index1]);
                $minindex = $index1 + $index2;
            } elsif ($index1 + $index2 == $minindex) {
                push (@results, $list1[$index1]);
            }
        } elsif ($list1[$index1] eq $list2[$index2] && !defined($minindex)) {
            @results = ($list1[$index1]);
            $minindex = $index1 + $index2;
        }
    }
}
if (scalar @results == 0) {exit}
foreach (@results) {
    say $_;
}