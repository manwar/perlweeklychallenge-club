use v5.36;
my $file = "/usr/share/dict/words";
open my $fh, "<", $file or die;
my @file = <$fh>;
close $fh;
chomp @file;
my @arr;
foreach my $word (@file) {
    $word = lc $word;
    my @let = split "", $word;
    push @arr, join("", sort @let);
}
my @dict =  sort @arr;
my ($maxlen, $maxword) = (0, "");
my $flag = 0;
my $cnt = 0;
for my $i (0 .. $#dict) {
    if (length $dict[$i] < 4) {
	next;
    }
    if ($flag == 1) {
	if (!($dict[$i+1] eq $dict[$i])) {
	    $flag = 0;
	    $cnt++;
	    if ($maxlen < $cnt) {
		$maxlen = $cnt;
		$maxword = $dict[$i];
	    }
	    $cnt = 0;
	} else {
	    $cnt++;
	}
    } else {
	if ($dict[$i+1] eq $dict[$i]) {
	    $flag = 1;
	    $cnt++;
	}
    }
}
say "num of anagrams: $maxlen, using letters: $maxword";
system("perl ch-1.pl $maxword");
