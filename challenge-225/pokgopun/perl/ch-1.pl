### Task 1: Max Words
### Submitted by: Mohammad S Anwar
### You are given a list of sentences, @list.
### 
### 
### A sentence is a list of words that are separated by a single space with no leading or trailing spaces.
### 
### 
### Write a script to find out the maximum number of words that appear in a single sentence.
### 
### Example 1
### Input: @list = ("Perl and Raku belong to the same family.",
###                 "I love Perl.",
###                 "The Perl and Raku Conference.")
### Output: 8
### Example 2
### Input: @list = ("The Weekly Challenge.",
###                 "Python is the most popular guest language.",
###                 "Team PWC has over 300 members.")
### Output: 7
#
#
#
use strict;
use warnings;

my @list = @ARGV ? @ARGV :

("Perl and Raku belong to the same family.",
"I love Perl.",
"The Perl and Raku Conference."
);
#("The Weekly Challenge.",
#"Python is the most popular guest language.",
#"Team PWC has over 300 members."
#);

my @sort = sort map{ scalar(split /\s/, $_) } @list;
## use Data::Dumper;
## print Dumper \@sort;
## exit(0);

printf(
	"Input: \@list = (%s)\nOutput: %d\n",
	join( ",\n"." "x16, map{ '"'.$_.'"' } @list ),
	$sort[-1]
);

