use v5.38;

use Math::Prime::Util qw( lcm gcd );

sub proc($expr) {
    say "Input: \$expr = $expr";
    my @c = split '', $expr;
    my @sign;			# series of plus or minus signs
    for my $i (0 .. $#c) {
	push @sign, '+' if ($c[$i] eq '+');
	push @sign, '-' if ($c[$i] eq '-');
    }
    $expr =~ s/[+|-]/\ /g;
    my @frac = split ' ', $expr;

    my @num;
    my @den;
    for my $numb (@frac) {
	my ($num, $den) = split '/', $numb;
	push @num, $num;
	push @den, $den;
    }
    
    # Get LCM and scale all fractions to have this denominator
    my $lcm = lcm(@den);
    for my $i (0 .. $#den) {
	next if ($den[$i] == $lcm);
	my $fac = $lcm / $den[$i];
	$den[$i] *= $fac;
	$num[$i] *= $fac;
    }
    
    if (@frac == @sign) {	# first number was negative
	$num[0] *= -1;
	shift @sign;
    }
    for my $i (1 .. $#frac) {	# scale negative numbers
	# last if (@sign <= $i);
	next if ($sign[$i - 1] eq '+');
	$num[$i] *= -1;
    }

    # add all numerators
    my $tot = 0;
    $tot += $_ for (@num);
    print "Output: $tot / $lcm -> ";

    my $g = gcd($tot, $lcm);
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
