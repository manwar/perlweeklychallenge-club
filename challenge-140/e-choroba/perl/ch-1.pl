#!/usr/bin/perl
use warnings;
use strict;

{   package Binary;
    use Tie::Scalar;
    use parent -norequire => 'Tie::StdScalar';

    sub validate {
        die 'Invalid format' if $_[0] =~ /[^01]/;
    }

    sub TIESCALAR {
        my ($class, $value) = @_;
        die 'Too many arguments' if @_ > 2;
        validate($value);
        bless \$value, $class
    }

    sub FETCH { $_[0] }

    sub STORE { validate($_[1]); $_[0]->SUPER::STORE($_[1]) }

    use overload
        '+' => sub {
            sprintf '%b', oct("0b${ $_[0] }") + oct("0b${ $_[1] }")
        },
        '""' => sub { ${ $_[0] } },
}

use Test::More tests => 4;
use Test::Exception;

{   throws_ok {
        tie my $A, 'Binary', 2;
    } qr/Invalid format/,
      'Only binary';
}

{   tie my $A, 'Binary', 11;
    tie my $B, 'Binary', 1;
    is $A + $B, 100, "Example 1 ($A + $B)";
}

{   tie my $A, 'Binary', 101;
    tie my $B, 'Binary', 1;
    is $A + $B, 110, "Example 2 ($A + $B)";
}

{   tie my $A, 'Binary', 0;
    tie my $B, 'Binary', 0;
    $A = 100;
    $B = 11;
    is $A + $B, 111, "Example 3 ($A + $B)";
}
