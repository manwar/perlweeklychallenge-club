#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';
## no critic (Subroutines::ProhibitSubroutinePrototypes)

use Type::Params    qw(compile);
use Types::Standard qw(Str);

=pod

=head1 NAME

ch-2.pl - Format Phone Number (Perl Weekly Challenge 347)

=head1 SYNOPSIS

  perl ch-2.pl "12 345-6789"
  perl ch-2.pl                    # runs the embedded tests

=head1 DESCRIPTION

Normalizes a phone number consisting of digits, spaces, and dashes into blocks
separated by single dashes according to the rules from the challenge:

=over 4

=item *
Remove all spaces and dashes.

=item *
Group from the left using blocks of length 3.

=item *
If the final chunk would contain a single digit, rebalance the last two blocks
into two groups of length 2.

=back

=cut

sub format_phone_number ($input) {
    state $check = compile(Str);
    ($input) = $check->($input);
    die 'Phone number requires at least two digits' unless $input =~ /\d.*\d/;
    die 'Invalid characters in phone number'
      if $input =~ /[^0-9\s-]/;

    my $digits = $input =~ s/[\s-]//gr;
    my $length = length $digits;
    die 'Phone number requires at least two digits' if $length < 2;

    my @blocks;
    my $pos = 0;
    while ( $length - $pos > 4 ) {
        push @blocks, substr $digits, $pos, 3;
        $pos += 3;
    }

    my $remaining = substr $digits, $pos;
    if ( length $remaining == 4 ) {
        push @blocks, substr( $remaining, 0, 2 ), substr( $remaining, 2, 2 );
    }
    elsif ( length $remaining ) {
        push @blocks, $remaining;
    }

    return join '-', @blocks;
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }

    die qq{Usage: perl $0 "<phone number>"\n} if @args != 1;
    my $input = $args[0];
    say qq{Input:  \$phone = "$input"};
    my $formatted = format_phone_number($input);
    say qq{Output: "$formatted"};
}

sub _run_tests {
    require Test::More;
    Test::More->import();

    my @cases = (
        { label => 'Example 1', phone => '1-23-45-6',   expected => '123-456' },
        { label => 'Example 2', phone => '1234',        expected => '12-34' },
        { label => 'Example 3', phone => '12 345-6789', expected => '123-456-789' },
        { label => 'Example 4', phone => '123 4567',    expected => '123-45-67' },
        { label => 'Example 5', phone => '123 456-78',  expected => '123-456-78' },
    );

    Test::More::plan( tests => scalar @cases );
    for my $case (@cases) {
        my $got = format_phone_number( $case->{phone} );
        Test::More::is( $got, $case->{expected}, $case->{label} );
    }
}

_run_cli(@ARGV);

=head1 FUNCTIONS

=head2 format_phone_number($input)

Returns the normalized representation of C<$input>. Throws an exception unless
the input contains only digits, spaces, and dashes and at least two digits.

=cut
