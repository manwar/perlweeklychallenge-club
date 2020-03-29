#!/usr/bin/env perl
use warnings;
use strict;
use List::Util;
use v5.26;
no warnings 'experimental';

my $n=$ARGV[0]//2;
my @vowels=qw<a e i o u>;

die "Number not in range 1..5\n" unless grep /$n/, 1..5;

say for sort map {join "",@$_} grep {
	my $sum=0;
	my $s=join '', @$_;
	given ($s) {
		my @match;			#<<Used to force list context
		$sum+=@match=/a/g;		#<<Count all a
		$sum-=@match=(/a[ie]|a$/g);	#<<make sure the rules match
						#<<Net sum is 0 for success	
		$sum+=@match=/e/g;
		$sum-= @match=(/ei|e$/g);

		$sum+=@match=/i/g;
		$sum-= @match=/i[aeou]|i$/g;


		$sum+=@match=/o/g;
		$sum-=@match=/o[au]|o$/g;

		$sum+=@match=/u/g;
		$sum-=@match=/u[oe]|u$/g;
	}
	$sum==0;
} combinations(\@vowels,$n);


=item combinations
=cut
sub combinations {
	my @combinations=();
	my ($data,$size)=@_;
	my @indexes=(0) x ($size+1);;
	my $i=0;
	until ($indexes[$size]) {
		my $count=List::Util::uniq(@indexes[0..$size-1]);
		#print $count,"\n";;
		push @combinations, [@$data[@indexes[0..$size-1]]] if $count == $size;
		$indexes[0]++;
		for (0..$size-1) {
			if ($indexes[$_] != 0 and 0 == ($indexes[$_] % @$data)) {
				$indexes[$_]=0;
				$indexes[$_+1]++;
			}
		}
	}
	@combinations;
}
