use strict;
use warnings;
use DateTime::Format::Strptime;

sub days_together {
    my ( $foo_start, $foo_end, $bar_start, $bar_end ) = @_;

    my $strp = DateTime::Format::Strptime->new(
        pattern  => '%d-%m',
        on_error => 'croak',
    );

    my $foo_start_date = $strp->parse_datetime($foo_start);
    my $foo_end_date   = $strp->parse_datetime($foo_end);
    my $bar_start_date = $strp->parse_datetime($bar_start);
    my $bar_end_date   = $strp->parse_datetime($bar_end);

    my $start =
      $foo_start_date > $bar_start_date ? $foo_start_date : $bar_start_date;
    my $end = $foo_end_date < $bar_end_date ? $foo_end_date : $bar_end_date;

    my $overlap = $end->delta_days($start)->in_units('days') + 1;

    return $overlap > 0 ? $overlap : 0;
}

print days_together( '12-01', '20-01', '15-01', '18-01' ), "\n";    # Output: 4
print days_together( '02-03', '12-03', '13-03', '14-03' ), "\n";    # Output: 0
print days_together( '02-03', '12-03', '11-03', '15-03' ), "\n";    # Output: 2
print days_together( '30-03', '05-04', '28-03', '02-04' ), "\n";    # Output: 4
