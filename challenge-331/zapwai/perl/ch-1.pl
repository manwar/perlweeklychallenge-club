use v5.38;
sub proc($str) {
    say "Input: $str";
    my @word = split " ", $str;
    say "Output: ".length($word[$#word]);
}

my $str = "The Weekly Challenge";
proc($str);
$str = "   Hello   World    ";
proc($str);
$str = "Let's begin the fun";
proc($str);
