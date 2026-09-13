#!/usr/bin/perl
use strict;
use warnings;
use Carp qw(croak);
# croak() works like die(), but instead of pointing to the
# line inside this function, it reports the error at the line where the
# calling code invoked the function. This makes error messages more
# useful when validate_pattern() is used from other parts of a program.

sub validate_pattern {
    my ($str) = @_;

    # Count expressions beginning with a positive number and [.
    #
    # (?<!\d)   = the number must not be preceded by another digit
    # [1-9]     = first digit must be 1-9
    # \d*       = followed by zero or more digits
    # \[        = followed by an opening bracket
    my $number_open = () = $str =~ /(?<!\d)[1-9]\d*\[/g;

    # Check that the brackets are properly nested.
    my $level         = 0;
    my $bracket_count = 0;

    while ($str =~ /([\[\]])/g) {
        if ($1 eq '[') {
            $level++;
            $bracket_count++;
        }
        else {
            $level--;
            croak "Unexpected closing bracket ']' with no matching '['" if $level < 0;
        }
    }

    # A positive level means one or more opening brackets were never closed.
    croak "Unclosed opening bracket '[' ($level pending)" if $level;

    # Every opening bracket must belong to a number[ expression.
    croak "Missing number before [" if $bracket_count != $number_open;

    return 1;
}

sub expand_pattern {
    my ($str, $validate) = @_;

    validate_pattern($str) if $validate;

     # Match an expression whose contents contain no brackets.
     #
     # ([1-9]\d*) = positive number
     # \[         = [
     # ([^\[\]]*) = zero or more characters that are NOT [ or ]
     # \]         = ]
     #
     # Nested (innermost) expressions are matched and expanded first.
     # Example: 2[a3[b]c] -> first match: 3[b]
     #                    -> second match: 2[abbbc] -> abbbcabbbc
     #
    while ($str =~ /([1-9]\d*)\[([^\[\]]*)\]/) {
        my ($count, $inner) = ($1, $2);
        my $expanded = $inner x $count;

         # Replace the matched text in place using its own offsets.
         # @- / @+ hold the start/end positions of the last match:
         #    $-[0] = start of whole match,
         #    $+[0] = end of whole match.
         # substr() as an lvalue splices $expanded into that exact
         # location, avoiding a second scan of $str for the literal text.
        substr($str, $-[0], $+[0] - $-[0]) = $expanded;
    }

    return $str;
}

# Tests

my @cases = (
    [ "2[3[a]]",        "aaaaaa" ],
    [ "10[a]",          "aaaaaaaaaa" ],
    [ "a2[b]c3[d]e",    "abbcddde" ],
    [ "2[a2[b]c]",      "abbcabbc" ],
    [ "1[a]2[b3[c]]",   "abcccbccc" ],
);

for my $case (@cases) {
    my ($input, $expected) = @$case;
    my $result = expand_pattern($input, 1);
    print "$result\n";
    warn "  ^ expected $expected\n" if $result ne $expected;

}

# Validation error examples
# for my $bad ("2[a", "a]", "[a]") {
#     eval { expand_pattern($bad, 1) };
#     print "Validation caught '$bad': $@" if $@;
# }
