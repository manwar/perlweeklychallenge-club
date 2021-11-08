use Test::More;
use Test::Output;

require_ok('./ch-1.pl');

stdout_is { &run(5) }
'1 as binary representation of 5 is 101 which is Palindrome.',
    '5 is a palindrome';

stdout_is { &run(4) }
'0 as binary representation of 4 is 100 which is NOT Palindrome.',
    '4 is NOT a palindrome';

done_testing;
