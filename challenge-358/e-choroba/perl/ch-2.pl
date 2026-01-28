#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

# See also 097/1

use constant {A     => ord 'a',
              CHARS => 1 + ord('z') - ord('a')};

{   my $CHARS = join "", 'a' .. 'z';
    my %cache;
    sub encrypted_string($str, $int) {
        $int %= CHARS;
        $cache{$int} //= substr($CHARS, $int) . substr($CHARS, 0, $int);
        return
            eval "\$str =~ tr/$CHARS\U$CHARS\E/$cache{$int}\U$cache{$int}\E/r"
    }
}

sub encrypted_string_math($str, $int) {
    return join "", map /[a-z]/ ? chr(($int - A + ord) % CHARS + A)
                      : /[A-Z]/ ? uc(chr(($int - A + ord lc) % CHARS + A))
                                : $_,
                    split //, $str
}

use Test::More tests => 2 * (5 + 1) + 2;

for my $encrypted_string(\&encrypted_string, \&encrypted_string_math) {
    is $encrypted_string->('abc', 1), 'bcd', 'Example 1';
    is $encrypted_string->('xyz', 2), 'zab', 'Example 2';
    is $encrypted_string->('abc', 27), 'bcd', 'Example 3';
    is $encrypted_string->('hello', 5), 'mjqqt', 'Example 4';
    is $encrypted_string->('perl', 26), 'perl', 'Example 5';

    is $encrypted_string->('mjqqt', -5), 'hello', 'Negative';
}

use Benchmark qw{ cmpthese };
my $s = 'qeb nrfzh yoltk CLU grjmp lsbo qeb ixwv ald';
is encrypted_string($s, 29), 'the quick brown FOX jumps over the lazy dog',
    'fox';
is encrypted_string($s, 29), encrypted_string_math($s, 29), 'same';
cmpthese(-3, {
         eval_tr    => sub { encrypted_string($s, 29) },
         join_split => sub { encrypted_string_math($s, 29) }
});

__END__
              Rate join_split    eval_tr
join_split 46548/s         --       -36%
eval_tr    73074/s        57%         --
