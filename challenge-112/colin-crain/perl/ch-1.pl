#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       where-am-i-where-are-my-friends.pl
#
#         Canonical Path
#         Submitted by: Mohammad S Anwar
#         You are given a string path, starting with a slash ‘/'.
# 
#         Write a script to convert the given absolute path to the simplified
#         canonical path.
# 
#         In a Unix-style file system:
# 
#         - A period '.' refers to the current directory
#         - A double period '..' refers to the directory up a level
#         - Multiple consecutive slashes ('//') are treated as a single slash '/'
#         The canonical path format:
# 
#         - The path starts with a single slash '/'.
#         - Any two directories are separated by a single slash '/'.
#         - The path does not end with a trailing '/'.
#         - The path only contains the directories on the path from the root
#         directory to the target file or directory
#  
#         Example
#             Input: "/a/"
#             Output: "/a"
# 
#             Input: "/a/b//c/"
#             Output: "/a/b/c"
# 
#             Input: "/a/b/c/../.."
#             Output: "/a"
# 
#         method
#             converting to a canonical path form is not quite as simple as
#             restructuring dot file notaion into real directories and
#             normalizing superfluous chaff such as '//', because a canonical
#             path is always an absolute path and the relative path given may
#             not be.
# 
#             Fortunately for us today we are defined as having been given an
#             absolute path, sidestepping that mess. 
# 
#             However a canonical path also resolves soft links, which remains a 
#             difficulty, as Perl is not a shell. There are ways involving a module
#             to address this, but I'm going to assume this edge case is outside
#             the scope of the problem.
# 
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

use Cwd qw( abs_path );



sub canonical ($path) {
    $path =~ s{/\.?/}{/}g;
    $path =~ s{/$}{};
    
    my @parts = split '/', $path;
    my $pos = 0;
    while (++$pos < @parts) {   
        if ($parts[$pos] eq '..') {
            splice @parts, $pos-1, 2;
            $pos -= 2;            
        }
    }
    join '/', @parts;
}

# this will resolve relative paths, and soft links, from the cwd, which doesn't
# really solve that problem in a general way. We need to `chdir` over to 
# the place in question, which would need to both exist and have the right permissions. 
# The whole thing is a bit of a mess, really, and I don't think that's what Mohammad is
# asking of us. 

sub canonical_softlinks ($path) {
    chdir $path;
    return abs_path( $path );
}

## resolving the link from d -> e
## yields /Users/colincrain/a/b/c/e

my $path = '../../a/b/c/f/../d';
say canonical_softlinks( $path );



use Test::More;

is canonical("/a/"), "/a"             , 'ex-1';
is canonical("/a/b//c/"), "/a/b/c"    , 'ex-2';
is canonical("/a/b/c/../.."), "/a"    , 'ex-3';

done_testing();

