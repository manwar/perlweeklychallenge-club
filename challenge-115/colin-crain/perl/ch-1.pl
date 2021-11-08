#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       string_cheese.pl
#
#       String Chain
#         Submitted by: Mohammad S Anwar
#         You are given an array of strings.
# 
#         Write a script to find out if the given strings can be chained to form
#         a circle. Print 1 if found otherwise 0.
# 
#         A string $S can be put before another string $T in circle if the last
#         character of $S is same as first character of $T.
# 
#         Examples:
#         Input: @S = ("abc", "dea", "cd")
#         Output: 1 as we can form circle e.g. "abc", "cd", "dea".
# 
#         Input: @S = ("ade", "cbd", "fgh")
#         Output: 0 as we can't form circle.
# 
#         METHOD:
#             this is more complex than it seems, because there seems to be no
#             limit on the strings or their letters. Multiple strings can start or
#             end with the same letter, giving multiple pathway options that will
#             all need to be explored.
# 
#             Although not expressly stated, I'm going to assume *every* string
#             will need to be connected in this chain for now. Maybe it makes
#             sense to make this configurable. 
# 
#             One aspect that works in our favor is the circle: we only care if
#             all the strings can be chained, so consequently the circle is
#             equivalent at all points. This means we can start looking for the
#             chain at any point. 
# 
#             therefore we'll start at the first string, and grep the array to
#             find all strings the start with the same letter. For each of these
#             strings we will try adding it to a partial chain and removing it
#             from the list of remaining possibilites. The partial chain and
#             remaining possibilites are then passed along recursively to repeat
#             the step.
# 
#             The exit case is when there are no more valid possibilities to
#             link to. When that happens, if the total list is still has strings
#             init the chain has failed. If we've linked the last sring and that
#             string can link to our first element then we have discovered the
#             chain.
#
#             Strings can be of any length. In a single letter string the first character
#             is the same as the last. 
#             
#             Strings can contain any character. As long as they match they'll chain. 
# 
#             There's no reason to exclude multiple instances of the same
#             string. This makes removing used instances from the running a
#             little more tricky than a simple `grep` but it's not too bad. We
#             could avoid using `first` by rolling our own iterator but
#             List::Util is core so why not. List::MoreUtils has `firstidx`,
#             which does exactly what we want, but its not core.
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use List::Util qw( first );

my @str = @ARGV;

if (scalar @str) {
    my $res = chain(\@str);
    say $res? $res : "no chain";
}

sub chain ($strings, $chain = []) {
    $chain->[0] = shift $strings->@* if not defined $chain->[0];
    
    ## base: if no more in pool check last loop link
    if (scalar $strings->@* == 0) {
        return join ' ', $chain->@* 
            if substr($chain->[-1], -1) eq substr($chain->[0], 0, 1);
        return undef;
    }

    my @next = grep { substr($chain->[-1], -1) eq substr($_, 0, 1) } $strings->@*;

    ## base: no next link and still more in pool fails
    return undef if @next == 0 and $strings->@* > 0;
    
    for my $link (@next) {
        my @possible = $strings->@*;
        my $idx = first { $possible[$_] eq $link } (0..$#possible);
        splice @possible, $idx, 1;
        
        my $result = chain( \@possible, [ $chain->@*, $link ] );

        return $result if defined $result;
    }
    return undef;
}








use Test::More;

is chain(["abc", "dea", "cd" ]), "abc cd dea",              'ex-1';
is chain(["ade", "cbd", "fgh"]), undef,                     'ex-2';
is chain(["abc", "dea", "cda"]), undef,                     'short loop';
is chain(["abc", "aea", "cda"]), "abc cda aea",             'multi first';
is chain(["abc", "abc", "cda", "cda"]), "abc cda abc cda",  'repeats';

done_testing();
