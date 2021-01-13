#!/usr/bin/env perl

use v5.012;
use warnings;
use integer;
use Getopt::Long;
use Pod::Usage;

# PWC 061, TASK #2 : IPv4 Partition

# Validate Input

Getopt::Long::Configure( 'bundling_values', 'ignorecase_always',
    'pass_through' );

GetOptions(
    'help|h!' => \( my $help ),
    'task|t!' => \( my $task ),
    'test'    => \( my $test )
);

pod2usage(1) if $help;
pod2usage( -exitval => 0, -verbose => 2 ) if $task;

if ($test) {

    test();

}
else {

    # Bundle up fatal input errors to report them all at once.

    my @errors;
    push @errors, "Only one argument allowed."
      unless @ARGV == 1;
    push @errors, "Only a string of 4 to 12 digits allowed."
      unless $ARGV[0] =~ /\A \d{4,12} \Z/xms;
    pod2usage( join "\n", map { "ERROR: " . $_ } @errors ) if @errors;

    my $digit_string = $ARGV[0];

    # Get the solution.

    output_results($digit_string);
}

exit;    # End of main script.

# The main algorithm.

sub get_octets {

    my ( $octnum, $dstr ) = @_;
    return undef if $octnum < 1;
    $octnum -= 1;

    my $o_end = length($dstr) - $octnum;
    my $o_beg = $octnum ? 1 : $o_end;
    $o_end = 3 if $o_end > 3;

    my @octets;
    for my $o_len ( $o_beg .. $o_end ) {
        my ( $otet, $ostr ) =
          ( substr( $dstr, 0, $o_len ), substr( $dstr, $o_len ) );
        next if $otet =~ /0\d/ or $otet > 255;
        if ($octnum) {
            push @octets, map { "$otet.$_" } get_octets( $octnum, $ostr );
        }
        else {
            push @octets, "$otet" unless "$ostr";
        }
    }
    return @octets;
}

# Report to STDOUT from user command line input.

sub output_results {

    my ($digit_string) = @_;
    my @octets = get_octets( 4, $digit_string );
    if (@octets) {
        say join( "\n", map { "\t$_" } @octets );
    }
    else {
        say "No IPv4 octets can be made from digit string, $digit_string.";
    }
}

# Built in test for the algorithm function.

sub test {

    use Test::More;
    my $input;

    $input = '25525511135';
    is_deeply(
        [ get_octets 4,     $input ],
        [ '255.255.11.135', '255.255.111.35' ],
        'Task Example.'
    );

    $input = '0000';
    is_deeply( [ get_octets 4, $input ], ['0.0.0.0'], 'Four zeros' );

    $input = '8675309';
    is_deeply( [ get_octets 4, $input ], ['86.75.30.9'], "Jenny's number" );

    $input = '2311233211';
    is_deeply(
        [ get_octets 4, $input ],
        [
            '23.11.233.211', '23.112.33.211',
            '231.1.233.211', '231.12.33.211',
            '231.123.3.211', '231.123.32.11',
        ],
        "Six possibilities"
    );

    done_testing();
}

__END__

=head1 NAME

PWC 061, TASK #2 : IPv4 Partition

=head1 SYNOPSIS

  ch-2.pl [options] digit_string

  Options:
    --help        Brief help
    --task        Full description
    --test        Run embedded test

  Arguments:
    The digit string must be 4 to 12 digits long.

=head1 OPTIONS

=over 8

=item B<--help>

Brief help message.

=item B<--task>

Complete description of task and the script's attempt to satisfy it.

=item B<--test>

Run the embedded test suite for this script.

=back

=head1 DESCRIPTION

You are given a string containing only digits (0..9). The string should have
between 4 and 12 digits.

Write a script to print every possible valid IPv4 address that can be made by
partitioning the input string.

For the purpose of this challenge, a valid IPv4 address consists of four
"octets" i.e. A, B, C and D, separated by dots (.).

Each octet must be between 0 and 255, and must not have any leading zeroes.
(e.g., 0 is OK, but 01 is not.)

=head2 Example

=head3 Input:

    25525511135

=head3 Output:

    255.255.11.135
    255.255.111.35

=head1 INTERPRETATION

The DESCRIPTION was pretty complete. The recursive subroutine was written
directly from the spec, with a few logical deductions thrown in.

=cut
