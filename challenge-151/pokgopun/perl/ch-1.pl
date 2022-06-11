use strict;
use warnings;

my @sample = @ARGV ? @ARGV : ('1 | 2 3 | 4 5', '1 | 2 3 | 4 * * 5 | * 6');

foreach my $sample (@sample) {
	my @level = split /\|/, $sample;
	my @node;
	for (my $i = @level - 1; $i >=0; $i--){
		my @array = $level[$i] =~ /(\S+)/g;
		foreach my $j (0..2**$i-1){
			my @pair;
			$pair[$_] = $node[2*$j+$_] foreach 0..1;
			@pair = sort{$a <=> $b} grep{defined $_} @pair;
			#printf "%s => %s\n", $j, join(",", map{defined $_ ? $_ : 'undef'} @pair);
			$array[$j] = @pair ? $pair[0] : defined $array[$j] && $array[$j] ne '*' ? $i+1 : undef;
		}
		@node = @array;
		#printf "%s\n", join(",", map{defined $_ ? $_ : 'undef'} @node);
	}
	@node = sort{$a <=> $b} grep{defined $_} @node;
	printf "Input: %s\n", $sample;
	printf "Output: %d\n\n",$node[0];
}


