use strict;
use warnings;
use feature "say";
use constant SCALE => 5;

my ( @points, @lines);
my $out = qq{<svg xmlns="http://www.w3.org/2000/svg" xmlns:svg="http://www.w3.org/2000/svg"
xmlns:xlink="http://www.w3.org/1999/xlink" width="500" height="500">\n};
my @input = qw<53,10 53,10,23,30  23,30  34,35,36>;
for my $val (@input) {
    my @items = split /,/, $val;
    # say "@items";
    if (@items == 2) {
        make_point(@items)
    } elsif (@items == 4) {
        make_line(@items);
    } else {
        warn "Error on item ", @items;
    }
}
$out .= "</svg>";
say $out;

sub make_point {
    my @dots = map $_ * SCALE, @_;
    my $point = qq{<circle cx= "$dots[0]" cy="$dots[1]" r="3" fill="forestgreen"/>\n};
    $out .= $point;
}

sub make_line {
    my @dots = map $_ * SCALE, @_;
    my $line = qq{<line x1="$dots[0]" y1="$dots[1]" x2="$dots[2]" y2="$dots[3]" };
    $line .= qq{stroke="navy" />\n};
    $out .= $line
}
