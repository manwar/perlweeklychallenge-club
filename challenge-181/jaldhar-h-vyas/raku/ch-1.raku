#!/usr/bin/raku

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

sub MAIN() {
    my $text = q:to/-TEXT-/;
All he could think about was how it would all end. There was
still a bit of uncertainty in the equation, but the basics
were there for anyone to see. No matter how much he tried to
see the positive, it wasn't anywhere to be seen. The end was
coming and it wasn't going to be pretty.
-TEXT-
    $text = $text.subst(/\n/, ' ', :g);
    $text = $text.subst(/\n$/);
    my $newtext;
    my @sentences = $text.split(/\./);
    @sentences.pop();

    for @sentences -> $sentence {
        my @words = $sentence.split(/' '+/);
        @words = @words.sort({ $^a.uc cmp $^b.uc });
        $newtext ~= @words.join(q{ });
        $newtext ~= q{. };
    }

    wordWrap($newtext, 60);
}