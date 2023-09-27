sub can-sell-with-exact-change(@bills) {
    my $five = 0;
    my $ten = 0;
    
    for @bills -> $bill {
        if $bill == 5 {
            $five++;
        } elsif $bill == 10 {
            return False if $five == 0;
            $five--;
            $ten++;
        } else {
            if $ten > 0 && $five > 0 {
                $ten--;
                $five--;
            } elsif $five >= 3 {
                $five -= 3;
            } else {
                return False;
            }
        }
    }
    
    return True;
}

# Test Cases
say can-sell-with-exact-change([5, 5, 5, 10, 20]);  # Should return True
say can-sell-with-exact-change([5, 5, 10, 10, 20]);  # Should return False
say can-sell-with-exact-change([5, 5, 5, 20]);  # Should return True

