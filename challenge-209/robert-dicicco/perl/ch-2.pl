#!/usr/bin/env perl
=begin comment
----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-25
Challenge 209 Merge Account ( Perl )
----------------------------------------
=cut
use strict;
use warnings;
use feature "say";
use List::Uniq ':all';

my $accounts = [ ["A", "a1\@a.com", "a2\@a.com"], ["B", "b1\@b.com"], ["A", "a3\@a.com", "a1\@a.com"] ];

#my $accounts = [ ["A", "a1\@a.com", "a2\@a.com"], ["B", "b1\@b.com"], ["A", "a3\@a.com"], ["B", "b2\@b.com", "b1\@b.com"] ];

my @a = ();
my @temp = ();
my @b = ();

print "Input: ";
for (@$accounts) {
     print "[@$_ ]";
}
say " ";
for (@$accounts) {
    my @sub = @{$_};
    my $ln = scalar @sub;
    $ln -= 1;
    if ($sub[0] eq 'A') {
        @temp = map { $_ } @sub[1..$ln];
        push(@a,@temp);
    }
    if ($sub[0] eq 'B') {
        @temp = map { $_ } @sub[1..$ln];
        push(@b,@temp);
    }
}

print "Output: ";
print "[[A ";
for (uniq(@a)) {
    print "$_ ";
}
print "]\n";

print "        [B ";
for (uniq(@b)) {
    print "$_ ";
}
print "]]\n";

=begin comment
----------------------------------------
SAMPLE OUTPUT
 perl .\MergeAccount.pl
 PS G:\Projects\Perl\Challenges> perl .\MergeAccount.pl
Input: [A a1@a.com a2@a.com ][B b1@b.com ][A a3@a.com a1@a.com ]
Output: [[A a1@a.com a2@a.com a3@a.com ]
        [B b1@b.com ]]

Input: [A a1@a.com a2@a.com ][B b1@b.com ][A a3@a.com ][B b2@b.com b1@b.com ]
Output: [[A a1@a.com a2@a.com a3@a.com ]
        [B b1@b.com b2@b.com ]]
=cut



