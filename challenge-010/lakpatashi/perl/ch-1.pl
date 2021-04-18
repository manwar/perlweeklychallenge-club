#!/usr/bin/perl

use warnings;
use strict;

#part 1
# This program supports Max value of 3999

use Data::Dumper;
use List::Util qw(sum);
use feature qw(switch);
my $num = 39;
my $roman = 'xxxix';
print "$num to roman: ",intToRoman($num),"\n";
print "$roman to int: ",romanToInt($roman),"\n";

sub romanToInt{
	my ($roman) = @_;
	my @arr = split '', uc($roman);
	#print join ' ', @arr;
	my %unaryHash = ('I' => ['V','X'],
					'X' => ['L','C'],
					'C' => ['D','M'],
					);
	my %romanHash = ('I' => 1,'V' => 5,'X' => 10,'L' => 50,
					'C'=>100,'D' => 500,'M'=>1000);
	#print Dumper(\%romanHash);
	my $result = 0;
	my $i=0;
	while ($i <= $#arr){
		my $ele = $arr[$i];
		$result += $romanHash{$arr[$i]};
		last if $i == $#arr;
		if( ( $unaryHash{$ele}) and ( grep {$arr[$i+1] eq $_ } @{$unaryHash{$ele} } ) ){
			$result += $romanHash{$arr[$i+1]} - 2*$romanHash{$arr[$i]};
			$i += 1;
		}
		$i++;
	}
	return $result;
}

sub intToRoman{
	my ($n) = @_;
	if($n > 3999){
		print "enter no. less then 4000\n";
		return -1;
	}
	#print "$n\n";
	my @arr = split '',$n;
	my $digitPlace =  scalar @arr;
	my $result='';
	for my $x (@arr){
		given($digitPlace){
			when(4){	#1000s
				$result .= '' if ($x == 0);
				$result .= 'C' x $x if ($x>0 and $x<4);
			
			}
			when(3){	#100s
				$result .= 'CM' if($x == 9);
				$result .= 'CD' if($x == 4);
				$result .= '' if ($x == 0);
				$result .= 'C' x $x if ($x>0 and $x<4);
				$result .= 'M'.'C'x($x-5) if ($x>4 and $x<9);
			}
			when(2){	# 10s
				$result .= 'XC' if($x == 9);
				$result .= 'XL' if($x == 4);
				$result .= '' if ($x == 0);
				$result .= 'X' x $x if ($x>0 and $x<4);
				$result .= 'L'.'X'x($x-5) if ($x>4 and $x<9);
			
			}
			when(1){ 	# 1s
				$result .= 'IX' if($x == 9);
				$result .= 'IV' if($x == 4);
				$result .= '' if ($x == 0);
				$result .= 'I' x $x if ($x>0 and $x<4);
				$result .= 'V'.'I'x($x-5) if ($x>4 and $x<9);
			}
		}
		$digitPlace--;
	}
	return $result;
}

