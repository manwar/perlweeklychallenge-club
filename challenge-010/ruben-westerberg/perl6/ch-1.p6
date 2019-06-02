#!/usr/bin/env perl6

sub MAIN(
	Str $input,
) {
	given $input {
		when /<[MDCLXVI]>/ {
			say romanToDecimal2($_);
		}
		when /\d+/ {
			say  decimalToRoman($_);
		}
		default {
			die "What on earth are you trying to convert?";
		}
	}

}
sub decimalToRoman ($input) {
	my @digits=$input.comb;
	my $roman= join '', do for  @digits.kv {
		my $power=@digits-$^k-1;	
		#decimalToRoman($^v,@digits-$^k-1);
		my @out;
		my @p=<I X C M>;
		my @h=<V L D>;
		my $base=@p[$power];
		my $half=@h[$power];
		given $^v {
			when 1..3 {
				@out.append: $base xx $_;
			}
			when 4 {
				@out.push: $base;
				@out.push: $half;
			}
			when 5 {
				@out.push: $half;
			}
			when 6..8 {
				@out.push: $half;
				@out.append: $base xx ($_- 5);
			}
			when 9 {
				@out.push: $base;
				@out.push: @p[$power+1];
			}

		}
		|@out;
	}
}

sub romanToDecimal2($input) {

	my %r=(M=>1000, C=>100 ,X=>10, I=>1, V=>5, L=>50, D=>500);
	my @order=%r.sort: *.value <=> *.value;
	my @c=$input.comb;
	my $diff=0;
	my $sum=0;

	for @c.kv -> $k, $v {
		if $k+1 < @c {
			if (%r{@c[$k+1]} > %r{$v}) {
				$diff=%r{$v};
			}
			else {
				$sum+=%r{$v}- $diff;
				$diff=0;
			}
		
		}
		else {
			$sum+=%r{$v}- $diff;
		}
	}
	$sum;
}

