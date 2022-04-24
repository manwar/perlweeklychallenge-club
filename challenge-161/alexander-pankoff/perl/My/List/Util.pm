package My::List::Util;

use strict;
use warnings;
use feature qw'signatures';
no warnings qw'experimental::signatures';

use List::Util qw(reduce);
use Exporter qw(import);

our @EXPORT_OK = qw(group_by);

sub group_by ( $fn, @xs ) {
    reduce(
        sub {
            push @{ $a->{ $fn->($b) } }, $b;
            return $a;
        },
        {},
        @xs
    );
}

1;
