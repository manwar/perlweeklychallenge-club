use strict;
use warnings;

use Test::More tests => 8;

use_ok('Palindrome');
ok(Palindrome->is_palindrome(1), 'can call palindrome method');
is(Palindrome->is_palindrome(10), 0, 'should not be a palindrome');
is(Palindrome->is_palindrome(101), 1, 'should be a palindrome');
is(Palindrome->is_palindrome(123454321), 1, 'should be a palindrome');
is(Palindrome->is_palindrome(1234554321), 1, 'should be a palindrome');
is(Palindrome->is_palindrome(5432154321), 0, 'should not be a palindrome');
is(Palindrome->is_palindrome(), 0, 'protect against no input');