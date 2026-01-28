use v5.38;

my $alph = "abcdefghijklmnopqrstuvwxyz";

sub proc($str, $int) {
    say "Input: \$str = $str, \$int = $int";
    my @char = split '', $str;
    my @cipher;
    for my $letter (@char) {
	my $starting_index = index $alph, $letter;
	my $ending_index = ($starting_index + $int) % 26;
	push @cipher, substr $alph, $ending_index, 1;
    }
    my $out_word = join '', @cipher;
    say "Output: $out_word";
}

my $str = "abc";
my $int = 1;
proc($str, $int);
$str = "xyz";
$int = 2;
proc($str, $int);
$str = "abc";
$int = 27;
proc($str, $int);
$str = "hello";
$int = 5;
proc($str, $int);
$str = "perl";
$int = 26;
proc($str, $int);
