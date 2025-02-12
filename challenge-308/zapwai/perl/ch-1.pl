use v5.38;

sub proc($s1, $s2) {
    my @str1 = @$s1;
    my @str2 = @$s2;
    say "Input: \@str1 = @str1, \@str2 = @str2";
    my $cnt = 0;
    for my $w1 (@str1) {
	for my $w2 (@str2) {
	    if ($w1 eq $w2) {
		$cnt++;
	    }
	}
    }
    say "Output: $cnt";
}

my @str1 = ("perl", "weekly", "challenge");
my @str2 = ("raku", "weekly", "challenge");
proc(\@str1, \@str2);

@str1 = ("perl", "raku", "python");
@str2 = ("python", "java");
proc(\@str1, \@str2);

@str1 = ("guest", "contribution");
@str2 = ("fun", "weekly", "challenge");
proc(\@str1, \@str2);
