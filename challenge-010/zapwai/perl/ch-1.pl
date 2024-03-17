use v5.38;
my @r = qw( I V X L C D M );
my @v = (1, 5, 10, 50, 100, 500, 1000);
my %roman = map { $r[$_], $v[$_] } (0 .. $#r);
my @basic = qw( IIII VIIII XXXX LXXXX CCCC DCCCC );
my @modern = qw( IV IX XL XC CD CM );
my %replace = map { $modern[$_], $basic[$_] } (0 .. $#basic);

sub convert ($s) {
    $s = uc $s;
    say "Input: $s";
    while (my ($k, $v) = each %replace) {
	$s =~ s/$k/$v/g;
    }
    my $sum = 0;
    $sum += $roman{$_} foreach (split "", $s);
    say "Output: $sum";
}

sub trevnoc ($num) {
    say "Input: $num";
    my @stack = map {$v[$_]} grep {$num >= $v[$_]} (0 .. $#r);
    my $ans;
    my $i = $#stack;
    while ($i >= 0) {
	my $x = pop @stack;
	my $d = int $num / $x;
	$ans .= $r[$i] x $d;
	$num -= $d*$x;
	$i--;
    }
    for my $i (0 .. $#basic) {
	my $k = $basic[$#basic - $i];
	my $v = $modern[$#basic - $i];
	$ans =~ s/$k/$v/g;
    }
    say "Output: $ans";
}

convert("CCXLVI");
trevnoc(39);

