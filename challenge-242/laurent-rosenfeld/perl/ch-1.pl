use strict;
use warnings;
use feature 'say';

sub diff {
    my ($aref, $bref) = @_;
    my %a = map {$_ => 1} @$aref;
    my %b = map {$_ => 1} @$bref;
    my $adif = [grep { not exists $b{$_} } keys %a];
    my $bdif = [grep { not exists $a{$_} } keys %b];
    return "(@$adif) (@$bdif)";
}

my @tests = ( [[<1 2 3>],   [<2 4 6>]],
              [[<1 2 3 3>], [<1 1 2 2>]]
            );
for my $test (@tests) {
    printf "%-10s - %-10s => ",
           "@{$test->[0]}", "@{$test->[1]}";
    say diff ($test->[0], $test->[1]);
}
