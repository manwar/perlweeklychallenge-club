use 5.036;
use List::Util 'max';

# https://theweeklychallenge.org/blog/perl-weekly-challenge-358/#TASK1

sub max_str_value($strings) {
    max(map((/^\d+\z/a ? 0+$_ : length), @$strings)) // 0
}

unless (caller) {
    require Run::WeeklyChallenge;
    require Cpanel::JSON::XS;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { Cpanel::JSON::XS->new->ascii->allow_nonref->encode(max_str_value($inputs)) },
        '["123", "45", "6"]',
        '{"type": "array", "items": {"type": "string"}}',
    );
}
