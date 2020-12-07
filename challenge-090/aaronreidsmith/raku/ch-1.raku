#!/usr/bin/env perl6

subset ValidDna of Str where { $_ ~~ /^^[A|T|G|C]+$$/ }

# Since DNA is generally read from 5' to 3', I included the option to find the
# reverse compliment in addition to the complement
sub MAIN($dna where $dna ~~ ValidDna, Bool :rc(:$reverse-complement) = False) {
    my $translated = $dna.trans('ATGC' => 'TACG');
    if $reverse-complement {
        say "5'-{$translated.flip}-3'";
    } else {
        say "3'-$translated-5'"
    }
}
