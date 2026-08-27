#! /usr/bin/env raku

=begin pod
=TITLE PWC
=head2 Challenge 388 Task 1

Submitted by: Roger Bell_West
=head2 Dyck Words

A Dyck Word of order $n is a string of length 2x$n consisting of $n ‘U’ (Up) characters and $n ‘D’ (Down) characters such that no initial prefix of the string contains more ‘D’s than ‘U’s.

Write a script to return a list of all valid Dyck words of length 2x$n, sorted in lexicographical (alphabetical) order.

=head3 Example 1:

Input: $n = 1
Output: ("UD")

=head3 Example 2:

Input: $n = 2
Output: ("UDUD","UUDD")

=head3 Example 3:

Input: $n = 3
Output: ("UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD")

=head3 Example 4:

Input: $n = 0
Output: ("")

=head3 Example 5:

Input: $n = 4
Output: ("UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD", "UDUUUDDD",
         "UUDDUDUD", "UUDDUUDD", "UUDUDDUD", "UUDUDUDD", "UUDUUDDD",
         "UUUDDDUD", "UUUDDUDD", "UUUDUDDD", "UUUUDDDD")

=end pod

sub dyck(Int:D $u-used, $u-left, $d-used, $d-left --> List) {
    return ("",) if $u-left == 0 && $d-left == 0;
    my @result;
    if $d-left > 0 && $d-used < $u-used {
        @result.append(dyck($u-used, $u-left, $d-used+1, $d-left-1).map({ 'D' ~ $_ }))
    }
    if $u-left > 0 {
        @result.append(dyck($u-used+1, $u-left-1, $d-used, $d-left).map({ 'U' ~ $_ }));
    }
    @result.List;
}

multi dyck-words(Int:D $n where * >= 0 --> List) {
    dyck(0, $n, 0, $n);
}

multi dyck-words($n) {
    die "Dyck word order must be an non-negative integer.  Received $n";
}

#| return Dyck works of order N in lexicographical order
multi MAIN(Int:D $n) {
    say dyck-words($n);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests;
    @tests.push(%( input => 1, output => ("UD",)));
    @tests.push(%( input => 2, output => ("UDUD","UUDD")));
    @tests.push(%( input => 3, output => ("UDUDUD", "UDUUDD", "UUDDUD", "UUDUDD", "UUUDDD")));
    @tests.push(%( input => 0, output => ("",)));
    @tests.push(%( input => 4, output => ("UDUDUDUD", "UDUDUUDD", "UDUUDDUD", "UDUUDUDD",
                                          "UDUUUDDD", "UUDDUDUD", "UUDDUUDD", "UUDUDDUD",
                                          "UUDUDUDD", "UUDUUDDD", "UUUDDDUD", "UUUDDUDD",
                                          "UUUDUDDD", "UUUUDDDD")));
    my @should-throw;
    @should-throw.push(%( input => -1 ));
    @should-throw.push(%( input => "Hello" ));

    plan @tests + @should-throw + 3;
    for @tests {
        is-deeply dyck-words(.<input>), .<output>, "{ .<input> }";
    }
    for @should-throw {
        throws-like { dyck-words(.<input>) }, Exception, "dies on { .<input> }", message => /'Dyck word order'/;
    }
    my $proc = run($*EXECUTABLE, $?FILE, '1', :out, :err);
    is $proc.out.slurp(:close).trim, '(UD)', "cli produces result on stdout";
    is $proc.err.slurp(:close), '', "cli produces nothing on stderr";
    is $proc.exitcode, 0, "cli exits cleanly";
}
