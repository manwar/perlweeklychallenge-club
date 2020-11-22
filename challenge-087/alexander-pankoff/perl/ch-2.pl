#!/usr/bin/env perl
use v5.20;
use utf8;
use strict;
use warnings;
use feature qw(say signatures);
no warnings 'experimental::signatures';

use Getopt::Long qw(:config auto_help);
use Pod::Usage;

use FindBin;
use lib File::Spec->join( $FindBin::RealBin, '..', '..', '..', 'challenge-084', 'alexander-pankoff', 'perl', 'lib' );
use lib $FindBin::RealBin;

BEGIN {
    require 'ch-1.pl';
}

use MatrixParser;

{
    my $INPUT = slurp( *STDIN );

    my $parser = MatrixParser->new( $INPUT );

    # read the positions of '1's from the input matrix.
    my $corners = $parser->corners();

    # transform the inner hashrefs into arrayrefs with only their keys. (the
    # position of '1's)
    $corners = [ map { [ keys %$_ ] } @$corners ];

    my $largest = largest_rectangle( $corners );

    if ( $largest->{width} == 0 || $largest->{height} == 0 ) {
        say '0';
    }
    else {
        say join(
            "\n",
            map {
                '['
                  . join( ' ', map { 1 } 0 ... $largest->{width} - 1 ) . ']'
            } 0 ... $largest->{height} - 1
        );
    }

}

sub largest_rectangle($corners) {
    my $largest = {
        width  => 0,
        height => 0,
    };

    for my $length ( 2 ... @$corners ) {
        my $slider = SlidingWindow->new( $length, $corners );
        while ( my $win = $slider->next_window ) {
            my @rect = wk087::ch1::longest_consecutive_sequence( intersection( @$win ) );
            next if @rect <= 1;
            my $size = @rect * $length;
            if ( $size > $largest->{width} * $largest->{height} ) {
                $largest->{width}  = scalar @rect;
                $largest->{height} = $length;
            }
        }
    }

    return $largest;
}

sub intersection ( $a, $b, @more ) {
    my %a_lookup = map { $_ => 1 } @$a;
    my @res =
      grep {
        my $b_elem = $_;
        $a_lookup{$b_elem};
      } @$b;

    return @res if !@more;
    return intersection( \@res, @more );
}

sub slurp($fh) {
    local $/ = undef;
    my $out = <$fh>;
    return $out;
}

package SlidingWindow {

    sub new ( $class, $size, $arr ) {
        my $self = {
            _arr  => [ @{$arr} ],
            _size => $size,
            _win  => [],

        };
        bless $self, $class;
    }

    sub next_window($self) {
        $self->fill_win;
        return if @{ $self->{_win} } < $self->{_size};
        my @win = @{ $self->{_win} };
        shift @{ $self->{_win} };
        return \@win;
    }

    sub fill_win($self) {
        while ( @{ $self->{_win} } < $self->{_size}
            && ( my $next = shift( @{ $self->{_arr} } ) ) )
        {
            push @{ $self->{_win} }, $next;
        }
    }
};

=pod

=head1 NAME

wk-087 ch-2 - Largest Rectangle

=head1 SYNOPSIS

ch-2.pl [options]

  This programm will read a MxN matrix from STDIN and print the largest
  rectangle with only `1`s found in the input.

  Options:
    --help       print this help text

=cut
