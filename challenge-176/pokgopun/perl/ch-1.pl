use strict;
use warnings;

my $count = 1;

### start at 10C3 as we need at least 6 (i.e. 3!) variations to produce 1x-6x, end at 10C9 as 10C10 only has single varition
for my $i (3..9){

	my $combo; ### string to store all combiations of $i elements, each value is separated by a space

	### generate list of $i element combinations from set(0,1,2,3,4,5,6,7,8,9) and iterate through it
	foreach my $cmb (split /\s/, combo($i, "0123456789", "", \$combo)){

		### skip if the combination's permuation cannot produce 1x-6x (i.e. max value less than 6 times of min value)
		next if join("", reverse split //, $cmb)/$cmb < 6;

		#print "$cmb\n";

		my $permute; ### string to store all permutations of the combination, each value is separated by a space
		
		### generate list of the combination's permutations and iterate through it
		foreach my $pmt (split /\s/, permute($cmb, "", \$permute)){
			### take each x from the permutations, and check if 6x-2x does exist in the permuations
			### if so, print x and exit; otherwise skipping to then next combo's permutations
			my $j;
			for ($j=6; $j>1; $j--){
				if (index($permute, $pmt * $j)== -1){
					last;
				}
			}
			if ($j == 1){
				print "$pmt\n";
				$count--;
				last;
			}
		}
		last if $count==0;
	}
	last if $count==0;
}

sub permute{
	my($s, $t, $res) = @_;
	my $l = length $s;
	if ($l > 0) {
		foreach my $i (0 .. $l - 1){
			my($si, $ti) = ($s, $t);
			$ti .= substr $si, $i, 1, "";
			#print "$si, $ti\n";
			permute($si, $ti, $res);
		}
	} else {
		${$res} .= " $t";
	}
	return substr(${$res},1)
}

sub combo{
	my($r, $e, $c, $res) = @_;
	my($lc, $le) = (length $c, length $e);
	if ($lc == $r || $lc + $le == $r){
		${$res} .= " ".substr $c.$e, 0, $r;
	} else {
		foreach my $i (0 .. $lc + $le - $r){
			combo($r, substr($e, $i + 1), $c.substr($e, $i, 1), $res); 
		}
	}
	return substr(${$res},1)
}
