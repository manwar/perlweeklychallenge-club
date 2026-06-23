use v6;
my $limit = 1000;
sub proc($base) {
    say "Input: \$base = $base, \$limit = $limit";
    my @armstrong;
    for 0 .. $limit -> $number {
	#number in base $base
	my $num = $number.base($base);
	my @d = $num.comb;
	my $len = @d.elems;
	my $sum = [+] @d.map({$_.parse-base($base)**$len});
	@armstrong.push($number) if $sum == $number;
    }
    say "Output: ", @armstrong;
}

my $base = 10;
proc($base);
$base = 7;
proc($base);
$base = 16;
proc($base);
