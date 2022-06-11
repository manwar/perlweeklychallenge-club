#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       .pl
#
#       Abecedarian Words
#         Submitted by: Ryan J Thompson
# 
#         An abecedarian word is a word whose letters are arranged in
#         alphabetical order. For example, “knotty” is an abecedarian word,
#         but “knots” is not. Output or return a list of all abecedarian
#         words in the dictionary, sorted in decreasing order of length.
# 
#         https://github.com/manwar/perlweeklychallenge-club
#           /blob/master/data/dictionary.txt
# 
#         Optionally, using only abecedarian words, leave a short comment
#         in your code to make your reviewer smile.
# 
#
#       commentary:

#         Oooh... Lot's of layers to unravel before we get to that sweet,
#         sweet Tootsie Roll core. How many licks *will* it take to get
#         there?
# 
#         Let's begin at the beginning: we are given a dictionary to use,
#         at a github link. This is all well and good, but the dictionary
#         lnk is to the user interface web-page to the data repository, not
#         the actual data. Sneaky. I propose we solve this one by social
#         engineering: we'll visit the page and click the "Raw" link, then
#         note the URL of the underlying data. This takes us to 
#         
#         https://raw.githubusercontent.com/manwar/perlweeklychallenge-club
#           /master/data/dictionary.txt
# 
#         We'll start there instead. It's an interesting word-list in that
#         it only has 39172 entries, far fewer than /usr/share/dict and a
#         tenth the size of a scrabble dictionary. I wonder where it comes
#         from? But no mind.
# 
#         We'll get `LWP::Simple` to suck it down for us. This module
#         supplies `get`, which will get the data at the url for us. They
#         might have named it LWP::DeadSimple. Has a nice ring to it. 
# 
#         Data now in hand, we could open a filehandle on it, which is
#         neat, and use `readline`, or angle brackets, to process one line,
#         and hence one word, at a time. We *would* have to use `chomp` but
#         this would work but more so frankly that's not the way I do
#         things. It's cool and all, but when I see text that need dicing I
#         reach for a regular expressions.
# 
#         In this case globally matching and capturing anything not a
#         newline, then matching but not capturing the newline, will do the
#         trick. The match is just the word and stored in $1
# 
# 
        

#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use LWP::Simple qw( get ) ;

my $url = 'https://raw.githubusercontent.com/manwar/perlweeklychallenge-club/master/data/dictionary.txt';
my $dict = get($url);


my @abcs;

while ( $dict =~ /(.*)\n/g ) {
        push @abcs, $1 if abc( $1 );
}

say for sort {  length $b <=> length $a 
                    ||
                $a cmp $b } @abcs;


sub abc ($word, $i = 0) {
    $i = (length $word) - 1;
    substr ($word, $i, 1) lt substr ($word, --$i, 1) and return 0 while $i;
    return 1;
}


