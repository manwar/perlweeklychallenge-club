#!/usr/bin/env perl
use strict;
use warnings;
use List::Util;
use v5.26;
no warnings qw<experimental>;

my ($operand1,$operator, $operand2)=@ARGV;

($operand1,$operand2)=map {
	given ($_) {
		romanToDecimal($_) when /[MDCLXVI]/; 
		$_ when /\d+/;
		"Not a digit or roman numeral";
	}
} ($operand1,$operand2);

my $result = do {
	given ($operator) {
		$operand1+$operand2 when /\+/;	
		$operand1-$operand2 when /\-/;	
		$operand1*$operand2 when /\*/;	
		int ($operand1/$operand2) when /\//;	
		"Unkown";
	}
};

print decimalToRoman($result);


sub decimalToRoman {
	my @digits= split "", shift;
	
	#my @p=qw<I X C M>;
	#my @h=qw<V L D>;
	my @out;
	my @p=<I X C M>;
	my @h=<V L D>;
	for (my $i=0; $i < @digits; $i++) {
		my $power=@digits-$i-1;
		my $base=$p[$power];
		my $half=$h[$power];
		$_=$digits[$i];
		if ($_ == 0) {
		}

		elsif (grep {$_ == $digits[$i]} (1..3)) {
			push @out,$base x $_;

		}
		elsif( $_ == 4) {
			push @out,$base;
			push @out, $half;
		}
		elsif( $_ == 5) {
			push @out, $half;
		}
		elsif( grep {$_ == $digits[$i]}  6..8 ) {
			push @out, $half;
			push @out, $base x ($_ - 5);
		}
		elsif ( $_== 9) {
			push @out, $base;
			push @out, $p[$power+1];
		}
		else{

		}
	}
	return join '', @out;
	
}

sub romanToDecimal {
	my %r=(M=>1000, D=>500, C=>100, L=>50, X=>10, V=>5, I=>1); 
	my @c=split '', shift;
	my $diff=0;
	my $sum=0;
	for (my $i=0; $i<@c; $i++) {
		if (($i+1) < @c) {

			if ($r{$c[$i+1]} > $r{$c[$i]}) {
				$diff=$r{$c[$i]};
			}
			else {
				$sum+= $r{$c[$i]} -$diff;
				$diff=0;
			}
		}
		else {
			$sum+=$r{$c[$i]} -$diff;
		}
	}
	return $sum;
}


