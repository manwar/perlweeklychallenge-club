#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       garden-variety-path.pl
#
#         Common Path
#         Submitted by: Julien Fiegehenn
# 
#         Given a list of absolute Linux file paths, determine the deepest
#         path to the directory that contains all of them.
# 
#         Example
# 
#         Input:
#             /a/b/c/1/x.pl
#             /a/b/c/d/e/2/x.pl
#             /a/b/c/d/3/x.pl
#             /a/b/c/4/x.pl
#             /a/b/c/d/5/x.pl
# 
#         Ouput:
#             /a/b/c

#         method:
# 
#         Years ago, a mentor once said to me about Unix: "It's a just text".
# 
#         In the spirit of that sentement, instead of setting up a parallel
#         abstraction of a filesystem using hashes, and descending until we
#         find the first hash with more than one key, we'll do something
#         completely different: we'll parse the strings with regular
#         expressions.

#         How? Well the rootmost directory in all the strings will be
#         common to everystring, right? Or at least that's the idea. So why
#         don't we  pass over all the strings, locate the topmost directory
#         and substitute it out from every string? This shortens all the
#         strings and we go again. If we get through every string
#         substitution sucessfully, we add that root part to an output, but
#         if we ever fail a match then we have found a divergent path. We
#         then opt out and whatever root part we've gathered is our result. 

#         Some caveats: first we're going to assume we have been given a
#         set of well-constructed absolute paths. Meaning no relative
#         portions in the form of backtracking or no-ops with dot
#         directories. And no links either, hard or soft, to complicate
#         things. Not really sure how that'd work but let's disqualify them
#         outright anyway so I don't have to think it through. Every
#         directory we see will be assumed to be exactly what it says it
#         is.
# 
#         And no pathological directory names designed specifically to
#         break the regex. Just no. I'm tired and want to have a little fun
#         for change. 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##




use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my @files = qw(
                /a/b/c/1/x.pl
                /a/b/c/d/e/2/x.pl
                /a/b/c/d/3/x.pl
                /a/b/c/4/x.pl
                /a/b/c/d/5/x.pl                 
            );

my $common = '';
my $root;

LOOP: while () {
    $files[0] =~ m| (/?[^/]+) |x or last;
    $root     = $1;
    s/$root// or last LOOP for @files;
    $common  .= $root;
}

say $common;



