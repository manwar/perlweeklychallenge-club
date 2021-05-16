use strict;
use warnings;

#my $aref = [1, 2, 3];
#my @arr = @{$aref};

#push @{$aref}, 9;
#push @arr, 10;

#print "@{$aref}\n";
#print "@arr\n";

sub push2each{
	my ($val, @arefs) = @_;
	my @arrs;
	foreach (@arefs){
		my @cp = @{$_};
		push @cp, $val;
		push @arrs, \@cp;
	}
	return @arrs;
}

my @paths = (
	[[1]],
	[[1,1], [2]]
);

#my $aref = $paths[0];
#my $aref2 = $paths[1];

my @new_paths;

#foreach my $ref (@{$aref}){
#	my @arr = @{$ref};
#	push @arr, 2;
#	push @new_paths, \@arr;	
#}
sub climb{
	my $n = shift;
	if($n > $#paths){
		my @new_paths = push2each(2, @{climb($n-2)});
		push @new_paths, push2each(1, @{climb($n-1)});
		$paths[$n] = \@new_paths;
	}
	return $paths[$n];
}
#push @new_paths, push2each (2, @{$paths[$#paths-1]});
#push @new_paths, push2each (1, @{$paths[$#paths]});
#push(@new_paths, push2each @{$aref2}, 1);
#foreach my $ref (@{$aref2}){
#	my @arr = @{$ref};
#	push @arr, 1;
#	push @new_paths, \@arr;
#}

#$paths[@paths] = \@new_paths;

climb(10);
my $i = 0;
foreach my $pref (@paths){
	my $count = @{$paths[$i]};
	print "Counts: $count";
	if($count < 50){
		print ", ways:\n";
		foreach my $aref (@{$pref}){
			print "[@{$aref}] ";
		}
		print "\n";
	}else{
		print ", ways ommited\n";
	}
	++$i;
}
