#!/bin/env perl6

constant \Paragraph = q:to/END/;
Use the resources to learn Perl 6 and write about your experience
along the way! Let us know when you do write something if you
want to share it with the larger Perl 6 community (you should!).
Some writing topics could be programs you've written, tricks
you've learned, cool things about the Perl 6, etc. Because of your
fresh perspective as a learner, writing educational/training
material would be a great idea as well. If anything is Less Than
Awesome in your experience you can chat with us, or open an issue
on the User Experience repository.
END

sub wrap-text(Str:D $paragraph, UInt:D $max-width) {
    my Str $line = '';

    for $paragraph.words -> $word {
        die "max-width must be longer than word width: $word" if $word.chars > $max-width;

        if $max-width < $line.chars + 1 + $word.chars {
            say $line;
            $line = $word;
        } else {
            $line ~= $line.chars == 0 ?? $word !! " $word";
        }
    }
    say $line if $line;
}

sub MAIN(UInt $max-width = 80) {
    wrap-text(Paragraph, $max-width);
}
