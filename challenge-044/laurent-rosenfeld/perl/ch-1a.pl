use strict;
use warnings;
use feature "say";

sub combine {
    my ($combined, $source) = @_;
    if ($source eq "") {
        say $combined if eval $combined == 100;
        return;
    }
    my $operand = chop $source;
    for my $op ('+', '-', '') {
        combine ("$combined$op$operand", $source);
    }
}
my $source = reverse "123456789";
my $combined = chop $source;
combine ($combined, $source);
