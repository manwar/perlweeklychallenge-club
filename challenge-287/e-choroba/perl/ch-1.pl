#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

# We can ignore deletion. We can always replace a character with a character
# of the same class different to the previous and following one instead.
sub strong_password_simple($str) {
    my %agenda = ($str => undef);

    my $steps = 0;
    while (1) {
        my %next;
        for my $s (keys %agenda) {

            if (6 > length $s) {
                for my $char ($s =~ /[aA0]$/ ? qw( b B 1 ) : qw( a A 0 )) {
                    undef $next{ $s . $char };
                }
            } elsif ($s !~ /[[:lower:]]/
                     || $s !~ /[[:upper:]]/
                     || $s !~ /[0-9]/
                     || $s =~ /(.)\1\1/
            ) {
                for my $l (0 .. length($s) - 1) {

                    my $this      = substr $s, $l, 1;
                    my $previous  = $l > 0 ? substr $s, $l - 1, 1 : 'a';
                    my $following = $l == length($s) - 1
                                    ? 'a'
                                    : substr $s, $l + 1, 1;

                    my $match;
                    $match .= /[a-z]/ ? 'a-z'
                            : /[A-Z]/ ? 'A-Z'
                            :           '0-9' for $previous, $this, $following;

                    undef $next{ substr($s, 0, $l) . $_ . substr($s, $l + 1) }
                        for grep /[^$match]/, qw( 0 a A );
                }
            } else {
                return $steps
            }
        }
        %agenda = %next;
        ++$steps;
    }
}


sub strong_password($str) {
    my %agenda = ($str => undef);

    my $steps = 0;
    while (1) {
        my %next;
        for my $s (keys %agenda) {

            if (6 > length $s) {
                for my $char ($s =~ /[aA0]$/ ? qw( b B 1 ) : qw( a A 0 )) {
                    undef $next{ $s . $char };
                }

            } elsif ($s =~ /(.)\1\1/) {
                while ($s =~ /(.)(?=\1\1)/g) {
                    my $l = $-[0] + 1;
                    my $this = $1;
                    my $re = $this =~ tr/[a-z]// ? 'a-z'
                           : $this =~ tr/[A-Z]// ? 'A-Z'
                           :                       '0-9';

                    undef $next{ substr($s, 0, $l) . $_ . substr($s, $l + 1) }
                        for grep /[^$re]/, qw( 0 a A );
                }

            } else {
                my %count;
                $count{'a-z'} = $s =~ tr/a-z//;
                $count{'A-Z'} = $s =~ tr/A-Z//;
                $count{'0-9'} = $s =~ tr/0-9//;

                return $steps
                    if ! grep 0 == $_, values %count;

                my ($repeated, $replacement);
                for my $class (qw( a-z A-Z 0-9 )) {
                    $repeated = $class if $count{$class} > 1;
                    $replacement = substr $class, 0, 1 if 0 == $count{$class};
                }
                undef $next{ $s =~ s/[$repeated]/$replacement/r };
            }
        }
        %agenda = %next;
        ++$steps;
    }
}

use Test::More tests => 2 * (5 + 3);

for my $strong_password (\&strong_password_simple, \&strong_password) {
    is $strong_password->('a'), 5, 'Example 1';
    is $strong_password->('aB2'), 3, 'Example 2';
    is $strong_password->('PaaSW0rd'), 0, 'Example 3';
    is $strong_password->('Paaasw0rd'), 1, 'Example 4';
    is $strong_password->('aaaaa'), 2, 'Example 5';

    is $strong_password->('aaaZZZ999'), 3, 'Repeated triplets';
    is $strong_password->('0Zaaab'), 1, 'Creating a triple';
    is $strong_password->('000aaa000'), 3, 'Combined actions';
}

my @inputs;
for (1 .. 1000) {
    my $s = join "", map +('a' .. 'z', 'A' .. 'Z', 0 .. 9)[rand 62],
                     1 .. rand 15;
    strong_password($s) == strong_password_simple($s) or warn "Diff $s";
    push @inputs, $s;
}

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    original  => sub { strong_password($_)        for @inputs },
    optimised => sub { strong_password_simple($_) for @inputs }
});
