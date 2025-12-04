use 5.040;
use List::Util 1.29;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-350/#TASK1

# find overlapping 3 character substrings with 3 unique characters
sub good_substrings($string) {
    # note we cature one undef per successful match, not the actual 3 character substring
    # branch reset allows both checks to use \1 and saves us having to divide by 2, though probably faster without
    scalar( () = $string =~/(?!(?|(.).?\1|.(.)\1))(?=...)/gs );
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge(\&good_substrings, '"abcaefg"
', '{"type":"string"}');
}
