use 5.036;
use Text::CharWidth 'mbswidth';

# https://theweeklychallenge.org/blog/perl-weekly-challenge-360/#TASK1

sub text_justifier($string, $width) {
    use Exception::Class 'InsufficientWidth' => { 'description' => 'String does not fit within width' };

    my $padding = $width - mbswidth($string);
    InsufficientWidth->throw if $padding < 0;

    return
        '*' x ($padding / 2)
        . $string
        . '*' x (($padding + 1) / 2);
}

unless (caller) {
    require Run::WeeklyChallenge;
    Run::WeeklyChallenge::run_weekly_challenge_v2(
        sub ($inputs) { text_justifier($inputs->{'str'}, $inputs->{'width'}) },
        '{"str": "Hi", "width":5}',
        '{
            "type": "object",
            "properties": {
                "str": {"type": "string"},
                "width": {"type": "integer", "minimum": 0}
            },
            "required": ["str", "width"],
            "additionalProperties": false
        }',
    );
}
