use strict;
use warnings;

use Test2::V0 -target => 'Caesar';

can_ok( $CLASS, 'decode' );

subtest '->encode()' => sub {
    my $S        = 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG';
    my $N        = 3;
    my $expected = "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD";

    my $got = $CLASS->encode(
        string => $S,
        n      => $N,
    );

    is $got, $expected, "'$S' with shift of '$N' should return '$expected'";
};

subtest '->decode()' => sub {
    my $expected = 'THE QUICK BROWN FOX JUMPS OVER THE LAZY DOG';
    my $N        = 3;
    my $S        = "QEB NRFZH YOLTK CLU GRJMP LSBO QEB IXWV ALD";

    my $got = $CLASS->decode(
        string => $S,
        n      => $N,
    );

    is $got, $expected, "'$S' with shift of '$N' should return '$expected'";
};

subtest '->_cipher(mode => "encode")' => sub {
    my $expected = {
        ' ' => ' ',
        'a' => 'x',
        'b' => 'y',
        'c' => 'z',
        'd' => 'a',
        'e' => 'b',
        'f' => 'c',
        'g' => 'd',
        'h' => 'e',
        'i' => 'f',
        'j' => 'g',
        'k' => 'h',
        'l' => 'i',
        'm' => 'j',
        'n' => 'k',
        'o' => 'l',
        'p' => 'm',
        'q' => 'n',
        'r' => 'o',
        's' => 'p',
        't' => 'q',
        'u' => 'r',
        'v' => 's',
        'w' => 't',
        'x' => 'u',
        'y' => 'v',
        'z' => 'w',
    };

    my $got = $CLASS->_cipher(
        'n'  => 3,
        mode => 'encode'
    );

    is $got, $expected, 'encode mode (shift 3) cipher as expected';

    $expected = {
        ' ' => ' ',
        'a' => 'v',
        'b' => 'w',
        'c' => 'x',
        'd' => 'y',
        'e' => 'z',
        'f' => 'a',
        'g' => 'b',
        'h' => 'c',
        'i' => 'd',
        'j' => 'e',
        'k' => 'f',
        'l' => 'g',
        'm' => 'h',
        'n' => 'i',
        'o' => 'j',
        'p' => 'k',
        'q' => 'l',
        'r' => 'm',
        's' => 'n',
        't' => 'o',
        'u' => 'p',
        'v' => 'q',
        'w' => 'r',
        'x' => 's',
        'y' => 't',
        'z' => 'u',
    };

    $got = $CLASS->_cipher(
        'n'  => 5,
        mode => 'encode'
    );

    is $got, $expected, 'encode mode (shift 5) cipher as expected';

};

subtest '->_cipher(mode => "decode")' => sub {
    my $expected = {
          ' ' => ' ',
          'a' => 'd',
          'b' => 'e',
          'c' => 'f',
          'd' => 'g',
          'e' => 'h',
          'f' => 'i',
          'g' => 'j',
          'h' => 'k',
          'i' => 'l',
          'j' => 'm',
          'k' => 'n',
          'l' => 'o',
          'm' => 'p',
          'n' => 'q',
          'o' => 'r',
          'p' => 's',
          'q' => 't',
          'r' => 'u',
          's' => 'v',
          't' => 'w',
          'u' => 'x',
          'v' => 'y',
          'w' => 'z',
          'x' => 'a',
          'y' => 'b',
          'z' => 'c',
    };

    my $got = $CLASS->_cipher(
        'n'  => 3,
        mode => 'decode'
    );

    is $got, $expected, 'decode mode (shift 3) cipher as expected';

    $expected = {
          ' ' => ' ',
          'a' => 'f',
          'b' => 'g',
          'c' => 'h',
          'd' => 'i',
          'e' => 'j',
          'f' => 'k',
          'g' => 'l',
          'h' => 'm',
          'i' => 'n',
          'j' => 'o',
          'k' => 'p',
          'l' => 'q',
          'm' => 'r',
          'n' => 's',
          'o' => 't',
          'p' => 'u',
          'q' => 'v',
          'r' => 'w',
          's' => 'x',
          't' => 'y',
          'u' => 'z',
          'v' => 'a',
          'w' => 'b',
          'x' => 'c',
          'y' => 'd',
          'z' => 'e',
    };

    $got = $CLASS->_cipher(
        'n'  => 5,
        mode => 'decode'
    );

    is $got, $expected, 'decode mode (shift 5) cipher as expected';

};
done_testing;
