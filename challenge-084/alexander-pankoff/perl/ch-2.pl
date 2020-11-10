#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use autodie;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use List::Util qw(any sum0);

use Getopt::Long;
use Pod::Usage;

use FindBin;
use lib File::Spec->join( $FindBin::RealBin, 'lib' );
use lib File::Spec->join( $FindBin::RealBin, '..', '..', '..', 'challenge-083',
    'alexander-pankoff', 'perl', 'lib' );

use Combinations qw(combinations);
use MatrixParser;

{
    my $file;
    GetOptions( "file=s" => \$file, ),
      or pod2usage( -exitval => 1, );

    my $input = read_input($file);

    my $parser = MatrixParser->new($input);

    # read the corners from the input matrix.
    my $corners = $parser->corners();

    say find_squares($corners);
}

# we process the corners row by row. For each row we build pairs from the
# possible corners and check wether we can find the same pair in the row that is
# as far away from the current row as the corners in the pair are apart from each
# other
sub find_squares ( $corners, $count = 0 ) {
    ## base case. no more squares possible
    return $count if keys @$corners < 2;

    my $row  = $corners->[0];
    my @rest = @{$corners}[ 1 .. $#{$corners} ];

    # build corner pairs from the current row, if there are less than 2
    # elements no pais will be build
    my @corner_pairs = combinations( 2, keys %{$row} );

    my $squares = sum0(
        map {
            my ( $a, $b ) = @{$_};

            # calculate the distance between the 2 corners.
            my $dist      = abs( $a - $b );
            my $check_row = $rest[ $dist - 1 ];

            # if both corners are set in check_row aswell we found a square
            $check_row && $check_row->{$a} && $check_row->{$b}
              ? 1
              : 0
        } @corner_pairs
    );

    return find_squares( \@rest, $count + $squares );
}

sub read_input($file) {
    my $fh;
    if ($file) {
        open( $fh, '<', $file );
    }
    else {
        $fh = *STDIN;
    }
    local $/ = undef;
    my $input = <$fh>;
    return $input;
}

=pod

=head1 NAME

wk-084 ch-2 - Find Squares

=head1 SYNOPSIS

Given a matrix of size M X N with only 1 and 0, this script will count the
squares with all corners set to 1.

The Matrix can be provided via STDIN or read from a file.

Example:

Input: [ 0 1 0 1 ]
       [ 0 0 1 0 ]
       [ 1 1 0 1 ]
       [ 1 0 0 1 ]

Output: 1

ch-2.pl [--matrix=INPUTFILE]

=head1 ARGUMENTS

=over 8

=item B<matrix> - the file to read the matrix from

=back

=cut
