use strict;
use warnings;
use feature "say";
my $nb_rows = shift;
my @row = (1);
for (1 .. $nb_rows) {
    say "@row";
    my @temp = (0, @row, 0);
    @row = ();
    for my $index (0 .. $#temp -1) {
        push @row, $temp[$index] + $temp[$index + 1];
    }
}
