use strict;
use warnings;
use feature "say";
use Data::Dumper;

my @s = ("abc", "dea", "cd", "xyz");

sub find_circle {
    # remove useless strings starting and ending with the same letter
    my @s = grep { not /^(\w)\w+$0$/} @_;
    my %first = map { (substr $_, 0, 1) => 1 } @s;
    say Dumper \%first;
    my %last = map { (substr $_, -1, 1) => 1 } grep { exists $first{substr $_, -1, 1 }}  @s;
    return scalar keys %last > 1 ? 1 : 0;
}
say find_circle @s;
