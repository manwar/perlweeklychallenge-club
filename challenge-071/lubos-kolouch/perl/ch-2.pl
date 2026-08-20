#!/usr/bin/env perl
use v5.38;
use warnings;
use experimental 'signatures';

package Node {
    sub new ( $class, $data ) {
        my $self = {
            data => $data,
            next => undef,
        };
        return bless $self, $class;
    }
}

package LinkedList {
    sub new ($class) {
        my $self = { head => undef };
        return bless $self, $class;
    }

    sub append ( $self, $data ) {
        my $new_node = Node->new($data);
        if ( !$self->{head} ) {
            $self->{head} = $new_node;
        }
        else {
            my $cur = $self->{head};
            $cur = $cur->{next} while $cur->{next};
            $cur->{next} = $new_node;
        }
    }

    sub remove_from_end ( $self, $n ) {
        return if !$self->{head} || $n <= 0;

        my $size = 0;
        my $cur  = $self->{head};
        while ($cur) {
            $size++;
            $cur = $cur->{next};
        }

        if ( $n >= $size ) {
            $self->{head} = $self->{head}->{next};
        }
        else {
            $cur = $self->{head};
            for ( 1 .. $size - $n - 1 ) {
                $cur = $cur->{next};
            }
            $cur->{next} = $cur->{next}->{next} if $cur->{next};
        }
    }

    sub to_array ($self) {
        my @values;
        my $cur = $self->{head};
        while ($cur) {
            push @values, $cur->{data};
            $cur = $cur->{next};
        }
        return \@values;
    }

    sub print ($self) {
        my $arr = $self->to_array;
        say join( " -> ", @$arr );
    }
}

# Embedded tests
if ( !@ARGV ) {
    require Test::More;
    Test::More->import();

    {
        my $ll = LinkedList->new();
        $ll->append($_) for 1 .. 5;
        $ll->remove_from_end(1);
        is_deeply( $ll->to_array(), [ 1, 2, 3, 4 ], 'Remove last element (N=1)' );
    }

    {
        my $ll = LinkedList->new();
        $ll->append($_) for 1 .. 5;
        $ll->remove_from_end(2);
        is_deeply( $ll->to_array(), [ 1, 2, 3, 5 ], 'Remove 2nd from end (N=2)' );
    }

    {
        my $ll = LinkedList->new();
        $ll->append($_) for 1 .. 5;
        $ll->remove_from_end(5);
        is_deeply( $ll->to_array(), [ 2, 3, 4, 5 ], 'Remove head (N=5)' );
    }

    {
        my $ll = LinkedList->new();
        $ll->append($_) for 1 .. 5;
        $ll->remove_from_end(10);
        is_deeply( $ll->to_array(), [ 2, 3, 4, 5 ], 'Remove out-of-range (N=10)' );
    }

    done_testing();
}
