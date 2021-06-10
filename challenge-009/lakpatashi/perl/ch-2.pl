#!/usr/bin/perl

use warnings;
use strict;

#part 2
use Data::Dumper;
use feature qw(switch);
print "\n\n";
my @points = (20,10,40,20);
print "Points List: ",join(' ', @points), "\n";
my $code1 = 'std';
my $code2 = 'mod';
my $code3 = 'den';
Rank(\@points,$code1);
Rank(\@points,$code2);
Rank(\@points,$code3);

sub Rank{
	my ($arr ,$code) = @_;
	@_ = @{$arr};
	print "Ranking $code\n";
	my %pointHash;
	++$pointHash{$_} for  @_;
	#print Dumper(\%pointHash);
	my $rank = 1;
	if( $code =~ 'mod' ){
		$rank = 0;
	}
	print "Rank Points\n";
	for my $point (sort {$b<=>$a} keys %pointHash ){
		given($code){
			when('std') {						   #std 1224
				print "$rank ==> $point\n"x $pointHash{$point};	
				$rank += $pointHash{$point};
			}
			when('mod') {                         #modified 1334
				$rank += $pointHash{$point};
				print "$rank ==> $point\n"x $pointHash{$point};	
			}
			when('den') {                         #dense 1223
				print "$rank ==> $point\n"x $pointHash{$point};	
				$rank++;
			}
		}
	}
	print '-'x10,"\n\n";
}

