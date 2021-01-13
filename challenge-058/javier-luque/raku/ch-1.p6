# Test: perl6 ch-1.p6
sub MAIN() {
    say '   v1   v2    Result';
    say '------ ------ ------';
    say '0.1   < 1.1   ' ~  compare('0.1','1.1');
    say '2.0   > 1.2   ' ~  compare('2.0','1.2');
    say '1.2   < 1.2_5 ' ~  compare('1.2','1.2_5');
    say '1.2.1 > 1.2_1 ' ~  compare('1.2.1','1.2_1');
    say '1.2.1 = 1.2.1 ' ~  compare('1.2.1','1.2.1');
    say '1_0   > 1     ' ~  compare('1_0','1');
    say '10    > 1.0   ' ~  compare('10','1.0');
    say '1.1.1 < 1.2.1 ' ~  compare('1.1.1','1.2.1');

    sub compare(Str $v1, Str $v2) {
    	my ($v1_d, $v1_a) = parse($v1);
    	my ($v2_d, $v2_a) = parse($v2);

    	 while ($v1_d.elems || $v2_d.elems ) {
    		my $d1 = $v1_d.shift;
    		my $d2 = $v2_d.shift;

    		return 0  if (!defined($d1) && !defined($d2));
    		return 1  if (defined($d1)  && !defined($d2));
    		return -1 if (!defined($d1) && defined($d2));
    		return 1 if ($d1 > $d2);
    		return -1 if ($d1 < $d2);
    	}

    	return  0 if (!defined($v1_a) && !defined($v2_a));
    	return  1 if (defined($v1_a)  && !defined($v2_a));
    	return -1 if (!defined($v1_a) && defined($v2_a));

    	return ($v1_a > $v2_a)  ??  1 !!
    	        ($v1_a < $v2_a) ?? -1 !! 0;
    }

    sub parse(Str $version) {
    	my @digits = $version.split('.');
    	my ($last_digit, $alpha) = @digits.pop.split('_');
    	@digits.push($last_digit);

    	return @digits, $alpha;
    }
}
