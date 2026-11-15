#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# Copyright (c) 2026, Bob Lied
#=============================================================================
# ch-2.pl Perl Weekly Challenge 399 Task 2  Longest Absolute Path
#=============================================================================
# You are given a filesystem as string.  Write a script to return the length
# of the longest absolute path to a file in the abstracted file system. If
# there is no file in the system, return 0.
#   dir
#   - subdir1
#     - file1.ext
#     - subsubdir1
#   - subdir2
#     - subsubdir2
#       - file2.ext
# The above filesystem can be represented as below:
# "dir\n\tsubdir1\n\t\tfile1.ext\n\t\tsubsubdir1\n\tsubdir2\n\t\tsubsubdir2\n\t\t\tfile2.ext"
#
# Example 1 Input: $fs = "dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"
#           Output: 0
#   There are no files in the system (a file must contain a . character
#   separating a name and extension).  Since there are no files, the answer is 0.
#
# Example 2 Input: $fs = "file1.txt\nfile2.ext\na.png"
#           Output: 9
#   All entries are located at root depth (0 tabs).  Found File Paths:
#   "file1.txt" (length = 9) "file2.ext" (length = 9) "a.png" (length = 5)
#   The longest absolute file path length is 9.
#
# Example 3 Input: $fs = "my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"
#           Output: 38
#   Notice project v1.0 is a directory (it has children beneath it), while
#   notes v1.txt and image.png are files.  Found File Paths:
#   "my documents/project v1.0/notes v1.txt" (length = 38)
#   "my documents/image.png" (length = 22)
#
# Example 4 Input: $fs = "root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt"
#           Output: 14
#   Found File Paths:
#   "root/a/b/c.txt" => 4 + 1 + 1 + 1 + 1 + 1 + 5 = 14
#   "root/d/e.txt"   => 4 + 1 + 1 + 1 + 5 = 12
#
# Example 5 Input: $fs = "a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"
#           Output: 32
#   Found File Paths:
#   "a/b/c/d/e.txt" => 1 + 1 + 1 + 1 + 1 + 1 + 1 + 1 + 5 = 13
#   "a/very_long_directory_name/f.txt" => 1 + 1 + 24 + 1 + 5 = 32
#=============================================================================

use v5.44;
use List::Util qw/sum0/;


use Getopt::Long;
my $Verbose = false;
my $DoTest  = false;

GetOptions("test" => \$DoTest, "verbose" => \$Verbose);
my $logger;
{
    use Log::Log4perl qw(:easy);
    Log::Log4perl->easy_init({ level => ($Verbose ? $DEBUG : $INFO ),
            layout => "%d{HH:mm:ss.SSS} %p{1} %m%n" });
    $logger = Log::Log4perl->get_logger();
}
#=============================================================================

exit(!runTest()) if $DoTest;

if ( @ARGV ) { say task($_) for @ARGV }
else
{
    local $/;
    my $fs = <STDIN>;
    say task($fs);
}

#=============================================================================
use feature 'class'; no warnings "experimental::class";
# Nodes in a directory tree. Each Node can have a list of children.

class Node
{
    field $name   :param :reader;
    field $depth  :param :reader = 0;
    field $parent :param :reader = undef;

    field @children;
    method getChildren() { return \@children }

    use overload '""' => sub { $_[0]->show() };
    method show() {
        return (" " x $depth) . "[$depth] $name";
    }
    method dump() {
        my $s = $self->show();
        $s .= "\n" . $_->dump for @children;
        return $s;
    }

    method addChild($name) {
        my $c = Node->new(name => $name, depth => $depth +1, parent => $self);
        push @children, $c;
        return $c;
    }

    method isFile() { return @children == 0 && index($name, ".") >= 0  }

    method findLongest()
    {
        my $longest = 0;
        my @queue = ( [$self, -1] );

        while ( defined(my $x = shift @queue) )
        {
            my ($node, $sofar) = $x->@*;
            $logger->debug("FIND: sofar=$sofar node=$node");

            if ( $node->isFile )
            {
                my $len = $sofar + length($node->name);
                $logger->debug("FIND: FOUND FILE $len/$longest $node");
                $longest = $len if $len > $longest;
                next;
            }

            for my $child ( $node->getChildren->@* )
            {
                $logger->debug("FIND: push $child");
                # Add 1 for the / separator
                push @queue, [ $child, $sofar + 1 + length($node->name) ];
            }
        }
        return $longest;
    }
}
#=============================================================================

sub task($fs)
{
    my $node = my $root = Node->new(name => "");

    # Build a tree structure from the input text.
    for my $line ( split(/\n/, $fs) )
    {
        # Split on tab characters tells us how far down the tree we are
        # by creating empty fields. The name is the last element in the split.
        my @level = split(/\t/, $line);
        my $name = $level[-1];

        $logger->debug("LINE: $line | ", scalar(@level) );

        if    ( @level  > $node->depth() )  # Descending deeper
        {
            $node = $node->addChild($name);
        }
        elsif ( @level == $node->depth() )  # Sibling at same level
        {
            $node = $node->parent->addChild($name);
        }
        else    # Move back up the tree
        {
            $node = $node->parent while ( $node->depth >= @level );
            $node = $node->addChild($name);
        }
        $logger->debug("TREE: ", $root->dump);
    }
    return $root->findLongest();
}

sub runTest
{
    use Test2::V1 -ipP;

    is( task("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"), 0, "Example 1");
    is( task("file1.txt\nfile2.ext\na.png"), 9, "Example 2");
    is( task("my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"), 38, "Example 3");
    is( task("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt"), 14, "Example 4");
    is( task("a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"), 32, "Example 5");

    done_testing;
}
