#!/usr/bin/env perl

use v5.10;
use warnings;

use Test::More;

sub xform {
    my ($input) = @_;

    $input =~ /^(\d{2})\:(\d{2})\s*(am|pm)?\z/ or die "Usage: $0 05:15 pm or 05:15pm or 17:15";

    my ($h, $m, $ap) = ($1, $2, $3);

    if (defined $ap) {
        if ($h == 12) {
            $h = 0 if $ap eq 'am';
        } else {
            $h += 12 if $ap eq 'pm';
        }
        $ap = '';
    } else {
        if ($h == 12) {
            $ap = 'pm';
        } elsif ($h > 12) {
            $h -= 12;
            $ap = 'pm';
        } elsif ($h == 0) {
            $h = 12;
            $ap = 'am';
        } else {
            $ap = 'am';
        }
    }

    return sprintf("%02d\:%02d%s", $h, $m, $ap);
}

is xform('05:15 pm'), '17:15', '05:15 pm';
is xform('05:15pm'), '17:15', '05:15pm';
is xform('19:15'), '07:15pm', '19:15';

is xform('00:34'), '12:34am', '00:34';
is xform('12:34am'), '00:34', '12:34am';
is xform('12:34'), '12:34pm', '12:34';
is xform('12:34pm'), '12:34', '12:34pm';

is xform('05:15am'), '05:15', '05:15am';
is xform('05:15'), '05:15am', '05:15';

done_testing;