use v5.30;
my @int = (15,99,1,34);
@int = (50, 25, 33, 22);
say "Input: \@int = (" . join(", ", @int) . ")";
my @step;
for (0 .. $#int) {
    my ($ans, $cnt) = process($int[$_]);
    push @step, $cnt;
}
my @ans = @int;
my $flag = 0;
do {
    $flag = 0;    
    for my $i (0 .. $#ans - 1) {
	if ( ($step[$i] > $step[$i+1]) || ( ($step[$i] == $step[$i+1]) && ($ans[$i] > $ans[$i+1] ))) {
	    swap($i);
	    $flag++;
	}
    }
} while ($flag);
say "Output: (" . join(", ",@ans) . ")";

sub swap {
    my $i = shift;
    my $a = $ans[$i];
    my $n = $step[$i];
    $ans[$i] = $ans[$i+1];
    $step[$i] = $step[$i+1];
    $ans[$i+1] = $a;
    $step[$i+1] = $n;
}

sub is_single {
    my $num = shift;
    return 1 if ($num =~ /^.$/);
    0
}

sub mult {
    my $num = shift;
    my @d = split "", $num;
    my $product = 1;
    $product *= $d[$_] for (0 .. $#d);
    $product
}

sub process {
    my $num = shift;
    my $prod = $num; my $cnt = 0;
    unless (is_single($num)) {
	do {
	    $cnt++;
	    $prod = mult($prod);
	} until (is_single($prod));
    }
    return ($prod, $cnt);
}
