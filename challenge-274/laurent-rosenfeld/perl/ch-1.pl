use strict;
use warnings;
use feature 'say';

sub goat_latin {
    my $in = shift;
    my %vowels = map {$_ => 1} qw<a e i o u A E I O U>;
    my @out;
    my $wc = 0;
    for my $word (split /\s+/, $in) {
        $wc++;
        unless (defined $vowels{substr $word, 0, 1}) {
            $word = (substr $word, 1) . (substr $word, 0, 1);
        }
        $word .= "ma";
        $word .= 'a' x  $wc;
        push @out, $word;
    }
    return join " ", @out;
}
my @tests = ("I love Perl", "Perl and Raku are friends", "The Weekly Challenge");
for my $test (@tests) {
    say "English: $test";
    say "Goat Latin: ", goat_latin $test;
    say "-----";
}
