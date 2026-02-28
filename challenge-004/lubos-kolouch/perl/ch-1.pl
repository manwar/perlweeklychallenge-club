#!/usr/bin/env perl
use v5.36;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

use Math::BigFloat;

=pod

=head1 NAME

ch-1.pl - Perl Weekly Challenge 004 Task 1: PI Digits

=head1 SYNOPSIS

  perl ch-1.pl
  perl ch-1.pl --test

=head1 DESCRIPTION

Prints the same number of PI digits as the script size in bytes.

=cut

sub pi_prefix ($size) {
    my $precision = $size + 8;
    my $pi_text   = Math::BigFloat->bpi($precision)->bstr();
    my $length    = $size + 1;    # plus decimal point
    return substr $pi_text, 0, $length;
}

sub run_tests {
    require Test::More;
    Test::More->import;

    is( pi_prefix(10), '3.141592653', 'example from spec: size 10' );
    done_testing();
}

if ( @ARGV && $ARGV[0] eq '--test' ) {
    run_tests();
    exit 0;
}

my $script_size = -s $0;
say pi_prefix($script_size);
