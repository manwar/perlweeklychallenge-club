use v5.38;

sub is_valid($s) {
    my $hyphen_count = grep {$_ eq '-'} (split '', $s);
    if ($s =~ /\d/) {
	return 0;
    } elsif ($hyphen_count > 1) {
	return 0;
    } elsif ($s =~ /[!.,].+/) {
	return 0;
    } elsif ($s =~ /\w-\W|\W-\w|\w-$|^-\w/) {
	return 0;
    } else {
	return 1;
    }
}

sub proc($str) {
    say "Input: \$str = $str";
    my @word = split ' ', $str;
    my $cnt = grep {is_valid($_)} @word;
    say "Output: $cnt";
}

my $str = "cat and dog";
proc($str);
$str = "a-b c! d,e";
proc($str);
$str = "hello-world! this is fun";
proc($str);
$str = "ab- cd-ef gh- ij!";
proc($str);
$str = "wow! a-b-c nice.";
proc($str);
