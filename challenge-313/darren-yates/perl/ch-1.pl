#!/usr/bin/perl

sub brokenKeys {
    my $expected = shift;
    my $typed = shift;

    my @expectedLetters = split(//, $expected);
    my @typedLetters = split(//, $typed);

    my $counter = 0;
    my $intended = 'true';

    foreach my $letter (@typedLetters) {
        # if there are multiple of the same letter in a row, skip to the last 
        # instance of that letter
        if ($expectedLetters[$counter] eq $expectedLetters[$counter + 1]) {
            $counter++;
            next;
        }
        # if the letter is the same as the expected letter, we know the users intentions
        # were to type that letter
        if ($letter eq $expectedLetters[$counter]) {
            next;
        }
        # we now have a different typed letter so need to up the counter to check
        # against the next expected letter
        $counter++;
        # if the letter is not the same as the expected letter, the user did not intend to type
        # that letter
        if ($letter ne $expectedLetters[$counter]) {
            $intended = 'false';
            last;
        }
    }

    print $intended . "\n";
}

brokenKeys('perl', 'perrrl');
brokenKeys('raku', 'rrakuuuu');
brokenKeys('python', 'perl');
brokenKeys('coffeescript', 'cofffeescccript');
