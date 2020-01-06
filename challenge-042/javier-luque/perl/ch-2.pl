#!/usr/bin/perl
# test: ./ch2.pl
use strict;
use warnings;
use feature qw /say/;
use constant {
    MAX_STRING_LENGTH => 4
};

for my $i ( 1 .. 20 ) {
    my $string = generate_random_string();
    my $ok = (validate_string($string)) ? 'OK ' : 'NOT OK';
    say $string . ' - ' . $ok;
}

sub generate_random_string {
    my $length = int(rand(MAX_STRING_LENGTH - 1) + 2);
    my $string;

    for my $i (1 .. $length ) {
        $string .= (int(rand(2))) ? '(' : ')';
    }

    return $string;
}

sub validate_string {
    my $open_p;

    for my $char (split('', shift)) {
        $open_p++ if ($char eq '(');
        $open_p-- if ($char eq ')');

        return 0 if ($open_p < 0);
    }

    return ($open_p == 0);
}
