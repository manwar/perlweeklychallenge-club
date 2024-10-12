=begin
You are given a string $str containing digits (and possibly other characters which can be ignored). The last digit is the payload; consider it separately. Counting from the right, double the value of the first, third, etc. of the remaining digits.

For each value now greater than 9, sum its digits.

The correct check digit is that which, added to the sum of all values, would bring the total mod 10 to zero.

Return true if and only if the payload is equal to the correct check digit.

It was originally posted on reddit.

Example 1
Input: "17893729974"
Output: true

Payload is 4.

Digits from the right:

7 * 2 = 14, sum = 5
9 = 9
9 * 2 = 18, sum = 9
2 = 2
7 * 2 = 14, sum = 5
3 = 3
9 * 2 = 18, sum = 9
8 = 8
7 * 2 = 14, sum = 5
1 = 1

Sum of all values = 56, so 4 must be added to bring the total mod 10 to zero. The payload is indeed 4.
Example 2
Input: "4137 8947 1175 5904"
Output: true
Example 3
Input: "4137 8974 1175 5904"
Output: false
=cut

#0123456789  
my @tests = ("17893729974","4137 8947 1175 5904","4137 8974 1175 5904");

foreach(@tests){
  my $num = $_;
  my $results = checkCardNumber($num);
  print "$_ -> $results\n";
}

sub checkCardNumber {

  my $input = shift;
  my @A = split("",$input);
  my $payload = pop @A;
  my $size = scalar @A;
  my $sum = 0;
  my $pos = 1;

  for(my $i=$size-1; $i>-1; $i--){
    if($pos % 2 != 0){
      $A[$i] = $A[$i] * 2;
      while($A[$i]> 9){
        my @B = split("",$A[$i]);
        my $s = 0;
        foreach(@B){
          $s += $_;
        }
        $A[$i] = $s;
      }
      $sum += $A[$i];
    }else{
      $sum += $A[$i];
    }
    $pos++;
  }

  if(($sum + $payload) % 10 == 0){
    return "true";
  }else{
    return "false";
  }

}