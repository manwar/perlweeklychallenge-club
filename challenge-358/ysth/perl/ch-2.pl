use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-358/#TASK2

sub encrypted_string($str, $int) {
    my %encrypt = map((chr($_+ord 'A'), chr(($_+$int) % 26 + ord 'A'), chr($_+ord 'a'), chr(($_+$int) % 26 + ord 'a')), 0..25);
    return $str =~ s/([a-z])/$encrypt{$1}/igr;
}

unless (caller) {
    require Run::WeeklyChallenge;
    require Cpanel::JSON::XS;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { Cpanel::JSON::XS->new->ascii->allow_nonref->encode(encrypted_string($inputs->{'str'}, $inputs->{'int'})) },
        '{"str": "abc", "int": 1}',
        '{
            "type":"object",
            "properties": {
                "str": {"type": "string"},
                "int": {"type": "integer"}
            },
            "required":["str","int"],
            "additionalProperties": false
        }',
    );
}
