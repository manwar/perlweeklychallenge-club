#!/usr/bin/env raku
#`{
-----------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-03-25
Challenge 209 Merge Account ( Raku )
-----------------------------------------
}
use v6;

#my @accounts = [ ["A", "a1\@a.com", "a2\@a.com"], ["B", "b1\@b.com"], ["A", "a3\@a.com", "a1\@a.com"] ];

my @accounts = [ ["A", "a1\@a.com", "a2\@a.com"], ["B", "b1\@b.com"], ["A", "a3\@a.com"], ["B", "b2\@b.com", "b1\@b.com"] ];

my @a = ();
my @temp = ();
my @b = ();

print "Input: ";

print "[";
for (@accounts) -> @sub {
    print "[",@sub,"] ";
    my $ln = @sub.elems - 1;
    if @sub[0] eq 'A' {
        @a.push(@sub[1..*]);
    }
    if @sub[0] eq 'B' {
        @b.push(@sub[1..*]);
    }

}
say "] ";

print "Output: ";
print "[[A ";
print @a.unique;
say "]";

print "        [B ";
print @b.unique;
say "]]";

#`{
-----------------------------------------
SAMPLE OUTPUT
raku .\MergeAccount.rk
Input: [[A a1@a.com a2@a.com] [B b1@b.com] [A a3@a.com a1@a.com] ]
Output: [[A a1@a.com a2@a.com a3@a.com a1@a.com]
        [B b1@b.com]]

PS G:\Projects\Perl\Challenges> raku .\MergeAccount.rk
Input: [[A a1@a.com a2@a.com] [B b1@b.com] [A a3@a.com] [B b2@b.com b1@b.com] ]
Output: [[A a1@a.com a2@a.com a3@a.com]
        [B b1@b.com b2@b.com b1@b.com]]
-----------------------------------------
}
