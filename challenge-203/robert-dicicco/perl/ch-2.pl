# /usr/bin/env perl

# AUTHOR: Robert DiCicco

# DATE: 2023-02-08

# Challenge 203 Copy Directory ( Perl )

use strict;

use warnings;

use Path::Class;

use File::Basename;

use Cwd qw(cwd);

use File::Path qw(make_path);



my $startdir = cwd;                 # record our start point

print "startdir = $startdir\n";



my $dirs = "a/b/c";                 # source directory structure

my $target = "x/y";                 # target directory structure



print "Creating source directory structure\n";



# creating directories 1..5 undex a/b/c/

make_path("$dirs/1","$dirs/2", "$dirs/3", "$dirs/4", "$dirs/5");

print "\tcreated a/b/c\n";



chdir $dirs;    #"a/b/c/";



# creating source files

print "Creating source files\n";

my @files = ("1/1.txt","2/2.txt","3/3.txt","5/5.txt");



for (@files) {

    open(F, ">>$_")||die("Cannot create file:".$!);

    print "\tcreated $_\n";

    close(F);

}



chdir $startdir;



my $dd = dir("a","b","c");

my @list = $dd->children;          # get a list of all child dirs of a/b/c/



                                   # and copy them to x/y/

print "Creating target directory structure\n";

for my $d (@list) {

     my $bn = basename($d);

     print "\tcreating $target/$bn\n";

     mkdir("$target/$bn");

}

print "complete";





=begin pod

SAMPLE OUTPUT

perl .\CopyDirectory.pl

startdir = G:/Projects/Perl/Challenges

Creating source directory structure

        created a/b/c

Creating source files

        created 1/1.txt

        created 2/2.txt

        created 3/3.txt

        created 5/5.txt

Creating target directory structure

        creating x/y/1

        creating x/y/2

        creating x/y/3

        creating x/y/4

        creating x/y/5

complete

=cut
