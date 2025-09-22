use v5.38;

sub proc($s) {
    say "Input: $s";
    my @w = split " ", $s;
    my @n;
    for my $w (@w) {
	push @n, $w if ($w =~ /^\d+$/);
    }
    my $o = "true";
    for my $i (0 .. $#n - 1) {
	$o = "false" if ($n[$i+1] <= $n[$i]);
    }
    say "Output: $o";
}

my $str = "The cat has 3 kittens 7 toys 10 beds";
proc($str);
$str = "Alice bought 5 apples 2 oranges 9 bananas";
proc($str);
$str = "I ran 1 mile 2 days 3 weeks 4 months";
proc($str);
$str = "Bob has 10 cars 10 bikes";
proc($str);
$str = "Zero is 0 one is 1 two is 2";
proc($str);
