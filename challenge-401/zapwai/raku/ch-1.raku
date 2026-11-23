use v6;

sub proc($expr) {
    say "Input: \$expr = $expr";
    my @c = $expr.comb;
    my @sign;			# series of plus or minus signs
    for 0 .. @c.end -> $i {
	push @sign, '+' if @c[$i] eq '+';
	push @sign, '-' if @c[$i] eq '-';
    }
    my $exp = $expr;
    $exp ~~ s:g/ <[+-]> / /;
    my @frac = $exp.words;

    my @num;
    my @den;
    for @frac -> $numb {
	my ($num, $den) = $numb.split('/');
	push @num, $num;
	push @den, $den;
    }
    
    # Get LCM and scale all fractions to have this denominator
    my $lcm = [lcm] @den;
    for 0 .. @den.end -> $i {
	next if @den[$i] == $lcm;
	my $fac = $lcm / @den[$i];
	@den[$i] *= $fac;
	@num[$i] *= $fac;
    }
    
    if @frac.elems == @sign.elems {	# first number was negative
	@num[0] *= -1;
	@sign.shift;
    }
    for 1 .. @frac.end -> $i {	# scale negative numbers
	next if @sign[$i - 1] eq '+';
	@num[$i] *= -1;
    }

    # add all numerators
    my $tot = 0;
    $tot += $_ for @num;
    print "Output: $tot / $lcm -> ";

    my $g = $tot gcd $lcm;
    my $n = $tot / $g;
    my $d = $lcm / $g;
    say "$n / $d";
}

my $expr = "1/2+3/2";
proc($expr);
$expr = "-5/2-3/2";
proc($expr);
$expr = "5/3-5/3";
proc($expr);
$expr = "10/10-1/10+2/5";
proc($expr);
$expr = "1/6+1/6+1/6";
proc($expr);
