#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 182 Task 2 Common Path
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# Given a list of absolute Linux file paths, determine the deepest path
# to the directory that contains all of them.
# Example Input: /a/b/c/1/x.pl
#                /a/b/c/d/e/2/x.pl
#                /a/b/c/d/3/x.pl
#                /a/b/c/4/x.pl
#                /a/b/c/d/5/x.pl
#         Ouput: /a/b/c
#
# We are going to infer that "absolute" means that the paths are
# always full paths, starting from "/". That implies that "/" will
# always be common to all the paths.
#=============================================================================

use v5.36;

use Getopt::Long;
my $Verbose = 0;
my $DoTest  = 0;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
exit(!runTest()) if $DoTest;

# Allow a file name as an argument, or read standard input.
my $fh = *STDIN;
if ( @ARGV )
{
    open($fh, '<', $ARGV[0]) || die "can't open $ARGV[0], $!";
}

say commonPath( parseInput($fh) );

# Open a string as a file handle, to allow testing without depending
# on extra files.
sub parseInputFromString($s)
{
    open(my $fh, "<", \$s) || die "open input string failed, $!";
    return parseInput($fh);
}

# Read the list of inputs and return an array of path segments,
# Example:
#   /a/b/d      [ [ 'a', 'b', 'd' ],
#   /a/b/f        [ 'a', 'b', 'f' ] ]
sub parseInput($fh)
{
    # String input has some extra white space around it.
    # Opportunity to use a v5.36 feature.
    use builtin qw/trim/; no warnings 'experimental::builtin';

    my @pathList = ();  # Don't trip over undef
    while ( <$fh> )
    {
        push @pathList, [ split '/', trim($_) ];
    }
    return \@pathList;
}

sub commonPath($pathList)
{
    use List::Util qw/all min/;

    return '' if scalar(@$pathList) == 0;

    my $depth = 0;

    # We only have to go as deep as the shortest path.
    my $maxDepth = (min map { scalar(@$_) } $pathList->@* );

    # We go deeper as long as all paths are the same at this depth.
    # The map takes a vertical column slice out of the pathList array.
    $depth++ while ( $depth < $maxDepth &&
                     all { $_ eq $pathList->[0][$depth] }
                        map { $_->[$depth] } $pathList->@* );

    return "/".join("/", $pathList->[0]->@[1..$depth-1]);
}

sub runTest
{
    use Test2::V0;

    my @TestCase = (
        { in => '/a/b/c/1/x.pl
                 /a/b/c/d/e/2/x.pl
                 /a/b/c/d/3/x.pl
                 /a/b/c/4/x.pl
                 /a/b/c/d/5/x.pl ',
          out => '/a/b/c',
          desc => "Example"
        },
        { in => '/a/b/c
                 /b/c/d
                 /d/e/f ',
          out => '/',
          desc => "Root only"
        },
        { in => '/a/b
                 /a/b',
          out => '/a/b',
          desc => 'Identical'
        },
        { in => '/a a/b/c
                 /a a/b c/d',
          out => '/a a',
          desc => 'White space'
        },
        { in => '/a/b/c',
          out => '/a/b/c',
          desc => "Singleton"
        },
        { in => '',
          out => '',
          desc => "Empty list"
        },
    );

    for my $t ( 0 .. $#TestCase )
    {
        my $test = $TestCase[$t];
        is( commonPath( parseInputFromString($test->{in}) ), $test->{out}, $test->{desc} );
    }

    done_testing;
}

