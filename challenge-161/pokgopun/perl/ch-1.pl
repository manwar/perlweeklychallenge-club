use strict;
use warnings;

my $dict = @ARGV ? shift : "../../../data/dictionary.txt";
printf "%s\n", join(", ",abc($dict));

sub abc{
	my $dict = shift;
	my $IN;
	unless (open $IN, "<$dict"){
		$IN = [qw/forty hippy bees buzz a dirty nosy chimps/];
	}
	my @abc;
	while (my $line = ref $IN eq 'GLOB' ? <$IN> : shift @$IN){
		chomp $line;
		push @abc,$line if isAbc($line);
	}
	@abc = sort{ length $b <=> length $a} @abc unless ref $IN eq 'ARRAY'; 
	return @abc
}

sub isAbc{
	my @a = split //, shift;
	if (@a > 1) {
		for (my $i = 1; $i < @a; $i++){
			return 0 if $a[$i] lt $a[$i-1];
		}
	}
	return 1;
}


