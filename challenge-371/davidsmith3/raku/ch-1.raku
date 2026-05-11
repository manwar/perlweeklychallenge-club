#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Challenge 371 Task 1 Missing Letter
Submitted by: Reinier Maliepaard
=CHALLENGE
You are given a sequence of 5 lowercase letters, with one letter replaced by ‘?’. Each letter maps to its position in the alphabet (‘a = 1’, ‘b = 2’, …, ‘z = 26’). The sequence follows a repeating pattern of step sizes between consecutive letters. The pattern is either a constant step (e.g., ‘+2, +2, +2, +2’) or a simple alternating pattern of two distinct steps (e.g., ‘+2, +3, +2, +3’).

=head3 Example 1:
Input: @seq = qw(a c ? g i)
Output: e

The pattern of the sequence is +2,+2,+2,+2.
1: a
3: c
5: e
7: g
9: i

=head3 Example 2:
Input: @seq = qw(a d ? j m)
Output: g

The pattern of the sequence is +3,+3,+3,+3.
1: a
4: d
7: g
10: j
13: m

=head3 Example 3:
Input: @seq = qw(a e ? m q)
Output: i

The pattern of the sequence is +4,+4,+4,+4.
1: a
5: e
9: i
13: m
17: q

=head3 Example 4:
Input: @seq = qw(a c f ? k)
Output: h

The pattern of the sequence is +2,+3,+2,+3.
1: a
3: c
6: f
8: h
11: k

=head3 Example 5:
Input: @seq = qw(b e g ? l)
Output: j

The pattern of the sequence is +3,+2,+3,+2.
2: b
5: e
7: g
10: j
12: l

=end pod

subset Char of Str where / ^ <lower> $ /;
constant LETTERS = "_abcdefghijklmnopqrstuvwxyz"; # 1 based position

multi my-sub(@seq where .elems == 5
                     && .all ~~ / ^ <+lower +[?]> $ /
                     && .one ~~ '?'
                                     --> Char) {
    my $mark = @seq.first("?"):k;
    my Int $gap-even;
    my Int $gap-odd;

    # capture the first available even and odd gaps
    for 0..3 -> $i {
        next if $i == $mark || $i + 1 == $mark;
        last if $gap-even.defined && $gap-odd.defined;
        my $gap = LETTERS.index(@seq[$i + 1]) - LETTERS.index(@seq[$i]);
        if $i %% 2 {
            $gap-even = $gap;
        } else {
            $gap-odd = $gap;
        }
    }
    my $anchor = $mark == 0 ?? 1 !! $mark - 1;
    my &operator = $mark == 0 ?? &[-] !! &[+];
    my $gap = $anchor %% 2 ?? $gap-even !! $gap-odd;
    $gap = $gap-even if $mark == 0;
    LETTERS.substr(&operator(LETTERS.index(@seq[$anchor]), $gap), 1);
}

multi my-sub(@seq) {
    die "Unexpected input, received { @seq.join }";
}

#| find missing letter
multi MAIN(*@seq) {
    say my-sub(@seq);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    @tests.push(%{ input => <? b c d e>, output => "a" });
    @tests.push(%{ input => <? b d e g>, output => "a" });
    @tests.push(%{ input => <a b c d ?>, output => "e" });
    @tests.push(%{ input => <a b d e ?>, output => "g" });

    my @should-throw;
    @should-throw.push(%{ input => <a b c ? e f>, reason => "too long" }); 
    @should-throw.push(%{ input => <a b c ? >, reason => "too short" }); 
    @should-throw.push(%{ input => <a b c d e >, reason => "zero marks" }); 
    @should-throw.push(%{ input => <a b ? d ? >, reason => "two marks" }); 
    @should-throw.push(%{ input => <a b ? d E >, reason => "non-lowercase" }); 
    plan @tests + @should-throw;
    for @tests {
        is my-sub(.<input>), .<output>, "{.<input>}";
    }
    for @should-throw {
        dies-ok { my-sub(.<input>) }, "dies because { .<reason> }";
    }
}

sub extract-tests(--> Array[Hash]) {
    my Hash @tests;
    my $group = / '(' .* ')' /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / '(' (.*) ')' \s* Output\: \s* (<+[\w] -[_]>)  / {
                @tests.push(%{ input => $0.split(/ \s /), output => ~$1 });
            }
        }
    }
    @tests;
}
