use Roman;

sub roman_maths {
    my ($expr) = @_;
    # Parse the expression into two Roman numerals and the operation
    my ($num1, $op, $num2) = split / /, $expr;
    $num1 = arabic($num1);
    $num2 = arabic($num2);
    # Perform the operation
    my $result;
    if ($op eq '+') {
        $result = $num1 + $num2;
    } elsif ($op eq '-') {
        $result = $num1 - $num2;
    } elsif ($op eq '*') {
        $result = $num1 * $num2;
    } elsif ($op eq '/') {
        if ($num2 == 0) {
            return "non potest";  # they didn't do fractions
        }
        $result = int($num1 / $num2);
    } elsif ($op eq '**') {
        $result = $num1 ** $num2;
    } else {
        return "Invalid operation";
    }
    # Check the result
    if ($result <= 0) {
        return "nulla" if $result == 0;  # they didn't do negative numbers
        return "non potest";
    } elsif ($result > 3999) {
        return "non potest";  # they only went up to 3999
    }
    # Convert the result back into a Roman numeral
    return Roman($result);
}

print roman_maths("IV + V"), "\n";  # should print IX
print roman_maths("M - I"), "\n";  # should print CMXCIX
print roman_maths("X / II"), "\n";  # should print V
print roman_maths("XI * VI"), "\n";  # should print LXVI
print roman_maths("VII ** III"), "\n";  # should print CCCXLIII
print roman_maths("V - V"), "\n";  # should print nulla
print roman_maths("V / II"), "\n";  # should print non potest
print roman_maths("MMM + M"), "\n";  # should print non potest
print roman_maths("V - X"), "\n";  # should print non potest
