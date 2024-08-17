use v5.38;
my $str = "hello";
proc($str);
$str = "perl";
proc($str);
$str = "raku";
proc($str);

sub proc($str) {
    my @ord = map { ord $_ } split "", $str;
    my $sum = 0;
    $sum += abs($ord[$_] - $ord[$_ + 1]) for (0 .. $#ord - 1);
    say "Input: $str";
    say "Output: $sum";
}
