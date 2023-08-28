#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

my @examples = (

    [ "7868190130M7522", "5303914400F9211", "9273338290F4010" ],
    [ "1313579440F2036", "2921522980M5644" ],
);

for my $e (@examples) {
     my @input  = $e->@*;
     my $input = map { qq{"$_"} } @input;
     my $output = seniors( @input );
    say <<~"END";
    Input:  \@words = ($input)
    Output: $output
    END
}

sub seniors ( @input ) {
    my $count = 0 ;
    for my $passenger ( @input ) {
        my ( $phone, $gender, $age, $seat ) = 
            $passenger =~ m{
                ^           # the start of the data
                (\d{10})    # phone number is ten digits
                (\w)        # gender is one character
                (\d{2})     # age is two digits (rollover for older passengers?)
                (\d{2})     # seat number is two digits
                            # m{...}x allows for whitespace and comments
                            # so you can explain your regular expressions, 
                            # which is such a win
                $           # end of the line
                }mx;
        $count++ if $age >= 60;
    }
    return $count;
}
