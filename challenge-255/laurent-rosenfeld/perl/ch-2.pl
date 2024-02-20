use strict;
use warnings;
use feature 'say';

sub most_frequent_word {
    my ($para, $banned) = @_;
    $para =~ tr/,.:;?!//;
    my %histo;
    %histo = map { $_ => ++$histo{$_} }
        grep {$_ ne $banned} split /\W/, $para;
    return (sort { $histo{$b} <=> $histo{$a} } keys %histo )[0];
}

my $t = "Joe hit a ball, the hit ball flew far after it was hit.";
printf "%-30s... => ", substr $t, 0, 28;
say most_frequent_word $t, "hit";

$t = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.";
printf "%-30s... => ", substr $t, 0, 28;
say most_frequent_word $t, "the";
