#!/usr/bin/perl

use strict;
use warnings;
use lib '.';
use Getopt::Long;
use Div qw(debug);
my $DEBUG=0;

my ($list,$dividend,$divisor) = (0,"","");
my $o = GetOptions ("list" => \$list, "dividend=s" => \$dividend, "divisor=s" => \$divisor);
if(!$o) { usage(); die("Error in command line arguments\n"); }

my %vars = (
	var4 => 4,
	var2 => 2,
	var1 => 1,
	zero => 0,
	pi   => 3.1417,
	eternal => 9999.9999,
);

if($list) { list(); }
elsif($dividend and $divisor and 
	($vars{$dividend} or $dividend eq "zero") and 
	($vars{$divisor}  or $divisor eq "zero")) { 
		compute($vars{$dividend},$vars{$divisor}); 
}
else { 
	usage(); 
}

# ----------------- Functions ----------------
sub list {
	print "List of Vars:\n";
	foreach my $k (keys %vars) {
		printf("   %-8s: %5.5f\n", $k, $vars{$k});
	}
}
sub usage {
	print "Usage: ./pwc312.pl [--list|-l] [--dividend <nr> --divisor <nr>]\n";
	print "   Script is dividing two numbers, dividend/divisor.\n";
	print "   --list,     list of possible variables.\n";
	print "   --dividend, dividend for division.\n";
	print "   --divisor,  divisor for division.\n";
	print "   Examples:\n";
	print "   ./pwc312.pl -l\n";
	print "   ./pwc312.pl --dividend var1 --divisor var2\n";
	print "   ./pwc312.pl --dividend=var1 --divisor=var3\n";
}

sub compute {
	my ($dividend,$divisor) = @_;
	my $a = Div->new($dividend);
	my $b = $divisor;
	my $r = $a/$b;
	print "Division $a/$b = $r\n";
	debug($a,$b,$r) if $DEBUG;
}

