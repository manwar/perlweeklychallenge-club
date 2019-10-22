#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

# Limitation - this only tracks the scalar container, not changes to
# nested objects.

package History {
    use Moose;
    use feature 'signatures';
    no warnings 'experimental::signatures';

    has hist => (
        is      => 'rw',
        isa     => 'ArrayRef',
        default => sub { [] },
    );
    has data => ( is => 'rw', );

    sub FETCH($self) {
        return $self->data;
    }

    sub STORE ( $self, $value ) {
        $self->data($value);
        push $self->hist->@*, $value;

        return $value;
    }

    sub TIESCALAR($self) {
        return $self->new();
    }

    sub history($self) {
        return $self->hist->@*;
    }
}

MAIN: {
    my $x;
    my $hist = tie $x, 'History';

    $x = 10;
    $x = 20;
    $x -= 5;

    $x = 'Foo!';

    # A new instance of history should be independnet.
    my $z;
    my $hist2 = tie $z, 'History';
    $z = 3;    # Won't show up in history for $x.

    # And we just set the original history, the one we log, to a new
    # value
    $x = 'Baz.';

    say join( "\n", $hist->history );
}

