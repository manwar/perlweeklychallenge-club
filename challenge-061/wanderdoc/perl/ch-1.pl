#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Given a list of 4 or more numbers, write a script to find the contiguous sublist that has the maximum product. The length of the sublist is irrelevant; your job is to maximize the product.
Example
Input: [ 2, 5, -1, 3 ]
Output: [ 2, 5 ] which gives maximum product 10.
=cut






# Assumptions: negative numbers are considered, 
# there is at least one positive number in the list.

use List::Util qw(reduce);
my $MIN = -1E9;

my @input = (2, 5, -1, 3, -1, 2, 10, -1, 1000); # (2, 3, -1, 5, -2, -3, 7, 9, 11, 0, -2, 1, 1, 1, 1 ,100 ); # (0, 1, -1, -2);# 
my ($max_prod, $sublist_pos) = find_sublist(@input);


if ( $max_prod > $MIN )
{
     my @sublist = @input[split(/ /, $sublist_pos)];
     print "<@sublist> on indexes <${sublist_pos}> makes ${max_prod} as maximal product.$/";
}

sub find_sublist
{
     my @array = @_;
     my $max = -1E9;

     my %signs;


     $signs{sign($_)}++ for @array;
     die "At least one positive number required!$/" unless exists $signs{1};


     # Special case: complete list.
     unless (exists $signs{0} )
     {
          if ( $signs{1} == scalar @array or $signs{-1} % 2 == 0 )

          {
               $max = reduce {$a * $b} @array;
               my $idx_list = join(" ", 0 .. $#array);
               return ($max, $idx_list);

          }
     }


     # Partitioning of the elements with the same sign.

     my @partition;
     my @part;
     for my $idx ( 0 .. $#array )

     {
          if ( 0 == scalar @part )

          {
               push @part, $idx;
          }
          elsif (same_sign($array[$part[-1]], $array[$idx]))
          {
               push @part, $idx;

          }

          else
          {
               push @partition, [@part];
               @part = ();
               push @part, $idx;
          }
          if ( $idx == $#array )
          {

               push @partition, [@part];
          }
     }

     # Products of parts.
     my %sub_prods = map {$_ => reduce {$a * $b} @array[@{$partition[$_]}] } 
          0 .. $#partition;


     # Combinations of these products.
     my $max_path = '';
     for my $idx_1 (0 .. $#partition)
     {
          next if ( $sub_prods{$idx_1} == 0 );

          for my $idx_2 ($idx_1 .. $#partition)
          {


               my $this_prod = reduce {$a * $b} @{sub_prods}{$idx_1 .. $idx_2};
               if ( $this_prod > $max )
               {
                    $max = $this_prod;
                    $max_path = reduce {$a . " " . $b} map @$_, @partition[$idx_1 .. $idx_2];
               }
          }
     }

     return ($max, $max_path);

}
sub sign {return $_[0] > 0 ? 1 : $_[0] < 0 ? - 1 : 0;}
sub same_sign
{
     return $_[0]*$_[1] > 0;
}