use strict;
use warnings;
use feature "say";

sub combine {
    my ($combined, $source) = @_;
    if ($source eq "") {
        say $combined if evaluate($combined) == 100;
        return;
    }
    my $operand = chop $source;
    for my $op ('+', '-', '') {
        combine ("$combined$op$operand", $source);
    }
}

sub evaluate {
    my $expr = shift;
    my $val = 0;
    $val += $_ for $expr =~ /([+-]?[0-9]+)/g;
    return $val;
}

my $source = reverse "123456789";
my $combined = chop $source;
combine ($combined, $source);
