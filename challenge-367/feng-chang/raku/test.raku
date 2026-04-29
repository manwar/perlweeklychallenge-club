#!/bin/env raku

# The Weekly Challenge 367
use Test;

sub pwc-test(Str:D $script, Bool :$deeply? = False, *@input) {
    my ($expect, $assertion) = @input.splice(*-2, 2);
    my $p = run $script, |@input, :out;
    if $deeply {
        is-deeply $p.out.slurp(:close).chomp.words.Bag, $expect, $assertion;
    } else {
        is $p.out.slurp(:close).chomp, $expect, $assertion;
    }
}

# Task 1, Max Odd Binary
pwc-test './ch-1.raku', '1011',   '1101',   'Max Odd Binary: 1011   => 1101';
pwc-test './ch-1.raku', '100',    '001',    'Max Odd Binary: 100    => 001';
pwc-test './ch-1.raku', '111000', '110001', 'Max Odd Binary: 111000 => 110001';
pwc-test './ch-1.raku', '0101',   '1001',   'Max Odd Binary: 0101   => 1001';
pwc-test './ch-1.raku', '1111',   '1111',   'Max Odd Binary: 1111   => 1111';

# Task 2, Conflict Events
pwc-test './ch-2.raku', <10:00 12:00 11:00 13:00>, 'True',  'Conflict Events: @event1=("10:00","12:00"), @event2=("11:00","13:00") => true';
pwc-test './ch-2.raku', <09:00 10:30 10:30 12:00>, 'False', 'Conflict Events: @event1=("09:00","10:30"), @event2=("10:30","12:00") => false';
pwc-test './ch-2.raku', <14:00 15:30 14:30 16:00>, 'True',  'Conflict Events: @event1=("14:00","15:30"), @event2=("14:30","16:00") => true';
pwc-test './ch-2.raku', <08:00 09:00 09:01 10:00>, 'False', 'Conflict Events: @event1=("08:00","09:00"), @event2=("09:01","10:00") => false';
pwc-test './ch-2.raku', <23:30 00:30 00:00 01:00>, 'True',  'Conflict Events: @event1=("23:30","00:30"), @event2=("00:00","01:00") => true';
