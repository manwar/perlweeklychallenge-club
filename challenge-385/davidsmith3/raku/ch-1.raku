#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 385 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Uncommon Words

You are given two sentences.

Write a script to return list of all uncommon words, order is not important.

=head3 Example 1:

Input: $sentence1 = "apple banana apple"
       $sentence2 = "banana orange"
Output: ("orange")

=head3 Example 2:

Input: $sentence1 = "cat dog"
       $sentence2 = "bird fish"
Output: ("cat", "dog", "bird", "fish")

=head3 Example 3:

Input: $sentence1 = "the quick brown fox"
       $sentence2 = "the quick"
Output: ("brown", "fox")

=head3 Example 4:

Input: $sentence1 = "hello"
       $sentence2 = "hello"
Output: ()

=head3 Example 5:

Input: $sentence1 = "blue blue red"
       $sentence2 = "red green green yellow"
Output: ("yellow")

=end pod

subset Sentence of Str where / ^ <+alpha +space>* $ /; # assume words consist only of alphabetic characters

sub uncommon-words(Sentence $sentence1, Sentence $sentence2  --> List) {
    ($sentence1, $sentence2)
        .join(' ')                    # combine the sentences because the source of the word is not important
        .words                        # get the individual words
        .Bag                          # and count them
        .grep({ .value == 1 })        # then filter out the common ones
        .map({ .key })                # and finally transform to correct form
        .List;
}

#| find words not in both sentence1 and sentence2
multi MAIN(Str:D $sentence1, Str:D $sentence2) {
    say uncommon-words($sentence1, $sentence2);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => ("apple banana apple", "banana orange"),
                   output =>  ("orange",) ));
    @tests.push(%( input => ("cat dog", "bird fish"),
                   output => ("cat", "dog", "bird", "fish") ));
    @tests.push(%( input => ("the quick brown fox", "the quick"),
                   output =>  ("brown", "fox") ));
    @tests.push(%( input => ("hello", "hello"),
                   output => () ));
    @tests.push(%( input => ("blue blue red", "red green green yellow"),
                   output =>  ("yellow",) ));
    @tests.push(%( input => ("", ""),
                   output =>  () ));
    @tests.push(%( input => ("alpha", "beta"),
                   output =>  ("alpha", "beta") ));
    @tests.push(%( input => ("alpha", "Alpha"),
                   output =>  ("alpha", "Alpha") ));  # we assume capitalization matters
    @tests.push(%( input => ("alpha alpha", "beta beta"),
                   output =>  () ));
    @tests.push(%( input => ("alpha\talpha", "beta\tbeta\tgamma"),
                   output =>  ("gamma") ));

    my @should-throw;
    @should-throw.push(%( input => ("foo.", "bar") ));
    @should-throw.push(%( input => ("foo", "bar%") ));

    plan @tests + @should-throw + 3;
    for @tests {
        is-deeply uncommon-words(|.<input>).sort, .<output>.sort, "{ .<input>.raku }"; # sort to compare since order is not important to output
    }
    for @should-throw {
        dies-ok { uncommon-words(|.<input>) }, "dies on { .<input>.raku }";
    }

    my $proc = run($*EXECUTABLE, $?FILE, 'alpha beta', 'beta', :out, :err);
    is $proc.out.slurp(:close).trim, '(alpha)', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
