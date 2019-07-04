#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;


sub create_code {
    # Converts password to a list of numeric codes
    # where 'a' corresponds to a shift of 1, etc.
    my $passwd = shift;
    return map { ord($_) - ord('a') + 1 } split //, $passwd;
}
sub rotate_one_letter {
    # Converts a single letter and deals with cases where
    # applying the shift would get the result out of range
    my ($letter, $shift) = @_;
    my $max = 255;
    my $shifted = $shift + ord $letter;
    $shifted = $shifted > $max ? $shifted - $max :
        $shifted < 0 ? $shifted + $max :
        $shifted;
    return chr $shifted;
}
sub rotate_msg {
    # calls rotate-one-letter for each letter of the input message
    # and passes the right shift value for that letter
    my ($msg, @code) = @_;
    my $i = 0;
    my $result = "";
    for my $letter (split //, $msg) {
        my $shift = $code[$i];
        $result .= rotate_one_letter $letter, $shift;
        $i++;
        $i = 0 if $i >= @code;
    }
    return $result;
}
sub encode {
    my ($message, @key) = @_;
    rotate_msg $message, @key;
}
sub decode  {
    my ($message, @key) = @_;
    my @back_key = map {- $_} @key;
    rotate_msg $message, @back_key;
}
sub run_tests {
    use Test::More; # Minimal tests for providing an example
    plan tests => 6; # needed on a separate code line to avoid
                     # useless output when not running the tests
    my $code = join "", create_code("abcde");
    is $code, 12345, "Testing create_code";
    my @c = create_code "password";
    for my $word ( qw/foo bar hello world/) {
        is decode( encode($word, @c), @c), $word,
            "Round trip for $word";
    }
    my $msg = "One small step for man, one giant leap for mankind!";
    my $ciphertext = encode $msg, @c;
    is decode($ciphertext, @c), $msg,
        "Message with spaces and punctuation";
}


if (@ARGV == 1 and $ARGV[0] eq "test") {
    run_tests;
} elsif ( @ARGV == 2) {
    my ($message, $password) = @ARGV;
    my @code = create_code $password;
    my $ciphertext = encode $message, @code;
    say "Encoded cyphertext: $ciphertext";
    say "Roundtrip to decoded message: ", decode $ciphertext, @code;
} else {
    say "Wrong arguments";
}
