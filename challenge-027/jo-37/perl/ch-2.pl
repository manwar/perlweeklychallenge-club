#!/usr/bin/perl

use v5.16;
use warnings;
use experimental qw(signatures postderef);

###

# Import "record" and "history".
HistoryScalar->import();

my $x;
# Start recording.
record($x);

# Assign and retrieve.
$x = 1;
say "x: $x";

# Assign several values and retrieve the current.
$x = ($x * 3) % 7 for (0..4);
say "x: $x";

# Show the history.
say "x's history: ", join ', ', history($x);


### Implementation

package HistoryScalar;

# Minimal TIESCALAR interface.
sub TIESCALAR ($class) {
	bless [], $class;
}

sub FETCH ($self) {
    $self->[-1];
}

sub STORE ($self, $value) {
    push $self->@*, $value;
}

# Tie the argument to this package.
sub record {
    tie $_[0], __PACKAGE__;
}

# Recall the history.
sub history {
    tied($_[0])->@*
}

# Export "record" and "history" into the caller's package.
sub import ($class) {
    my $caller = caller();
    no strict 'refs';
    *{"$caller\::$_"} = \&{"$class\::$_"} for qw(record history);
}
