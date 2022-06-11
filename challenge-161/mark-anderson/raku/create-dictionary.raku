#!/usr/bin/env raku

use HTTP::UserAgent :simple;
use DOM::Tiny;

my $url = 'https://github.com/manwar/perlweeklychallenge-club/blob/master/data/dictionary.txt';

getstore($url, 'dictionary.html') unless 'dictionary.html'.IO.e;
 
unless 'dictionary.txt'.IO.e
{
    put 'Be patient - this takes a while...';

    my $dom = DOM::Tiny.parse('dictionary.html'.IO.slurp);

    if my $fh = open 'dictionary.txt', :w 
    { 
        for $dom.find('td') -> $e 
        {
            $fh.put: $e.text if $e.text ~~ /\S/;
        }
        
        $fh.close;
    }
}
