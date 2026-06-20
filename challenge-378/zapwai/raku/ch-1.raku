use v6;

sub proc($s) {
    say "Input: $s";
    my @d = $s.comb;
    my %h;
    for @d -> $d {
	next if $d ~~ /\D/;
	%h{$d} = 1;
    }
    my @digits = sort keys %h;

    say "Output:" , @digits < 2 ?? "-1" !! @digits[@digits.end - 1];
}

my $s = "aaaaa77777";
proc($s);
$s = "abcde";
proc($s);
$s = "9zero8eight7seven9";
proc($s);
$s = "xyz9876543210";
proc($s);
$s = "4abc4def2ghi8jkl2";
proc($s);
