use v5.38;
use List::Util "uniq";

sub proc(@words) {
    say "Input: \@words = @words";
    my @ans;
    for my $i ( 0 .. $#words ) {
	my $word = $words[$i];
	for my $j (0 .. $#words) {
	    next if ($i == $j);
	    my $str = $words[$j];
	    if ($str =~ /$word/) {
		push @ans, $word;
		last;
	    }
	}
    }
    @ans = uniq(@ans);
    say "Output: @ans";
}

my @words = ("cat", "cats", "dog", "dogcat", "dogcat", "rat", "ratcatdogcat");
proc(@words);
@words = ("hello", "hell", "world", "wor", "ellow", "elloworld");
proc(@words);
@words = ("a", "aa", "aaa", "aaaa");
proc(@words);
@words = ("flower", "flow", "flight", "fl", "fli", "ig", "ght");
proc(@words);
@words = ("car", "carpet", "carpenter", "pet", "enter", "pen", "pent");
proc(@words);
