#!/usr/bin/perl

use strict;
use warnings;

my ($r,$a,$b);

# Division with function divide
# ------------------------------
($a,$b) = (5,2);
$r = divide($a,$b);
print "Division $a/$b = $r\n";

# Catches the execption and returns message.
# ------------------------------
($a,$b) = (4,0);
$r = divide($a,$b);
print "Division $a/$b = $r\n";

# Throws an exception
# ------------------------------
($a,$b) = (4,0);
$r = $a/$b;
print "Division $a/$b = $r\n";

# ------------------- Divide Function ---------------------
sub divide {
	my ($dividend,$divisor) = @_;
	my $result;
	eval { $result = $dividend/$divisor; };
	if($@ =~ /division by zero/) { $result = "Division by zero is not allowed!"; }
	return $result;
}


