#/usr/bin/env perl

#`{

AUTHOR: Robert DiCicco

DATE  : 2023-02-08

Challenge 203 Copy Directory ( Raku )

}



use File::Find;

#use IO::Spec::Unix;



my $startdir = $*CWD;

"startdir = $startdir".say;

my $dirs = "a/b/c";                 # source directory structure

my $target = "x/y";                 # target directory structure



"Creating source directory structure".say;



for (1..5) -> $numdir {

    mkdir ("$dirs/$numdir");

}



"\tcreated a/b/c".say;



chdir $dirs;



"Creating source files".say;

my @files = ("1/1.txt","2/2.txt","3/3.txt","5/5.txt");



for (@files) {

    my $fh = open "$_", :w;

    "\tcreated $_".say;

    close $fh;

}



chdir $startdir;



"Creating target directory structure".say;



my @list = find(dir => $dirs, type => 'dir');

for (@list) -> $dl {

    #my $test= $dl.basename;

    #mkdir "$target/$test";

    mkdir "$target/" ~ $dl.basename;

    print "\tcreating $target/" ~ $dl.basename ~ "\n";

}

"complete".say;



#`{

SAMPLE OUTPUT

raku .\CopyDirectory.rk

startdir = G:\Projects\Perl\Challenges

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

}
