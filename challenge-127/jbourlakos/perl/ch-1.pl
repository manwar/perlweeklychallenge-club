#!/usr/bin/env perl

use strict;
use warnings;

use Const::Fast;
use Pod::Usage qw(pod2usage);

const my %STATUS => (
    SUCCESS      => 0,
    FAIL         => 1,
    NO_ARGS      => -1,
    INVALID_ARGS => -2,
);

sub string_to_arrayref {
    my ($str) = @_;
    my @array;
    if ( !defined($str) ) {
        return \@array;
    }
    while ( $str =~ /^\D*((?:\+|\-)?\d+)\D*/ ) {
        push @array, $1;
        $str =~ s/^\D*((?:\+|\-)?\d+)\D*//;
    }
    return \@array;
}

sub disjoint_arrayref {
    my ( $arr1, $arr2 ) = @_;
    my %set1 = map { $_ => 1 } @$arr1;
    my @common_values = grep { $set1{$_} } @$arr2;
    return scalar(@common_values) > 0 ? 0 : 1;
}

sub main {
    my ( $str1, $str2 ) = @_;

    if ( scalar(@_) < 2 ) {
        pod2usage(
            -msg     => 'Not enough arguments',
            -exitval => $STATUS{NO_ARGS},
            -verbose => 1,
        );
    }

    if ( $str1 !~ /\d/ ) {
        pod2usage(
            -msg     => "Invalid first argument: $str1",
            -exitval => $STATUS{INVALID_ARGS},
            -verbose => 1,
        );
    }

    if ( $str2 !~ /\d/ ) {
        pod2usage(
            -msg     => "Invalid second argument: $str2",
            -exitval => $STATUS{INVALID_ARGS},
            -verbose => 1,
        );
    }

    my $arr1 = string_to_arrayref($str1);
    my $arr2 = string_to_arrayref($str2);

    my $result = disjoint_arrayref( $arr1, $arr2 );
    my $status = ($result) ? $STATUS{SUCCESS} : $STATUS{FAIL};

    print $result, "\n";

    return $status;
}

exit( main(@ARGV) );

__END__

=head1 NAME

ch-1.pl - decides if two sets with unique integers are disjoint

=head1 SYNOPSIS

$ ch-1.pl INTEGER-LIST INTEGER-LIST

Example:

$ ch-1.pl '1, 2, 5, 3' '3, 6, 7, 8, 9'

=head1 DESCRIPTION

Parses two arguments as lists of integers.
Each INTEGER-LIST can be written as a sequence of either positive or negative 
integers delimited by arbitrarily many non-digit characters.
In addition, the parsed lists will be considered sets, so the order of the
numbers and any multiple occurrences of the same number don't affect the result.

=head2 Arguments

The following INTEGER-LISTs are considered equivalent sets:

=over 6

=item '1,-3,144'

delimited just with commas

=item '1,-3,144,-3'

repeated values are ignored

=item '1 / -3 / 144'

delimited by spaces and slashes

=item '1,-3,+144'

using both negative and positive signs

=item '+1-3+144'

using signs as delimiters

=item 'blah!1foo$-3bar#144temp%'

using various characters between the numbers

=back


=head2 Output

It prints 1 if the integer sets are disjoint, 0 otherwise.

=head2 Exit status

=over 12

=item '0'

if disjoint

=item '1'

if not disjoint

=item '< 0'

if errors

=back

=head1 AUTHOR

Ioannis Bourlakos <https://github.com/jbourlakos>

=cut
