package pw96;

use strict;
use warnings;

use Moo;

sub reverse_words {
    my ($self, $phrase) = @_;
    
    my @words = split ' ', $phrase;
    return join ' ', reverse @words;
}


1;

