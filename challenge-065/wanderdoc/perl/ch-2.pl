#!perl
use strict;
use warnings FATAL => qw(all);

# Challenge:
# You are given a string $S. Write a script print all possible partitions that gives Palindrome. Return -1 if none found.
# Please make sure, partition should not overlap. For example, for given string "abaab", the partition "aba" and "baab" would not be valid, since they overlap.

# Example 1
# Input: $S = 'aabaab'
# Ouput: 'aa', 'baab'


# Example 2
# Input: $S = 'abbaba'
# Output:
 # There are 2 possible solutions.
 # a) 'abba'
 # b) 'bb', 'aba'



use List::Util qw(sum);
use Getopt::Long;
use Pod::Usage;

my $message_text = <<"OUT";
Usage: script [flags] string.
Flags: 
--i 0|1 consider or not solutions that are not complete partitions of the string.
--s 0|1 consider or not single letters as a part of the solution.
--h read this message
OUT



my %opts = (incomplete_partitions => 1, single_letters => 0,);



GetOptions( \%opts, 
     'incomplete_partitions|i=i', 
     'single_letters|s=i',
     'help|h'
) or die pod2usage({ -message => $message_text ,
             -exitval => 2,  
             -verbose => 0,  
             -output  => \*STDERR });

pod2usage($message_text) if $opts{help};

my $string = shift or die pod2usage("No string provided!");


sub is_palindrome { return ($_[0] eq reverse $_[0]); }



sub deep_copy
{
     my $aref = shift;
     my @arr = @$aref;
     return [@arr];
}



sub solve
{
     my ($str, $start, $solution, $all) = @_; 

     if ( $start == length($str) )
     {
          my $s = deep_copy($solution);
          push @$all, $s; 

     }
     for my $idx ( $start   .. length($str) ) 
     {
          if (is_palindrome(substr($str, $start, $idx - $start + 1)))
          {
               push @$solution, substr($str, $start, $idx - $start + 1);
               solve($str, $idx + 1, $solution, $all); 
               pop @$solution;

          }
     }
}

sub find_palindrome_substrings
{
     my $string = $_[0];
     my @sols;

     my $strlen = length($string);
     solve($string, 0, [], \@sols);
     if ($opts{single_letters} == 0 ) { filter_out_single_letters(\@sols); }
     if ($opts{incomplete_partitions} == 0) {filter_out_incomplete_partitions(\@sols, $strlen); }
     if ( scalar @sols )
     {
          my $counter = qq[a];
          print $counter++, ") ", join(" ", @$_), $/ for @sols;
     }

     else
     {
          print -1;
     }
}




sub filter_out_single_letters
{
     @{$_[0]} = grep {@$_ = grep { length > 1 } @$_} @{$_[0]};
}

sub filter_out_incomplete_partitions
{
     @{$_[0]} = grep {sum(map {sum(length)} @$_) == $_[1]} @{$_[0]};
}


find_palindrome_substrings($string);