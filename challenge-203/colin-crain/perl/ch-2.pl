#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       copy.pl
#
#       Copy Directory
#         Submitted by: Julien Fiegehenn
#         You are given path to two folders, $source and $target.
# 
#         Write a script that recursively copy the directory from $source
#         to $target except any files.
# 
# 
#         Example
#             Input: $source = '/a/b/c' and $target = '/x/y'
# 
#             Source directory structure:
# 
#             ├── a
#             │   └── b
#             │       └── c
#             │           ├── 1
#             │           │   └── 1.txt
#             │           ├── 2
#             │           │   └── 2.txt
#             │           ├── 3
#             │           │   └── 3.txt
#             │           ├── 4
#             │           └── 5
#             │               └── 5.txt
# 
#             Target directory structure:
# 
#             ├── x
#             │   └── y
# 
#             Expected Result:
# 
#             ├── x
#             │   └── y
#             |       ├── 1
#             │       ├── 2
#             │       ├── 3
#             │       ├── 4
#             │       └── 5
#
#             method
# 
#             Any complexities in either the source or target directory
#             trees is inconsequntial and misdirectiion. The real trick
#             here is the recursion, which is not demonstrated in the
#             example.
# 
#             As understand, if we were given the source '/a/b', then we
#             would start copying into 'x/y' from there, but entering any
#             directories found and creating whatever directories required,
#             and following those too, until the tree branch is exhausted.
#             The result, using the same notation, would be:
# 
#             ├── x
#             │   └── y
#             │       └── c
#             │           ├── 1
#             │           ├── 2
#             │           ├── 3
#             │           ├── 4
#             │           └── 5
# 
#             As you can see we have entered /c/ and found the five further directories 
#             named with the numbers: /c/1/, /c/2/, /c/3/, etc. 
# 
#             Because we have no idea how far we need to go, a recursive
#             routine is a natural fit. Because we will be altering the existing filesystem 
#             environment, there is no need to return anything, only to
#             keep track of our two entry points: that of the structure we are
#             duplicating, and the place we are affixing the structure we
#             find.
# 

#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $source = q(/a/b/c);
my $target = q(/x/y);

duplicate_dirs ( $source, $target ) ;


sub duplicate_dirs ( $source, $target ) {
## scan the $source directory and make and directories found there in the $target
## directory
    return if not -d $source;
    
    opendir(my $dh, $source) || die "Cannot opendir $source: $!";
    my @dirs = grep { -d "$source/$_" && ! /^\.$|^..$/ } readdir($dh);
    closedir $dh;

    for my $dir ( @dirs ) {
        mkdir "$target/$dir";
        duplicate_dirs( "$source/$dir", "$target/$dir" );
    }
}




