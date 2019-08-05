#!/usr/bin/perl6

sub wordWrap(Str $paragraph, Int $lineWidth) {
    my $spaceLeft = $lineWidth + 1;

    for $paragraph.words -> $word {
        my $wordWidth = $word.chars;
        if $wordWidth + 1 > $spaceLeft {
            print "\n";
            $spaceLeft = $lineWidth - $wordWidth;
        } else {
            $spaceLeft -= ($wordWidth + 1);
        }
        print "$word ";
    }
    print "\n";
}
