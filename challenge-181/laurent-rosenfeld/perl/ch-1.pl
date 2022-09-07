use strict;
use warnings;
use feature qw/say/;
use constant MAX => 55;

my $paragraph = <<'END';
All he could think about was how it would all end. There was
still a bit of uncertainty in the equation, but the basics
were there for anyone to see. No matter how much he tried to
see the positive, it wasn't anywhere to be seen. The end was
coming and it wasn't going to be pretty.
END

my @words;
for my $sentence (split /\./, $paragraph) {
    next if $sentence =~ /^\s*$/;   # remove any empty line
    push @words, (sort { lc $a cmp lc $b } split /\s+/, $sentence);
    $words[-1] .= ".";
}
my $line = "";
for my $w (@words) {
    $line .= "$w ";
    if (length $line > MAX) {
        say $line;
        $line = "";
    }
}
say $line;
