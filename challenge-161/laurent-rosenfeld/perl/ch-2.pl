use strict;
use warnings;
use feature "say";

my  (%seen, @pangram);
my $dict = "./dictionary.txt";
open my $IN, "<", $dict or die "Cannot open $dict $!";
while (my $word = <$IN>) {
    chomp $word;
    my @new_letters = grep {not $seen{$_}} split //, $word;
    next if @new_letters == 0;
    $seen{$_} = 1 for @new_letters;
    push @pangram, $word;
    last if scalar keys %seen == 26;
}
say "@pangram";
