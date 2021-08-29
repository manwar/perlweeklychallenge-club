#!/usr/bin/env perl

use strict;
use warnings;

use Carp qw(croak);
use Const::Fast;
use Data::Dumper;
use List::MoreUtils qw(first_value);
use Pod::Usage qw(pod2usage);
use Try::Tiny;
use JSON::XS qw();

const my %STATUS => (
    SUCCESS      => 0,
    FAIL         => 1,
    NO_ARGS      => -1,
    INVALID_ARGS => -2,
    UNKNOWN      => -4,
);

sub validate_intervals {
    my ($intervals_arrayref) = @_;

    croak('Invalid argument')
        if ( ( ref($intervals_arrayref) ne 'ARRAY' )
        || ( first_value { ref($_) ne 'ARRAY' } @$intervals_arrayref )
        || ( first_value { scalar(@$_) != 2 } @$intervals_arrayref ) );

    return;
}

sub conflict_intervals {
    my ($intervals_arrayref) = @_;

    validate_intervals($intervals_arrayref);

    my @result;
    my $scene = [];
    for my $index ( 1 .. scalar(@$intervals_arrayref) ) {
        $index -= 1;
        my $intv = $intervals_arrayref->[$index];
        foreach ( $intv->[0] .. $intv->[1] ) {
            if ( defined( $scene->[$_] ) ) {
                push @result, $intv;
                last;
            }
        }
        $scene->[ $intv->[0] ] = $index;
        $scene->[ $intv->[1] ] = $index;
    }

    return \@result;
}

sub main {
    my ($intervals_json_string) = @_;
    my $status;

    if ( scalar(@_) < 1 ) {
        pod2usage(
            -msg     => 'Not enough arguments',
            -exitval => $STATUS{NO_ARGS},
            -verbose => 1,
        );
    }

    my $json_coder = JSON::XS->new->ascii;

    my $intervals = try {
        $json_coder->decode($intervals_json_string);
    }
    catch {
        my $cause = $_ =~ /^(.*)\s*at/ && $1;
        pod2usage(
            -msg     => "Invalid argument: $intervals_json_string.\nCause: $cause",
            -exitval => $STATUS{INVALID_ARGS},
            -verbose => 1,
        );
    };

    my $conflicted_intervals = try {
        conflict_intervals($intervals)
    }
    catch {
        if ( $_ =~ /invalid\s*argument/si ) {
            pod2usage(
                -msg     => "Invalid argument: $intervals_json_string",
                -exitval => $STATUS{INVALID_ARGS},
                -verbose => 1,
            );
        }
        else {
            pod2usage(
                -msg     => 'Unknown error',
                -exitval => $STATUS{UNKNOWN},
                -verbose => 1,
            );
        }
    };

    print $json_coder->encode($conflicted_intervals), "\n";

    $status = ( scalar(@$conflicted_intervals) > 0 ) ? $STATUS{SUCCESS} : $STATUS{FAIL};

    return $status;
}

exit( main(@ARGV) );

__END__

=head1 NAME

ch-2.pl - Finds if any intervals conflict with any of their previous intervals

=head1 SYNOPSIS

=over 3

=item $ ch-2.pl RANGES

=back

=head1 DESCRIPTION

Parses one string argument as a list of numeric ranges and it reports the ranges 
that conflict with at least one of their previous ones.
The conflict checking is forward only, so the first range will never appear in 
the result.

The list should be written as an array of arrays of numbers in proper JSON 
format. The output is also in valid JSON format.

=head2 Arguments

=over 3

=item RANGES

JSON formatted array of arrays of two numbers.

Example: '[ [1,4], [3,5], [6,8], [12,13], [3,20] ]'

=back

=head2 Output

It prints a JSON array with the conflicted ranges.
If none, it just prints an empty JSON array.

=head2 Exit status

=over 6

=item '0'

If conflicted ranges are found.

=item '1'

If no conflicted ranges are found.

=item '< 0'

If errors

=back

=head1 AUTHOR

Ioannis Bourlakos <https://github.com/jbourlakos>

=cut
