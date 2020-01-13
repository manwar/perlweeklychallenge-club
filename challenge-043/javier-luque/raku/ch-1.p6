# Test: perl6 ch-1.p6
use v6.d;

my @numbers = (1, 2, 3, 4, 6);
my %rings = (
    blue   => 8,
    yellow => 7,
    green  => 5,
    red    => 9,
    black  => 0
);

sub MAIN() {
    for ( %rings.keys ) -> $ring {
        my $total = %rings.{$ring};
        my @additional_numbers;

        for ( @numbers.sort.reverse ) -> $i {
            if ($total + $i <= 11) {
                $total += $i;
                push @additional_numbers, $i;
            }
        }

        say 'Color: ' ~ $ring ~ ' - ' ~
             @additional_numbers.join(', ');
    }
}
