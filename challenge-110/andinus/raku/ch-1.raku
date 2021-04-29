#!/usr/bin/env raku

#| displays valid phone numbers, given a text file
unit sub MAIN (
    Str $file where *.IO.f = "input-ch1", #= file with phone numbers
);

grammar PhoneNumber {
    token TOP { \s* <country-code> \s+ <number> }
    token country-code { '+' \d \d | '(' \d \d ')' | \d ** 4 }
    token number { \d ** 10 }
}

for $file.IO.lines -> $entry {
    say $entry if PhoneNumber.parse($entry);
}
