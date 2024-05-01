# Function to find the sign of the product of all integers in the array
sub sign_of_product {
  my @numbers = @_;
  my $product = 1;

  # Calculate the product of all the numbers in the array
  foreach my $number (@numbers) {
    $product *= $number;
  }

  # Return the sign of the product
  if ($product > 0) {
    return 1;
  } elsif ($product < 0) {
    return -1;
  } else {
    return 0;
  }
}

# Example usage
my @numbers = (-2, 3, -5, 7, 0);
print "The sign of the product is: ", sign_of_product(@numbers), "\n";