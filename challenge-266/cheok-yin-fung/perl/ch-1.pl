# The Weekly Challenge 266
# Task 1 Uncommon Words
use v5.30.0;
use warnings;

sub uw0 {
    my $line1 = $_[0];
    my $line2 = $_[1];
    my @words1 = split " ", $line1;
    my %hash1;
    my %hash2;
    $hash1{$_}++ for @words1;
    my @words2 = split " ", $line2;
    for (@words2) {
        $hash2{$_}++ if !defined($hash1{$_});
    }
    return [grep {$hash2{$_} == 1} keys %hash2];
}

sub uw {
    my $line1 = $_[0];
    my $line2 = $_[1];
    return [@{uw0($line1, $line2)}, @{uw0($line2, $line1)}];
}

use Test2::V0;
use Test2::Tools::Compare qw/bag/;
is uw('Mango is sweet', 'Mango is sour'), bag {item 'sweet'; item 'sour'; end};
is uw('Mango Mango', 'Orange'), bag {item 'Orange'; end};
is uw('Mango is Mango', 'Orange is Orange'), bag {end};
done_testing();
