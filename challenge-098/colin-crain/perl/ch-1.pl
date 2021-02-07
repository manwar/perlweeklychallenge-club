#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       readin-ritin-and-random-characters.pl
#
#         TASK #1 › Read N-characters
#         Submitted by: Mohammad S Anwar
#         You are given file $FILE.
# 
#         Create subroutine readN($FILE, $number) returns the first n-characters
#         and moves the pointer to the (n+1)th character.
# 
#         Example:
#         Input: Suppose the file (input.txt) contains "1234567890"
#         Output:
#             print readN("input.txt", 4); # returns "1234"
#             print readN("input.txt", 4); # returns "5678"
#             print readN("input.txt", 4); # returns "90"
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

use open qw( :encoding(utf-8) :std );

my $len = 20;
my $file = './unicode-text-test.txt';

open( my $fh, '<', $file ) or die "no such file $file : $!";

say readN($fh, 20);
say readN($fh, 20);
say readN($fh, 20);

sub readN {
    no warnings qw( uninitialized );
    my ($fh, $length, $offset) = @_;
    my $buffer;
    read( $fh, $buffer, $length, $offset );
    return $buffer;
}

==pod

the input file looks like this:

A☀3♠5¿7A901☀3♠5¿7A101☀3♠5¿7A☀01☀3♠5¿7A301☀3♠5¿7A♠01☀3♠5¿7A50
B☀3♠5¿7B901☀3♠5¿7B101☀3♠5¿7B☀01☀3♠5¿7B301☀3♠5¿7B♠01☀3♠5¿7B50
C☀3♠5¿7C901☀3♠5¿7C101☀3♠5¿7C☀01☀3♠5¿7C301☀3♠5¿7C♠01☀3♠5¿7C50
D☀3♠5¿7D901☀3♠5¿7D101☀3♠5¿7D☀01☀3♠5¿7D301☀3♠5¿7D♠01☀3♠5¿7D50
E☀3♠5¿7E901☀3♠5¿7E101☀3♠5¿7E☀01☀3♠5¿7E301☀3♠5¿7E♠01☀3♠5¿7E50

the output from the above:

A☀3♠5¿7A901☀3♠5¿7A10
1☀3♠5¿7A☀01☀3♠5¿7A30

as you can see, 20 characters are delivered, even if they are composed of
multi-byte unicode codepoints. 

==cut

