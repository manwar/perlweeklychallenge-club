use v5.38;
# This is hacky. It would be more appropriate to store numerator and denominator in reduced terms and just compare those.

sub proc($rat1, $rat2) {
    say "Input: \$rat1 = $rat1, \$rat2 = $rat2";
    # For processing, we require a period in each number.
    $rat1 .= "." if ($rat1 !~ /\./);
    $rat2 .= "." if ($rat2 !~ /\./);
    
    my $rep1 = "";
    my $paren_index1 = index $rat1, '(';
    my ($o1, $o2); # o is a briefly expanded number. For integers or non-repeating decimals it remains empty.
    unless ($paren_index1 == -1) {
	my $pre1 = substr $rat1, 0, $paren_index1;
	$rat1 =~ /\((\d+)\)/;
	$rep1 = $1;
	$o1 = $pre1 . $rep1 x 3;
    }
    my $rep2 = "";
    my $paren_index2 = index $rat2, '(';
    unless ($paren_index2 == -1) {
	my $pre2 = substr $rat2, 0, $paren_index2;
	$rat2 =~ /\((\d+)\)/;
	$rep2 = $1;
	$o2 = $pre2 . $rep2 x 3;
    }

    my $output = "false";
    
    # Make o1 the shorter of the two.
    if ($o1 && $o2) {
	if (length($o1) > length($o2)) {
	    my $tmp = $o1;
	    $o1 = $o2;
	    $o2 = $tmp;
	    $tmp = $rep2;
	    $rep2 = $rep1;
	    $rep1 = $tmp;
	}
    } else { # at least one of the numbers is either an integer, or a finite rational. Compare, or first adjust for .0000 (round down) or .9999 (round up)
	if (!$o1 && !$o2) {	# neither rational repeats
	    my ($characteristic1, $mantissa1) = split '\.', $rat1;
	    my ($characteristic2, $mantissa2) = split '\.', $rat2;
	    # We consider mantissa .000 the same as being empty. We change empty to 0 for numerical comparison.
	    $mantissa1 = 0 if (!$mantissa1 || $mantissa1 =~ /^0+$/);
	    $mantissa2 = 0 if (!$mantissa2 || $mantissa2 =~ /^0+$/);
	    # We simply compare integer and fractional parts.
	    $output = "true" if ($characteristic1 == $characteristic2 && $mantissa1 == $mantissa2);
	} else {		# one rational repeats
	    if ($o1) {		# o1 repeats
		my ($characteristic2, $mantissa2) = split '\.', $rat2;
		$mantissa2 = 0 if (!$mantissa2 || $mantissa2 =~ /^0+$/);
		my ($characteristic1, $mantissa1) = split '\.', $o1;
		if ($mantissa1 =~ /^0+$/) {
		    $mantissa1 = 0;
		} elsif ($mantissa1 =~ /^9+$/) {
		    $mantissa1 = 0;
		    if ($characteristic1 > 0) {
			$characteristic1++;
		    } else {
			$characteristic1--;
		    }
		}
		$output = "true" if ($characteristic1 == $characteristic2 && $mantissa1 == $mantissa2);
	    } else {		# o2 repeats
		my ($characteristic1, $mantissa1) = split '\.', $rat1;
		$mantissa1 = 0 if (!$mantissa1 || $mantissa1 =~ /^0+$/);
		my ($characteristic2, $mantissa2) = split '\.', $o2;
		if ($mantissa2 =~ /^0+$/) {
		    $mantissa2 = 0;
		} elsif ($mantissa2 =~ /^9+$/) {
		    $mantissa2 = 0;
		    if ($characteristic2 > 0) {
			$characteristic2++;
		    } else {
			$characteristic2--;
		    }
		}
		$output = "true" if ($characteristic1 == $characteristic2 && $mantissa1 == $mantissa2);
	    }
	}
    }

    # only relevant in the main case, with repeating decimals for both rationals.
    for my $i (0 .. length($rep2) - 1) {
	my $check = substr $o2, 0, -$i;
	$output = "true" if ($o1 eq $check);
    }
    say "Output: $output";
}

my $r1 = "0.(12)";
my $r2 = "0.(121)";
proc($r1, $r2);

$r1 = "0.1(23)";
$r2 = "0.12(32)";
proc($r1, $r2);

$r1 = "0.1(234)";
$r2 = "0.12(342)";
proc($r1, $r2);

$r1 = "12.99(99)";
$r2 = "13.";
proc($r1, $r2);

$r1 = "0.(123)";
$r2 = "0.1(231)";
proc($r1, $r2);

$r1 = "3.14";
$r2 = "3.14";
proc($r1, $r2);

$r1 = "-2.(9)";
$r2 = "-3";
proc($r1, $r2);

