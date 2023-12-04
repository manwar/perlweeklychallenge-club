use v5.30;
my @a = (1,1,2,3,5);
#@a = (4,2,4,5,7);
#@a = (4,1,2,-3,8);
#@a = (-4, 2, -2, 0, -2);
my $p = myp(@a);
my $q = myq($p,@a);
say "Input: \@a = @a";
print "Output: ";
if ( ($p !~ /^-?\d+$/) || ($q !~ /^-?\d+$/) ) {
    say "False";
} elsif (check($p, $q, @a)) {
    say "True \t(p = $p, q = $q)";
}

sub myp {
    my @a = @_;
    my $p = ($a[3]*$a[3] - $a[2]*$a[4]) / ($a[3]*$a[1] - $a[2]*$a[2]);
    return $p;
}
sub myq {
    my ($p,@a) = @_;
    my $q;
    if ($a[3] != 0) {
	$q = ($a[4] - $p*$a[2]) / $a[3];
    } else {
	$q = ($a[2] - $p*$a[0]) / $a[1];
    }
    return $q;
}
sub check {
    # check the first eqn, unused in the above formulas.
    # pa0 + qa1 = a2
    my ($p, $q, @a) = @_;
    if ($a[3] != 0) {
	return 1 if ($p * $a[0] + $q * $a[1] == $a[2]);
    } else {
	return 1 if ($p * $a[2] + $q * $a[3] == $a[4]);
    }
    0
}

# (a3a1 - a2^2) * p = a3^2 - a2a4 ;
# q = (a4 - p*a2) / a3 ;
# q = (a3 - pa1) / a2 ;
# a2 and a3 cannot both be zero.

###    a[n] = p * a[n-2] + q * a[n-1] with n > 1 (p,q ints)

# pa0 + qa1 = a2
# pa1 + qa2 = a3
# pa2 + qa3 = a4

# (in general)
# p(pa0 + qa1) + q(pa1 + qpa0 + qqa1) = a4
# ppa0 + pqa1 + qpa1 + qqpa0 + qqqa1 = a4
# a0(p^2 + q^2p) + a1(2pq + q^3) = a4

# Using third eqn specifically:
# q = (a4 - p*a2) / a3 ;
# (We can use first eqn instead, if a3 = 0.)
# p = (a3 - q*a2) / a1 ;
#   = (a3 - (a4 - p*a2)*a2/a3) / a1 ;
# = (a3 - a2a4/a3 + p*a2^2/a3) / a1 ;
# = a3/a1 - a2a4/a3a1 + p*a2^2/a3a1 ;

# (a3a1 - a2^2) * p = a3^2 - a2a4 ;    
