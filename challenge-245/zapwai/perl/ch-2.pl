use v5.30;
use Math::Combinatorics;
use Algorithm::Permute;
use List::Util;
my @digits = (8,1,9);
@digits = (8,6,7,1,0);
my @poss;

for my $cnt (1 .. @digits) {
    my $comb = Math::Combinatorics->new(
	count => $cnt,
	data => [@digits]
    );
    while (my @combo = $comb->next_combination) {
	my $p = Algorithm::Permute->new(\@combo);
	while (my @perm = $p->next) {
	    my $num = join("", @perm);
	    push @poss, [@perm] if ($num % 3 == 0);
	}
    }
}    

my $max = -1;
for my $r (@poss) {
    my $num = join("", @$r);
    $max = $num if ($max < $num);
}
say "Input : \@digits = (" .join(", ",@digits).")";
say "Output: $max";
