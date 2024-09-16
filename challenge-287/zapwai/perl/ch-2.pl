use v5.38;
my $str = "1";
proc($str);
$str = "56e10";
proc($str);
$str = "2E32";
proc($str);
$str = "a";
proc($str);
$str = "1.2";
proc($str);
$str = "1.2.6";
proc($str);
$str = "3.142e10";
proc($str);
$str = "3.142e42B";
proc($str);

sub proc($str) {
    say "Input: $str";
    my $output = "False";
    my @p = split /\./, $str;
    if (@p == 1) {
	if ($str =~ /^\d+$/) {
	    $output = "True";
	} elsif ($str =~ /^\d+e|E\d+$/) {
	    $output = "True";
	}
    } elsif (@p == 2) {
	if ($p[0] =~ /^\d+$/ && $p[1] =~ /^\d+$/) {
	    $output = "True";
	} elsif ($p[0] =~ /^\d+$/ && $p[1] =~ /^\d+e\d+$|E\d+$/) {
	    $output = "True";
	}
    }
    say "Output: $output\n";
}
