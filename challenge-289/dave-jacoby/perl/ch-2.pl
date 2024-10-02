#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use List::Util qw{ min max };

my @examples = (

    'Perl is different. In a nutshell, Perl is designed to make
the easy jobs easy, without making the hard jobs impossible.',

    'According to Larry Wall(1), the original author of the Perl 
programming language, there are three great virtues of a 
programmer; Laziness, Impatience and Hubris.',

    q{If you haven't used regular expressions before, a tutorial 
introduction is available in perlretut. If you know just a 
little about them, a quick-start introduction is available 
in perlrequick.},

    'THIS looks like a job for RECURSION!',
);

for my $input (@examples) {
    my $output = $input;
    $output =~ s{(\w)(\w+)(\w)}{ $1 . jumble_letters( $2 ) . $3 }gmxe;

    say $input;
    say '-----';
    say $output;
    say '';
}

sub jumble_letters ($str) {
    $str = join '', sort { rand 10 <=> rand 10 }
        split //, $str;
    return $str;
}
