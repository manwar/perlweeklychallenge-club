my @suits = flat <♠ ♣ ♥ ♦> »xx» 13;
my @values = flat (1 .. 13) xx 4;
my @hands = (^52).combinations: 5;
say +@hands; # 2,598,960
my @counts = 0 xx 10;
for @hands -> @hand {
	my @v = @values[@hand];
	my @c = @v.Bag.values;
	my @s = @suits[@hand];
	my $straight = ((@v.min «+« ^5) ⊆ @v) || (1 ∈ @v) && (10 .. 13 ⊆ @v);
	my $flush = [eq] @s;
	when     5 ∈ @c           { @counts[0]++ } # five of a kind
	when $straight and $flush { @counts[1]++ } # straight flush
	when     4 ∈ @c           { @counts[2]++ } # four of a kind
	when 3 & 2 ∈ @c           { @counts[3]++ } # full house
	when $flush               { @counts[4]++ } # flush
	when $straight            { @counts[5]++ } # straight
	when     3 ∈ @c           { @counts[6]++ } # three of a kind
	when 2 == @c.grep: 2      { @counts[7]++ } # two pair
	when     2 ∈ @c           { @counts[8]++ } # one pair
	                            @counts[9]++   # high card
	# it's a shame that
	# @counts[i]++ when ...
	# doesn't work because the statement modifier doesn't short-circuit :(
}
say @counts; # 0 40 624 3744 5108 10200 54912 123552 1098240 1302540
