#!/usr/bin/env raku
# No errs? My first effort is all below, begin beers now. Hoot!

use HTTP::UserAgent;
use Data::Dump;

my $ua = HTTP::UserAgent.new;
$ua.timeout = 5;
my $url = "https://raw.githubusercontent.com/manwar/perlweeklychallenge-club/master/data/dictionary.txt";
my $response = $ua.get($url);
my $dict = do with $response {
    .is-success ?? .content !! die .status-line
}

my @abcd = ();

for $dict.lines -> $word {
    next unless $word ~~ /^<[a .. z]>**2..*$/;
    my $dorw = $word.split('', :skip-empty).sort.join('');
    @abcd.push($word) if $word eq $dorw;
}

sub print-cols(@wordlist) {
    for @wordlist -> $a, $b='', $c='', $d='', $e='', $f='', $g='', $h='' {
        printf "%-10s %-10s %-10s %-10s %-10s %-10s %-10s %-10s\n",
        $a, $b, $c, $d, $e, $f, $g, $h;
    }
}

print-cols(reverse sort &chars, @abcd);

