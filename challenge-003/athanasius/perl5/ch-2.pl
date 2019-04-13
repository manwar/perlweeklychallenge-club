use strict;
use warnings;
use Const::Fast;

const my $MIN_ROWS    => 3;
const my $PRINT_WIDTH => 4;

my $arg = $ARGV[0];
const my $ROWS => defined($arg) && ($arg >= $MIN_ROWS) ? $arg : $MIN_ROWS;

display(my $row = [ 1 ]);   # First row

for my $i (2 .. $ROWS)
{
    my $next = [ 1 ];
    push @$next, $row->[$_ - 1] + $row->[$_] for 1 .. $#$row;
    push @$next, 1;
    display($row = $next);
}

sub display
{
    my ($row) = @_;
    printf '%*d ', $PRINT_WIDTH,  $row->[$_] for 0 .. $#$row;
    print  "\n";
}
