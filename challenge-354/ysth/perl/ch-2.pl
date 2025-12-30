use 5.036;

# https://theweeklychallenge.org/blog/perl-weekly-challenge-354/#TASK2

# rotate matrix cells right by k
sub shift_grid($matrix, $k) {
    use Exception::Class 'MixedLengthInputs' => { 'description' => 'matrix rows not all the same length' };

    # can't shift what isn't there (no rows or no columns)
    return $matrix unless @$matrix && $matrix->[0]->@*;
    my $columns = $matrix->[0]->@*;

    if (grep $columns != $matrix->[$_]->@*, 1..$#$matrix) {
        MixedLengthInputs->throw;
    }

    my @cells = map @$_, @$matrix;
    unshift @cells, splice @cells, -($k % @cells);
    my $shifted_matrix = [ map [ splice @cells, 0, $columns ], 0..$#$matrix ];

    return $shifted_matrix;
}

unless (caller) {
    require Run::WeeklyChallenge;
    require Cpanel::JSON::XS;
    Run::WeeklyChallenge::run_weekly_challenge(
        sub ($inputs) { Cpanel::JSON::XS->new->ascii->encode(shift_grid(@$inputs{qw/matrix k/})) },
        '{"matrix":[[1, 2, 3], [4, 5, 6], [7, 8, 9]],"k":1}',
        '{
            "type":"object",
            "properties": {
                "matrix": {"type": "array", "items": {"type": "array"}},
                "k": {"type": "integer", "minimum": 1}
            },
            "required":["matrix","k"],
            "additionalProperties": false
        }'
    );
}
