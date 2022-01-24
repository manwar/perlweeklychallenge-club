# Print first $n Candano triplets.
my $n = 5;

# From https://engineering.purdue.edu/~mark/twc-148-2.pdf:
# From between equations (15) and (16):
# a = 2 + 3k
# From equation (19):
# b^2 c = (k+1)^2 (8k+5)

# The first element is not used.
my $square := 0, 1**2, 2**2, 3**3 .. Inf;

for (0 .. Inf) -> $k {

    # "rhs" is short for "right hand side".
    my $rhs = ($k+1)**2 * (8*$k+5);

    for (1 .. Inf) -> $b {

    	# If b^2 > $rhs we've gone too far.
    	($square[$b] > $rhs) and last;

    	# If $rhs is not evenly divisible by b^2 then c will not be an integer.
    	($rhs %% $square[$b]) or next;

    	# Found one.
    	my $a = 2 + 3*$k;
    	my $c = $rhs / $square[$b];
    	say "($a,$b,$c)";

    	(--$n) or exit 0;
    }
}
