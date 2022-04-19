use strict;
use warnings;

my $dict = @ARGV ? shift : "../../../data/dictionary.txt";

sub abc{
	my $dict = shift;
	my $IN;
	unless (open $IN, "<$dict"){
		$IN = [qw/forty hippy bees buzz a dirty nosy chimps/];
	}
	my @abc;
	while (my $line = ref $IN eq 'GLOB' ? <$IN> : shift @$IN){
		chomp $line;
		my @a = split //,$line;
		my @b;
		{
			push @b, shift @a;
			last unless @a;
			last if $b[-1] gt $a[0];
			redo;
		}
		push @abc,$line if length($line)==@b;
	}
	@abc = sort{ length $b <=> length $a} @abc unless ref $IN eq 'ARRAY'; 
	return @abc
}

printf "%s\n", join(", ",abc($dict));


