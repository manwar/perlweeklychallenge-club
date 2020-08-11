# Write a script to demonstrate calling a C function. It could be any user
# defined or standard C function.

# I choose to call my self made ROT13 encryption C function in Perl 6. ROT13
# is a letter subsitution cipher that replaces a letter with the 13th letter
# after it in the alphabet.
#
# To create the shared ROT13 library run: ./make.sh

use NativeCall;

sub rot13(Str) returns Str is native('./rot13.so') {*};

my $enc = rot13("hello perl weekly challenge!");
my $dec = rot13($enc);

say "ROT13 encryption: $enc";
say "ROT13 decryption: $dec";
