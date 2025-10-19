#!/usr/bin/env raku

sub zero-friend (+nums) {
    nums
    andthen .map: *.abs
    andthen .min                    
}

multi MAIN (Bool :test($)!) {
    use Test;

    # Example cases from the challenge
    is zero-friend((4, 2, -1, 3, -2)), 1, 'closest to zero are -1 (1 away) and 2 (2 away) → result 1';
    is zero-friend((-5, 5, -3, 3, -1, 1)), 1, 'closest are -1 and 1 → distance 1';
    is zero-friend((7, -3, 0, 2, -8)), 0, 'exact zero present → distance 0';
    is zero-friend((-2, -5, -1, -8)), 1, 'closest are -1 (1 away) and -2 (2 away) → result 1';
    is zero-friend((-2, 2, -4, 4, -1, 1)), 1, 'closest are -1 and 1 → distance 1';

    # Additional edge cases
    is zero-friend((0)), 0, 'single element zero → distance 0';
    is zero-friend((10)), 10, 'single positive number → distance 10';
    is zero-friend((-7)), 7, 'single negative number → distance 7';
    is zero-friend((100, -99)), 99, 'closest is -99 → distance 99';

    done-testing;
}



multi MAIN (+nums) {
    say zero-friend nums;
}
