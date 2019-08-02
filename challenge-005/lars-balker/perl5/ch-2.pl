use v5.20;
use strict;
use warnings;

my @words = sort <>;
chomp @words;

my %seqs;

# group all words that have the same sorted letter sequence
for my $word (@words) {
    my $dorw = join "", sort grep { /\w/ } split //, lc $word;
    push @{ $seqs{$dorw} }, $word
}

# use a schwartzian transform to sort the sequence keys according to most matching words
my @sorted = 
    map { $_->[0] }
    sort { $b->[1] <=> $a->[1] }
    map { [ $_ => scalar @{ $seqs{$_} } ] }
    keys %seqs;

# print out winner, for /usr/share/dict/words it's
# adens => Aden's Andes Dane's Danes Dean's Dena's Edna's Sedna Snead dean's deans sedan
say "$sorted[0] => @{ $seqs{ $sorted[0] } }";
