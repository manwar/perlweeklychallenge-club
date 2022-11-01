use strict;
use warnings;
use feature qw/say/;

sub get_degree {
    my %histo;  # histogram
    $histo{$_}++ for @_;
    return (sort { $histo{$b} <=> $histo{$a} } keys %histo)[0]
}

for my $test ([<1 3 3 2>], [<1 2 1 3>],
    [<4 3 2 1 2>], [<1 1 2 3 4>], [<2 1 2 1 1>]) {
    my @list = @$test;
    my $degree = get_degree @list;
    my ($start, $end);
    for my $i (0..$#list) {
        if ($list[$i] == $degree) {
            $start = $i unless defined $start;
            $end = $i;
        }
    }
    say "@list \t => @list[$start..$end]";
}
