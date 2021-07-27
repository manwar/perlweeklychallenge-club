use strict;
use warnings;
use 5.020;
use experimental qw<signatures>;

sub make_arithmetic_generator ( $start, $increment ) {
    my $last = $start - $increment;
    return sub {
        return ( $last += $increment );
    };
}
sub running_average_generator ( $code_for_next_input ) {
    my ($sum, $count);
    return sub {
        return ( $sum += $code_for_next_input->() ) / ++$count;
    };
}

my $stream_next  = make_arithmetic_generator( 10, 10 );
my $avg_next     = running_average_generator( $stream_next );
my $count_wanted = 20;
while ( defined( my $avg = $avg_next->() ) and $count_wanted-- ) {
    say $avg;
}

# I would have just used this code,
# but the task specifies "stream", not "list" or "array"!
# sub running_average ( @s ) {
#     my ( $sum, $count );
#     return map { ($sum += $_) / ++$count } @s;
# }
# say for running_average( map { $_ * 10 } 1..20 );
