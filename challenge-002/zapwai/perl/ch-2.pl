use v5.30.0;
my $A = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXY';

sub val35 {			# value of small num in base 35
    my $r = shift;
    my $R = substr $A, $r, 1;
    $R
}

sub to35 {
    my $num = shift;
    return -1 if ($num > 1_500_000);
#    say "Input: $num";
    my $r = $num % 35;
    my $R = val35($r);
    my @digits;
    for my $power (reverse (1 .. 4)) {
	my $x = int($num/35**$power);
	push @digits, val35($x);
#	say "pow: $power,\tx: $x\tval: ".val35($x);
	$num -= $x*35**$power;
    }
    my $f = join "", @digits;
    $f =~ s/^0+//;
    return $f.$R;
}
sub from35 {
    my $str = shift;
    my @digits = split("", $str);
    my $pow = $#digits ;    
    for (@digits) {
	$_ = index $A, $_;
    }
    my $sum = 0;
    foreach (0 .. $#digits) {
#	say $digits[$_] * (35 ** ($pow - $_));	
	$sum += $digits[$_] * (35 ** ($pow - $_));
    }
    return $sum;
}

#say from35(to35(176289));
say to35(1415926);
