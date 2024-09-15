=begin 
You are given two list of integers, @list1 and @list2. The elements in the @list2 are distinct and also in the @list1.

Write a script to sort the elements in the @list1 such that the relative order of items in @list1 is same as in the @list2. Elements that is missing in @list2 should be placed at the end of @list1 in ascending order.

Example 1
Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
       @list2 = (2, 1, 4, 3, 5, 6)
Ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)
Example 2
Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
       @list2 = (1, 3, 2)
Ouput: (1, 3, 3, 3, 2, 2, 4, 4, 6)
Example 3
Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
       @list2 = (1, 0, 3, 2)
Ouput: (1, 1, 1, 0, 0, 3, 2, 4, 5)
=cut

use strict;
use Data::Dumper;


my @A = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5);
my @B = (2, 1, 4, 3, 5, 6);

my @result = customSort(\@A,\@B);
print join(" ",@result)."\n";

my @A = (3, 3, 4, 6, 2, 4, 2, 1, 3);
my @B = (1, 3, 2);
my @result = customSort(\@A,\@B);
print join(" ",@result)."\n";

my @A = (3, 0, 5, 0, 2, 1, 4, 1, 1);
my @B = (1, 0, 3, 2);
my @result = customSort(\@A,\@B);
print join(" ",@result)."\n";

sub customSort {
  my ($arr1,$arr2) = @_;

  my @list1 = @$arr1;
  my @list2 = @$arr2;

  my %set1 = createSet(\@list1);
  my @sorted;
  foreach(@list2){
    if(exists($set1{$_})){
      push @sorted,$_;
      if(($set1{$_}) > 1){
        for(my $i=1;$i<(scalar($set1{$_}));$i++){
          push @sorted,$_;
        }
      }
      delete $set1{$_};
    }
  }

  foreach(sort {$a<=>$b} keys %set1){
      push @sorted,$_;
      if(($set1{$_}) > 1){
        for(my $i=1;$i<(scalar($set1{$_}));$i++){
          push @sorted,$_;
        }
      }
  }
  #print join(" ",@sorted)."\n";
  return @sorted;

}

sub createSet {
  my $input = shift;
  my @A = @$input;
  my %_set;
  foreach(@A){
    if(exists($_set{$_})){
      $_set{$_} += 1;
    }else{
      $_set{$_} = 1;
    }
  }

  return %_set;
}
