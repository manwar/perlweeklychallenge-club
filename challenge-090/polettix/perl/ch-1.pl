#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;

sub dna_sequence ($s) {
   my $complementary = $s =~ tr{ACGT}{TGCA}r;
   my %cf = map { $_ => eval "scalar \$s =~ tr{$_}{}d" } qw< A C G T >;
   return (\%cf, $complementary);
}

my $default =
  'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';
my $sequence = shift || $default;
my ($cf, $complementary) = dna_sequence($sequence);

$|++;
say {*STDERR} $sequence;
say {*STDOUT} $complementary;
say {*STDOUT} "A<$cf->{A}> C<$cf->{C}> G<$cf->{G}> T<$cf->{T}>";
