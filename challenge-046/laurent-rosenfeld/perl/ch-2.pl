use strict;
use warnings;
use feature "say";
use Data::Dumper;
use constant MAX => 50;

# 1 => open, 0 => closed

my @rooms = (1) x (MAX + 1); # (first employee)
my $start = 1;
for (2..MAX) {
    $start++;
    my $door = $start;
    while ($door <= MAX) {
        $rooms[$door] = $rooms[$door] ? 0 : 1;
        $door += $start;
    }
}
say join " ", @rooms[1..MAX];
