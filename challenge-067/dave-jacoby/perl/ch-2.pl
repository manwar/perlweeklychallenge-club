#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings qw{ experimental };

use Carp;
use Getopt::Long;
use JSON;
use List::Util qw{ uniq };

my $json = JSON->new->pretty->canonical;

my $phone = '35'; 
GetOptions( 'phone=i' => \$phone )
  or croak 'bad number';

my $ref = letter_phone($phone);
say $json->encode($ref);
exit;

# this one DOESN'T look like a job for recursion!
# well, maybe it does. I could easily have done 
# something similar to the other task, but I didn't
sub letter_phone ( $number ) {
    state $numbers = get_numbers();

    # we add an empty string so that something exists
    # for the $s loop to work on
    my @ref;
    push @ref, '';

    for my $i ( 0 .. -1 + length $number ) {

        # $i is a position in the string
        # $n is the digit in place $i
        # @arr is the list of letters corresponding 
        #   to that digit
        # @new is the array we fill with the 
        #   results of concatenation
        my $n   = substr( $number, $i, 1 );
        my @arr = $numbers->{$n}->@*;
        my @new;
        for my $s (@ref) {
            for my $t (@arr) {
                push @new, $s . $t;
            }
        }
        @ref = @new;
    }
    return wantarray ? @ref : \@ref;
}

# this is separated from letter_phone so that 
# we don't have this big thing taking up space 
# in that function.
# and we're promised numbers, so I am not going
# to add # nd * to the hash.
sub get_numbers() {
    my $ref = {};
    no warnings;
    push $ref->{0}->@*, q{};
    push $ref->{1}->@*, qw{ _ , @ };
    push $ref->{2}->@*, qw{ A B C };
    push $ref->{3}->@*, qw{ D E F };
    push $ref->{4}->@*, qw{ G H I };
    push $ref->{5}->@*, qw{ J K L };
    push $ref->{6}->@*, qw{ M N O };
    push $ref->{7}->@*, qw{ P Q R S };
    push $ref->{8}->@*, qw{ T U V };
    push $ref->{9}->@*, qw{ W X Y Z };
    return $ref;
}
