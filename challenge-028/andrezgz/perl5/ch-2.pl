#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-028/
# Task #2
# Write a script to display Digital Clock.
# Feel free to be as creative as you can when displaying digits.
# We expect bare minimum something like "14:10:11".

use strict;
use warnings;

my @pattern = (
    '....   ..........  ..................... ',
    ':  :  ::   :   ::  ::   :      ::  ::  :o',
    ':  : : :...: ..::..::...:...   ::..::..: ',
    ':  :   ::      :   :   ::  :   ::  :   :o',
    ':..:   ::......:   :...::..:   ::..:...: '
 );

while (1) {
    sleep 1;
    system('clear'); #clear screen

    my ($s,$m,$h) = localtime();
    my @clock_components = split //, sprintf "%02d:%02d:%02d",$h,$m,$s;

    foreach my $p (@pattern) {                             # loop over each pattern line and
        foreach my $c (@clock_components) {                ## loop over each clock component
            if ($c eq q{:}) { print substr $p, -1 }        ### printing the pattern for : (last character of the line)
            else            { print substr $p, $c*4, 4 }   ### or the corresponding one for the digit (4 characters each),
            print q{ };                                    ### and after that, an empty space to complete the component
        }                                                  ##
        print qq{\n};                                      ## print a newline at the end of the line
    }                                                      #

}

__END__

./ch-2.pl

   . .  .      . ....      .    .
  :: :  : o   :: :  : o   ::   ::
 : : :..:    : : :  :    : :  : :
   :    : o    : :  : o    :    :
   :    :      : :..:      :    :
