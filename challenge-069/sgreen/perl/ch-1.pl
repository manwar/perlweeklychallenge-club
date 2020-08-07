#!/usr/bin/perl

use strict;
use warnings;
use 5.10.1;

sub _generate_number ($$) {
    # Given the first half of a number, generate the whole number
    my ( $number, $length ) = @_;
    my %switch = ( 0 => 0, 6 => 9, 8 => 8, 9 => 6 );
    my @digits = reverse( split //, $number );

    # If an odd number of digits required, the middle (last) digit needs
    #  to be 0 or 8
    return 0 if $length % 2 and shift(@digits) !~ /[08]/;

    # Take each remaining digitis (in reverse order) to calculate the
    #  whole number
    foreach my $digit (@digits) {
        $number .= $switch{$digit};
    }

    return $number;
}

sub _half_length ($) {
    # Calculate the minimum number of digits to generate at least half
    #  the number of digits
    return int( ( shift() + 1 ) / 2 );
}

sub main (@) {
    my ( $a, $b ) = @_;
    my @numbers = ();

    # Sanity checks of the input
    die "First value is not between 1 and 10^15"
      unless $a =~ /^[0-9]+$/
      and $a >= 1
      and $a <= 10**15;

      die "Second value is not between 1 and 10^15"
      unless $b =~ /^[0-9]+$/
      and $b >= 1
      and $b <= 10**15;

    # 10^15 isn't strobogrammatic, so do one less
    $b -= 1 if $b == 10**15;

    # Digits that are strobogrammatic
    my @d = ( 0, 6, 8, 9 );

    # ... however 0 can't be the first digit
    my @list = ( 6, 8, 9 );

    for my $length ( 1 .. length($b) ) {
        # Do we need to an another digit to the list
        if ( length( $list[0] ) < _half_length($length) ) {
            my @new_list = ();
            foreach my $old_list (@list) {
                push @new_list, map { $old_list . $_ } @d;
            }
            @list = @new_list;
        }

        # We now have the first half of all the digits that are
        #  strobogrammatic for the given length. Time to generate
        #  the whole number
        for my $item (@list) {
            my $number = _generate_number( $item, $length );

            # Don't add the number if it isn't valid (middle digit != 0, 8)
            #  or less than the minimum
            next if !$number or $number < $a;

            # If the number is grater than than the maximum, we can exit
            #  as we know @list is in order.
            last if $number > $b;

            push @numbers, $number if $number;
        }
    }

    say join( ' ', @numbers );
}

main(@ARGV);

