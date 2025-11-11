#!/bin/env raku

# The Weekly Challenge 347
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

# Task 1, Format Date
pwc-test './ch-1.raku', '10th Nov 2025', '2025-11-10', 'Format Date: "10th Nov 2025" => 2025-11-10';
pwc-test './ch-1.raku', '1st Jan 2025',  '2025-01-01', 'Format Date: "1st Jan 2025"  => 2025-01-01';
pwc-test './ch-1.raku', '22nd Feb 2025', '2025-02-22', 'Format Date: "22nd Feb 2025" => 2025-02-22';
pwc-test './ch-1.raku', '15th Apr 2025', '2025-04-15', 'Format Date: "15th Apr 2025" => 2025-04-15';
pwc-test './ch-1.raku', '23rd Oct 2025', '2025-10-23', 'Format Date: "23rd Oct 2025" => 2025-10-23';
pwc-test './ch-1.raku', '31st Dec 2025', '2025-12-31', 'Format Date: "31st Dec 2025" => 2025-12-31';

# Task 2, Format Phone Number
pwc-test './ch-2.raku', '1-23-45-6',   '123-456',     'Format Phone Number: "1-23-45-6"   => 123-456';
pwc-test './ch-2.raku', '1234',        '12-34',       'Format Phone Number: "1234"        => 12-34';
pwc-test './ch-2.raku', '12 345-6789', '123-456-789', 'Format Phone Number: "12 345-6789" => 123-456-789';
pwc-test './ch-2.raku', '123 4567',    '123-45-67',   'Format Phone Number: "123 4567"    => 123-45-67';
pwc-test './ch-2.raku', '123 456-78',  '123-456-78',  'Format Phone Number: "123 456-78"  => 123-456-78';
