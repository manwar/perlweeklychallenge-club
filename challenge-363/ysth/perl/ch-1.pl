use 5.040;

use Lingua::EN::Words2Nums 'words2nums';
use Unicode::Normalize 'NFD';

# https://theweeklychallenge.org/blog/perl-weekly-challenge-363/#TASK1

sub string_lie_detector($string) {
    my ($target, $vowels, $consonants) = $string =~ /^(.*)\s\p{Pd}\s(.*)\svowels?\sand\s(.*)\sconsonants?\z/
        or return false;

    my $normalized_target = NFD($target);
    my $consonant_count = $normalized_target =~ y/bcdfghjklmnpqrstvwxyz//;
    my $vowel_count = $normalized_target =~ y/aeiou//;

    return words2nums($vowels) == $vowel_count && words2nums($consonants) == $consonant_count;
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge_v2(
        \&string_lie_detector,
        '"aa \u2014 two vowels and zero consonants"',
        '{"type":"string"}',
    );
}
