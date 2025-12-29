use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-353/#TASK2

sub validate_coupon($codes, $names, $status) {
    state %valid_names = ('electronics' => 1, 'grocery' => 1, 'pharmacy' => 1, 'restaurant' => 1);
    use Exception::Class 'MixedLengthInputs' => { 'description' => 'Arrays not all of the same length' };

    if (@$codes != @$names || @$codes != @$status) {
        MixedLengthInputs->throw;
    }

    my @valid = map $codes->[$_] =~ /^\w+\z/a && exists $valid_names{$names->[$_]} && ($status->[$_] || '') eq 'true', 0..$#$codes;

    return \@valid;
}

unless (caller) {
    require Run::WeeklyChallenge;
    require Cpanel::JSON::XS;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { Cpanel::JSON::XS->new->ascii->encode(validate_coupon(@$inputs{qw/codes names status/})) },
        '{"codes": ["A123", "B_456", "C789", "D@1", "E123"], "names": ["electronics", "restaurant", "electronics", "pharmacy", "grocery"], "status": ["true", "false", "true", "true", "true"]}',
        '{
            "type":"object",
            "properties": {
                "codes": { "type": "array", "items": { "type": "string" } },
                "names": { "type": "array", "items": { "type": "string" } },
                "status": { "type": "array", "items": { "type": "string" } }
            },
            "required": ["codes","names","status"],
            "additionalProperties": false
        }'
    );
}
