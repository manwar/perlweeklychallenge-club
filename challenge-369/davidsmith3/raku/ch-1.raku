#! /usr/bin/env raku

=begin pod
=TITLE
=head2 Challenge 369 Task 1
Submitted by: Mohammad Sajid Anwar
=CHALLENGE
You are given a given a string caption for a video.

Write a script to generate tag for the given string caption in three steps as mentioned below:

1. Format as camelCase
Starting with a lower-case letter and capitalising the first letter of each subsequent word.
Merge all words in the caption into a single string starting with a #.
2. Sanitise the String
Strip out all characters that are not English letters (a-z or A-Z).
3. Enforce Length
If the resulting string exceeds 100 characters, truncate it so it is
exactly 100 characters long.

=head3 Example 1:
Input: $caption = "Cooking with 5 ingredients!"
Output: "#cookingWithIngredients"

=head3 Example 2:
Input: $caption = "the-last-of-the-mohicans"
Output: "#thelastofthemohicans"

=head3 Example 3:
Input: $caption = "  extra spaces here"
Output: "#extraSpacesHere"

=head3 Example 4:
Input: $caption = "iPhone 15 Pro Max Review"
Output: "#iphoneProMaxReview"

=head3 Example 5:
Input: $caption = "Ultimate 24-Hour Challenge: Living in a Smart Home controlled entirely by Artificial Intelligence and Voice Commands in the year 2026!"
Output: "#ultimateHourChallengeLivingInASmartHomeControlledEntirelyByArtificialIntelligenceAndVoiceCommandsIn"

=end pod

multi my-sub(Str:D $caption where * ~~ / <[a..zA..Z]> / --> Str) {
    "#" ~ $caption
        .subst(:g, / <-[a..zA..Z\s]> /, "") # rule 2
        .split(/ \s+ /)                     # rule 1
        .map(*.tclc)                        # rule 1, tclc implied by example 4
        .join
        .subst(/ (.) /, { $0.lc })          # rule 1
        .substr(^99);                       # rule 3
}

multi my-sub(Str:D $caption) {
    die "Expecting at least one English letter, received $caption";
}

#| create a caption for a video
multi MAIN(Str:D $caption) {
    say my-sub($caption);
}

#| run tests
multi MAIN(Bool:D :$test) {
    use Test;

    my @tests = extract-tests;
    @tests.push(%{ input => "f", output => "#f" });
    @tests.push(%{ input => "f" x 100, output => "#" ~ "f" x 99 });
    @tests.push(%{ input => '&*(#&(#&f))', output => "#f" });

    my @should-throw;
    @should-throw.push(%{ input => "" });
    @should-throw.push(%{ input => '&*#(&$#)' });

    plan @tests + @should-throw;
    for @tests {
        is my-sub(.<input>), .<output>, "{.<input>}";
    }
    for @should-throw {
        dies-ok { my-sub(.<input>) }, "dies on {.<input>}";
    }
}

sub extract-tests(--> Array[Hash]) {
    my Hash @tests;
    my $string = / '"' <-["]>* '"' /;
    for $=pod -> $pod-item {
        for $pod-item.contents -> $pod-block {
            next unless $pod-block ~~ Pod::Heading && $pod-block.level == 3;
            my $text = $pod-block.contents[0].contents.join;
            if $text ~~ / ($string) .* ($string)  / {
                @tests.push(%{ input => $0.EVAL, output => $1.EVAL });
            }
        }
    }
    @tests;
}
