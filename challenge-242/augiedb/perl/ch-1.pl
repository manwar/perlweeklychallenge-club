use strict;
use warnings;

my @arr1 = (1,2,3);
my @arr2 = (2,4,6);
find_missing_members( \@arr1, \@arr2 );
find_missing_members( \@arr2, \@arr1 );

@arr1 = (1, 2, 3, 3);
@arr2 = (1, 1, 2, 2);
find_missing_members( \@arr1, \@arr2 );
find_missing_members( \@arr2, \@arr1 );

sub find_missing_members {

  my @arr1 = @{ shift() };
  my @arr2 = @{ shift() };

  my @missing_from_second; 
  my %second_values;

  map{ $second_values{$_} = 1; } @arr2;

  @missing_from_second = grep{ 
    !$second_values{$_}; 
  } @arr1;

  print pretty_print_array(@arr1);
  print " has ";
  print scalar( @missing_from_second ) . " members ";
  print pretty_print_array(@missing_from_second); 
  print " missing in the array "; 
  print pretty_print_array(@arr2) , "\n";
}

## Re-using this code so often that I should
## probably make it a module.

sub pretty_print_array {

        my @array = @_;
        my $length = scalar @array;
        my $count = 1;

        print "(";

        foreach my $value(@array) {
                print $value;
                print ", " if $count < $length;
                $count++;
        }

        print ")";

        return;
}
