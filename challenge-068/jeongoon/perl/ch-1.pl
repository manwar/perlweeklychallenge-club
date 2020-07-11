#!/usr/bin/env perl
use strict; use warnings;

sub read_row_ {
    my @buffer = @{$_[0]};
    my $line = <STDIN>;
    chomp $line if defined $line;
    push @buffer, $line;
}

sub get_row_ {
    my $buffer = $_[0];
    shift @{$buffer};
}

my @row_raw;
my $round = 1;
my $use_example;

if ( $use_example = !!( grep { /^--use-example$/ } @ARGV) ) {
    $round = 2;
    @row_raw = ( "[1, 0, 1]", "[1, 1, 1]", "[1, 1, 1]", undef,
                 "[1, 0, 1]", "[1, 1, 1]", "[1, 0, 1]", undef );

}

# initial value
{
    my ( @row_whole_zero_flag,  $row_some_zero_str );

    read_row_( \@row_raw ) unless $use_example;
    ( $row_some_zero_str = $row_raw[0] ) =~ s/0/1/g;

    while ( defined( my $r_raw = get_row_( \@row_raw) ) ) {
        my $new_row_some_zero_str = $row_some_zero_str & $r_raw;
        push @row_whole_zero_flag, !!( index( $r_raw, "0" ) > 0 );
        $row_some_zero_str = $new_row_some_zero_str;
        read_row_( \@row_raw ) unless $use_example;
    }

    ( my $row_whole_zero_str = $row_some_zero_str ) =~ s/1/0/g;

    print( ( $_ ? $row_whole_zero_str : $row_some_zero_str ).$/ )
      for @row_whole_zero_flag;
    print $/;
    redo if ( --$round ) > 0;
}
