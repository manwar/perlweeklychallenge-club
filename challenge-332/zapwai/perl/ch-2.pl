use v5.38;

sub proc($str) {
    say "Input: $str";
    my @letter = split '', $str;
    my %f;
    for (@letter) {
	$f{$_}++;
    }
    my $even = 0;
    for my $v (values(%f)) {
	$even = 1 if ($v % 2 == 0);
    }
    ($even == 1) ? say "Output: false" : say "Output: true";
}

my $str = "weekly";
proc($str);

$str = "perl";
proc($str);

$str = "challenge";
proc($str);
