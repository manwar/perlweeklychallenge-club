#!/usr/bin/perl
use warnings;
use strict;

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-046/ Task #1

# Solution: The message is being repeated with noise, so count the frequency of the chars 
# and report the highest occurring chars as the message.

my $m1 = <<'MESSAGE1';
H x l 4 !
c e - l o
z e 6 l g
H W l v R
q 9 m # o
MESSAGE1

my $m2 = <<'MESSAGE2';
P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0
MESSAGE2

foreach my $message ($m1, $m2) {
	# A hash of hash data structure, indexed by position $p and char $char 
	# for example, $data->{1}{H} = 2, shows the char H occurs twice in position 1
	my $data = {}; 
	foreach my $line (split(/\n/,$message)) {
		my $p = 1;
		foreach my $char (split(/ /,$line)) {
			$data->{$p++}{$char}++; 
		}
	}
	# Now we have all chars counted and indexed by position, so print char that occurs the most
	foreach my $p (sort keys %{$data}) {
		my ($max,$out) = (0,'');
		foreach my $char (keys %{$data->{$p}}) {
			if ($data->{$p}{$char} > $max) {
				$out = $char;
				$max = $data->{$p}{$char};
			}		
		}
		print $out;
	}
	print "\n";
}

__END__

./ch-1.pl
Hello
PerlRaku

