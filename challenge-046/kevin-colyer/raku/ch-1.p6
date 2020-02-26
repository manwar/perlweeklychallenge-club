#!/usr/bin/perl6
use v6;

use Test;


=begin pod

TASK #1
Cryptic Message
The communication system of an office is broken and message received are not completely reliable. To send message Hello, it ended up sending these following:

H x l 4 !
c e - l o
z e 6 l g
H W l v R
q 9 m # o
Similary another day we received a message repeatedly like below:

P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0
Write a script to decrypt the above repeated message (one message repeated 6 times).

HINT: Look for characters repeated in a particular position in all six messages received.

=end pod

# ok, it seems that if you look vertically down each column the there are two repeated characters. This marks the first letter (and so on) so message one is "Hello" and 2nd is "PerlRaku"
# so let's write a script for that!
my $message = 'H x l 4 !
c e - l o
z e 6 l g
H W l v R
q 9 m # o';
is unscramble($message),"Hello", "unscrambles ok";
$message='P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0';
is unscramble($message),"PerlRaku", "unscrambles ok";


sub unscramble($m) {
    my %seen;
    my $unscramble="";
    my @m;
    # make a 2d array
    # split by lines into an array
    # split lines on words (split by spaces) and coerce to a list then push into array
    for $m.lines {  @m.push( .words.list ) };
    # iterate through the columns using elems of row 0 as limit
    for ^@m[0].elems -> $c {
        my %seen;
        # count the number of seen letters on each row of selected column
        %seen{ @m[$_][$c] }++ for ^@m.elems;
        # filter the seen hash to get the key value of the item with count 2 and add to unscrambled message
        $unscramble~=%seen.grep( *.value==2)>>.key;
    }
    return $unscramble;
}
