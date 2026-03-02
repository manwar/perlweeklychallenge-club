use 5.038;
use Lingua::EN::Numbers 'num2en';
#use Lingua::FR::Nums2Words 'num2word';

# https://theweeklychallenge.org/blog/perl-weekly-challenge-362/#TASK2

sub spellbound_sorting($integers) {
    [ map 0+s/.*\x00//sr, sort map join("\x00", num2en($_), $_), @$integers ]
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge_v2(
        \&spellbound_sorting,
        '[6, 7, 8, 9, 10]',
        '{"type":"array", "items": {"type":"integer"}}',
    );
}
