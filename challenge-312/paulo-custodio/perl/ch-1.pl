#!/usr/bin/env perl

use Modern::Perl;

my $string = shift // "";
say steps_to_type($string);

sub steps_to_type {
    my($string) = @_;
    my $wheel = join "", 'a'..'z';

    my $steps = 0;
    while ($string ne "") {
        my $letter = substr($string, 0, 1);
        $string = substr($string, 1);

        # scan
        (my $num_steps, $wheel) = scan_letter($wheel, $letter);
        $steps += $num_steps;

        # type
        $steps++;
    }

    return $steps;
}

sub scan_letter {
    my($wheel, $letter) = @_;
    my $pos = -1;
    $wheel =~ /$letter/gc and $pos = pos($wheel)-1;
    $pos >= 0 or die;
    if ($pos == 0) {
        return ($pos, $wheel);
    }
    elsif ($pos < length($wheel)/2) {
        $wheel = substr($wheel, $pos).substr($wheel, 0, $pos);
        return ($pos, $wheel);
    }
    else {
        $wheel = substr($wheel, $pos).substr($wheel, 0, $pos);
        return (length($wheel)-$pos, $wheel);
    }
}
