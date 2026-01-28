use v5.38;
use List::Util "max";

sub proc(@strings) {
    say "Input: @strings";
    my @val;
    for my $chunk (@strings) {
	if ($chunk =~ /[a-zA-Z]/) {
	    push @val, length($chunk);
	} else {
	    push @val, $chunk;
	}
    }
    say "@val";
    say "Output: ", max(@val);
}

my @strings = ("123", "45", "6");
proc(@strings);
@strings = ("abc", "de", "fghi");
proc(@strings);
@strings = ("0012", "99", "a1b2c");
proc(@strings);
@strings = ("x", "10", "xyz", "007");
proc(@strings);
@strings = ("hello123", "2026", "perl");
proc(@strings);
