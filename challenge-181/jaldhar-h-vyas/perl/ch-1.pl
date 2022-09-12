#!/usr/bin/perl
use 5.030;
use warnings;

sub wordWrap {
    my ($paragraph, $lineWidth) = @_;

    my $spaceLeft = $lineWidth + 1;

    while ( $paragraph =~ /\G (?<word> \S+)(\s+)? /gcx ) {
        my $wordWidth = length $+{word};
        if ($wordWidth + 1 > $spaceLeft) {
            print "\n";
            $spaceLeft = $lineWidth - $wordWidth;
        } else {
            $spaceLeft -= ($wordWidth + 1);
        }
        print "$+{word} ";
    }
    print "\n";
}

my $text = <<'-TEXT-';
All he could think about was how it would all end. There was
still a bit of uncertainty in the equation, but the basics
were there for anyone to see. No matter how much he tried to
see the positive, it wasn't anywhere to be seen. The end was
coming and it wasn't going to be pretty.
-TEXT-
$text =~ s/\n/ /msgx;
$text =~ s/\ $//msgx;
my $newtext;
my @sentences = split q{\.}, $text;

for my $sentence (@sentences) {
    my @words = split /\ +/, $sentence;
    @words = sort { uc $a cmp uc $b } @words;
    $newtext .= join q{ }, @words;
    $newtext .= q{. };
}

wordWrap($newtext, 60);