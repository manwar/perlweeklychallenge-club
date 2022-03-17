#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       pisa-time.pl
#
#       Pisano Period
#         Submitted by: Mohammad S Anwar
#         Write a script to find the period of the 3rd Pisano Period.
# 
#         In number theory, the nth Pisano period, written as π(n), is the
#         period with which the sequence of Fibonacci numbers taken modulo
#         n repeats.
# 
#         The Fibonacci numbers are the numbers in the integer sequence:
# 
#             0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89, 144, 
#                 233, 377, 610, 987, 1597, 2584, 4181, 6765, ...
# 
#         For any integer n, the sequence of Fibonacci numbers F(i) taken
#         modulo n is periodic. The Pisano period, denoted π(n), is the
#         value of the period of this sequence. For example, the sequence
#         of Fibonacci numbers modulo 3 begins:
# 
#             0, 1, 1, 2, 0, 2, 2, 1,
#             0, 1, 1, 2, 0, 2, 2, 1,
#             0, 1, 1, 2, 0, 2, 2, 1, ...

#         This sequence has period 8, so π(3) = 8.

#       method:
# 
#         Ok, so we'll need a list of Fibonacci numbers.
# 
#         Check. No trouble there.
# 
#         Then, for a general solution, we need to make mappings of this
#         list modulo various numbers, and make a new set of lists, one for
#         each modulo.
# 
#         And then the hard part: spotting a cycle.

#         You know whats really good for, you know, matching patterns? A
#         pattern matcher, of course. And we have an excellent one of
#         these, a world-class model, an inspiration for all the others, in the
#         Perl regular expression engine.
# 
#         So what we do is we construct a string from the array of digits.
#         Because the first fibonacci number is 0, the first character in
#         this concatenated string will always be 0, and as such the first
#         character of any repeated segment will likewise be 0. We can't
#         just search from 0 to 0 though, as there may be other incidences
#         of 0 digits within the sequence of remainders; we cannot make the
#         presumption that there are not. What we need to do is match an
#         incidence of a 0, followed by some minimal positive number of
#         characters, with this match captured and followed immediately by
#         the same matched sequence. 
# 
#         We then record the length of the captured sub-expression to an
#         array of Pisano periods for output. 
# 
#         If the recorded period is 0, that's not a possible outcome as
#         sequential differences in a modulo operation cannot be the same
#         outside of trivial edge-cases. So what we're really recording is
#         the failure of a match. This requires the list of Fibonacci
#         numbers to be extended to provide enough values to match 2
#         complete cycles. 
# 
#         As the Fibonacci list is extended, though, the values get large
#         quickly. Fortunately the simplicity of the underlying math in
#         constructing the sequence is not complex, and so adding the
#         directive `use bigint` does not cripple the processing time.
#         Things move along at a rapid pace.
# 
#         Except, though, when everything breaks after 10 values. The
#         problem here is that our concatenation worked fine for
#         single-digit remainders, but gets thrown off starting at 10, when
#         that becomes a valid result. We can no longer simply count
#         characters, as a single instance of 10 will count as 2 instead of
#         1 and throw off the result. 
# 
#         I see two ways to resolve this. One way would be to extend the
#         concatenation to make the number of characters allocated to each
#         remained consistent, say by padding with some arbitrary null.
#         This would deliver a character count in some multiple of the
#         actual period, and we could divide to arrive at the final value.
#         This is a perfectly good strategy, albeit a little complicated,
#         and makes for very long strings. Peeking ahead we see one of the
#         distant results is 120. Doubling the characters could be done
#         with a map and allow us to look for Pisanos up to 99. The strings
#         would however get quite huge. 
# 
#         On the other hand we could quickly map the values 0 through 35 to
#         an alphanumeric character set. Each value gets one character
#         again. We don't care what the numerical representation is, after
#         all, only that it be unique so we can match a pattern. This would
#         allow us access to he Pisanos up to 35 which seems like a
#         reasonable ask. Actually there's no reason not to tack on a
#         lowercase alphabet, extending our reach another 26 places, as
#         again we don't care what characters we're using. 
# 
#         It appears that 256 Fibonaccis are enough to compute the Pisanos
#         up to 61. I think that'll be plenty. 
# 
# 
# 
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use bigint;

sub fibonaccis ( $count ) {
## generates sequence of Fibonacci numbers up to and not greater than limit
    state @fs = (0,1);
    push  @fs, $fs[-1] + $fs[-2] while @fs <= $count;
    return @fs;
}


my @fs = fibonaccis(256);
my @pisas;

for my $mod (2..61) {
    my $modstr = join '', 
                 map { (0..9, "A".."Z", "a".."z")[$_] } 
                 map { $_ % $mod } 
                 @fs;

    $modstr =~ /(0.+?)\1/;
    push @pisas, length $1;
}

say join ', ', @pisas;

