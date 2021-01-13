use strict;
use warnings;
use feature "say";

my $number = shift // 50;
my @persons = 1 .. $number; # we can do that because
                            # we don't use the array indices
do {
    push @persons, shift @persons;
    shift @persons;
    say "@persons";
} until @persons == 1;
say "Person @persons is the survivor.\n";
