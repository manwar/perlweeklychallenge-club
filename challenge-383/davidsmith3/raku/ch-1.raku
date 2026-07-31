#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 383 Task 1

Submitted by: Mohammad Sajid Anwar
=head2 Similar List

You are given three list of strings.

Write a script to find out if the first two list are similar with the help the third list. The third list contains the similar words map.

=head3 Example 1:

Input: $list1 = ("great", "acting")
       $list2 = ("fine", "drama")
       $list3 = (["great", "fine"], ["acting", "drama"])
Output: true

=head3 Example 2:

Input: $list1 = ("apple", "pie")
       $list2 = ("banana", "pie")
       $list3 = (["apple", "peach"], ["peach", "banana"])
Output: false

=head3 Example 3:

Input: $list1 = ("perl4", "python")
       $list2 = ("raku", "python")
       $list3 = (["perl4", "perl5", "raku"])
Output: true

=head3 Example 4:

Input: $list1 = ("enjoy", "challenge")
       $list2 = ("love", "weekly", "challenge")
       $list3 = (["enjoy", "love"])
Output: false

=head3 Example 5:

Input: $list1 = ("fast", "car")
       $list2 = ("quick", "vehicle")
       $list3 = (["quick", "fast"], ["vehicle", "car"])
Output: true

=end pod

sub similar-list(@list1 where .all ~~ Str:D,
                 @list2 where .all ~~ Str:D,
                 @list3 where .map({ $_.all ~~ Str:D })
                    --> Bool) {
    return False if @list1.elems != @list2.elems;
    for @list1 Z @list2 -> @p {
        my $found = False;
        for @list3 -> @mapping {
            $found = @p.head eq @p.tail || @p (<=) @mapping;
            last if $found;
        }
        return False unless $found;
    }
    True;
}

#| determine if list1 and list2 are similar using mapping list3
multi MAIN(Str:D $list1, Str:D $list2, Str:D $list3) {
    say similar-list($list1.split(','),
                     $list2.split(','),
                     $list3.split(';').map({ $_.split(',').Array }));
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => (("great", "acting"),
                             ("fine", "drama"),
                             (["great", "fine"], ["acting", "drama"])),
                   output => True ));
    @tests.push(%( input => (("apple", "pie"),
                             ("banana", "pie"),
                             (["apple", "peach"], ["peach", "banana"])),
                   output => False ));
    @tests.push(%( input => (("perl4", "python"),
                             ("raku", "python"),
                             (["perl4", "perl5", "raku"],)),
                   output => True ));
    @tests.push(%( input => (("enjoy", "challenge"),
                             ("love", "weekly", "challenge"),
                             (["enjoy", "love"])),
                   output => False ));
    @tests.push(%( input => (("fast", "car"),
                             ("quick", "vehicle"),
                             (["quick", "fast"], ["vehicle", "car"])),
                   output => True ));
    @tests.push(%( input => (("alpha",),                                   # assume similar also means word quantity
                             ("beta", "beta"),
                             (["alpha", "beta"])),
                   output => False ));
    @tests.push(%( input => (("alpha", "a"),                               # assume similar also means word order
                             ("b", "beta"),
                             (["alpha", "beta"], ["a", "b"])),
                   output => False ));
    @tests.push(%( input => (("alpha",),                                   # assume case sensitive
                             ("Beta",),
                             (["alpha", "beta"],)),
                   output => False ));
    my @should-throw;
    @should-throw.push(%( input => ((1, 2, 3), ("a", "b"), ("a", "b")) ));
    @should-throw.push(%( input => (("a", "b"), (1, 2, 3), ("a", "b")) ));
    @should-throw.push(%( input => (("a", "b"), ("a", "b"), (["a", "b"], [1, 2])) ));
    plan @tests + @should-throw + 3;
    for @tests {
        is similar-list(|.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        dies-ok { similar-list(|.<input>) }, "dies on { .<input> }";
    }
    my $proc = run($*EXECUTABLE, $?FILE, 'a,y', 'b,z', 'a,b;y,z', :out, :err);
    is $proc.out.slurp(:close).trim, 'True', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
