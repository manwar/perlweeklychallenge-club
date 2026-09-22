#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

# Task 2: Historical values
# Capture and display historical values of a variable as it changes over time.

package HistoricalVar {
    sub new ( $class, $initial_value = undef ) {
        my $self = {
            value   => $initial_value,
            history => defined $initial_value ? [$initial_value] : [],
        };
        return bless $self, $class;
    }

    sub set ( $self, $val ) {
        $self->{value} = $val;
        push @{ $self->{history} }, $val;
        return $val;
    }

    sub get ($self) {
        return $self->{value};
    }

    sub modify ( $self, $op, $amount ) {
        if ( $op eq '+=' ) {
            return $self->set( $self->{value} + $amount );
        }
        elsif ( $op eq '-=' ) {
            return $self->set( $self->{value} - $amount );
        }
        elsif ( $op eq '*=' ) {
            return $self->set( $self->{value} * $amount );
        }
        elsif ( $op eq '/=' ) {
            return $self->set( $self->{value} / $amount );
        }
        else {
            die "Unknown operation: $op";
        }
    }

    sub history ($self) {
        return @{ $self->{history} };
    }
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    # Example test: $x = 10; $x = 20; $x -= 5;
    my $var = HistoricalVar->new(10);
    $var->set(20);
    $var->modify( '-=', 5 );

    is( $var->get(), 15, 'Final value is 15' );
    is_deeply( [ $var->history() ], [ 10, 20, 15 ], 'History captured in order: 10, 20, 15' );

    done_testing();
}
else {
    my $var = HistoricalVar->new(10);
    $var->set(20);
    $var->modify( '-=', 5 );
    say "Historical values: " . join( ', ', $var->history() );
}
