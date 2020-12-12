use v6;

my $dna = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG';

# count
my %histo;
%histo{$_}++ for $dna.comb;
say "Histogram:";
.say for %histo.pairs;

# Complementary sequence
my %complement = T => 'A', A => 'T', G => 'C', C => 'G';
.say for "Complement:", $dna.comb.map({%complement{$_}}).join: '';
