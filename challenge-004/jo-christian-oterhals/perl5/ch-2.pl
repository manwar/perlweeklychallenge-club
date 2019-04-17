#!/usr/bin/env perl

use v5.18;
use strict;

my %letters;
my @words;
$letters{(("a".."z")[rand(26)])}++ for (1..500); 


open my $fh, "<", "random-2000.dict";
while (<$fh>) {
	chomp;
	push @words, $_;
}
close $fh;

say sum_hash_values(\%letters) . " letters matches";
for my $word (sort { rand cmp rand } @words) {
	my %wbh;
	$wbh{$_}++ for (split('', $word));
	if (hash_is_part_of_hash(\%wbh, \%letters)) {
		subtract_hash_from_hash(\%wbh, \%letters);
		say "\t" . $word;
	}
}
say sum_hash_values(\%letters) . " letters remains.";

1;

sub sum_hash_values {
	my ($hash, $val) = (shift, 0);
	for (keys %$hash) {
		$val += $$hash{$_};
	}
	return $val;
}

sub hash_is_part_of_hash {
	my ($word, $chars, $confirmed) = (shift, shift, 1);
	for (keys %{$word}) {
		$confirmed = 0 if $$chars{$_} - $$word{$_} < 0;
	}
	return $confirmed;
}

sub subtract_hash_from_hash {
	my ($word, $lett) = (shift, shift);
	for (keys %{$word}) {
		$$lett{$_} = $$lett{$_} - $$word{$_};
		delete($$lett{$_}) if $$lett{$_} <= 0;
	}
}
