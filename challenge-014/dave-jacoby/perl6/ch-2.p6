#!/usr/bin/env perl6

# My first Perl6 entry!

# This took a bit. First I had to wipe and redo my rakudobrew, 
# because I pull out Perl 6 once every two years or so. Looking
# at Damian Conway's Perl 6 solutions, I can't help but think this
# is "baby perl 6" (which I'm sure Larry would say is okay), but
# there's a command or two that solve everything, as long as you
# throw away decades of mental models to get there.

# I did a qw{} in Perl 5, but I was afraid and just made the 
# array myself here.


my %states = map { $_ => 1 } , 
    "AL","AK","AZ","AR","CA","CO","CT","DE","FL","GA",
    "HI","ID","IL","IN","IA","KS","KY","LA","ME","MD",
    "MA","MI","MN","MS","MO","MT","NE","NV","NH","NJ",
    "NM","NY","NC","ND","OH","OK","OR","PA","RI","SC",
    "CD","TN","TX","UT","VT","VA","WA","WV","WI","WY";

my @words = '/usr/share/dict/words'.IO.lines;

# when testing, use a smaller data set
# @words = "PACT","WIND","PERL","CALAMARI"; 

my $longest = '';
MAIN: for @words -> $word {
    my @word = $word ~~ m:g/\w ** 2/;

    my $join = @word.join('');
    next if $join ne $word;

    for @word -> $wo {
        my $n = %states{$wo.uc} ?? 1 !! 0;
        next MAIN unless $n;
    }

    $longest = $word if $longest.chars < $word.chars;
    }

say $longest;

# the word-list I have here is smaller than the one I have on my 
# laptop, so the longest word I have is "Concorde", being
#   Colorado
#   North Carolina
#   Oregon
#   Delaware

# but my Perl 5 version gets the same, so ¯\_(ツ)_/¯

# I am disappointed by the speed drop, tho