use warnings;
use strict;

use v5.38;

sub random_word {
    open( my $fh, '<', 'ch-1.pl' );
    my @words;
    for (<$fh>) {
	chomp;
	grep { push @words, $_ } split ' ', $_;
    }
    my $idx = int( rand( scalar @words ) );
    say $words[ $idx ];
}

random_word();
