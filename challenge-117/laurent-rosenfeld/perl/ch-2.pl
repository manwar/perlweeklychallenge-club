use strict;
use warnings;
use feature "say";

my $end = shift // 3;

sub visit  {
    my ($row, $col, $path) = @_;
    print "$path " and return if $row == $end and $col == $end;
    visit($row + 1, $col + 1, "${path}R") if $row < $end and $col < $end;
    visit($row, $col + 1, "${path}H") if $col < $row;
    visit($row + 1, $col, "${path}L") if $row < $end;
}

visit(0, 0, '');
