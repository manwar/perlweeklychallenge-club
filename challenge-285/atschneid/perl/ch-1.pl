use warnings;
use strict;

use v5.38;

sub no_connection( @routes ) {
    my %out_count;
    for (@routes) {
	my ( $from, $to ) = @$_;
	$out_count{ $from } += 1;
	$out_count{ $to } += 0;
    }

    return grep { !$out_count{ $_ } } keys %out_count;
}

my @inputs = (
    [
     ["B", "C"],
     ["D", "B"],
     ["C", "A"],
    ],
    [
     ["B", "C"],
     ["D", "B"],
     ["C", "A"],
     ["C", "Z"],
    ],
    [
     ["A", "Z"],
    ]
    );
for my $input (@inputs) {
    for (@$input) {
	printf '[ ' . ( join ', ', @$_ ) . ' ] ';
    }
    say ' => ' . ( join ', ', no_connection( @$input ) );
}
