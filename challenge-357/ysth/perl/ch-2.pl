use 5.040;
use List::Util;
use Math::BigRat;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-357/#TASK2

sub unique_fraction_generator($int) {
    [
        map sprintf("%s/%s", $_->fparts),
        sort { $a <=> $b }
        List::Util::uniq
        map Math::BigRat->new($_),
        glob sprintf "{%s}/{%s}", (join(',', 1..$int)) x 2
    ]
}

unless (caller) {
    require Run::WeeklyChallenge;
    require Cpanel::JSON::XS;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { Cpanel::JSON::XS->new->ascii->allow_nonref->encode(unique_fraction_generator($inputs)) },
        '3',
        '{"type":"integer", "minimum":1}',
    );
}
