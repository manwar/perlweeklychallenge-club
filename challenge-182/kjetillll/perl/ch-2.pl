#!/usr/bin/perl
use List::Util qw(max uniq); use v5.10; use warnings; use strict;

my @paths = map s/\n//r, <>;

say compath(@paths);    

sub compath {
    my $l = max(map length,@_)-1;
    uniq(@_)==1 ? pop : compath( map s/(.{$l}).$/$1/r, @_ )
}


__END__

Example commands:

cat <<. > input.txt
/a/b/c/1/x.pl
/a/b/c/d/e/2/x.pl
/a/b/c/d/3/x.pl
/a/b/c/4/x.pl
/a/b/c/d/5/x.pl
.

perl ch-2.pl input.txt            #prints /a/b/c/
