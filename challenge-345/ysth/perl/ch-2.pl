use 5.040;

sub magic_expression($string, $target) {

    my @solutions;

    my $glob_pattern = join '{,+,\*,-}', split //, $string;
    while (my $expression = glob $glob_pattern) {
        # from the challenge examples, we won't allow extra leading 0's in numbers in the expression
        next if $expression =~ /\b0[0-9]/;

        push @solutions, $expression if eval $expression == $target;
    }

    return @solutions;
}

sub main() {
    require Run::WeeklyChallenge;

    my $run_solution = sub ($inputs) {
        # format results like: ("2*3+2", "2+3*2")
        sprintf '(%s)', join ', ', map qq!"$_"!,
            magic_expression($inputs->{'string'}, $inputs->{'target'});
    };
    my $inputs_example = '{"string":"123","target":6}';
    my $inputs_schema_json = '{
        "type": "object",
        "properties": {
            "string": {
                "type": "string",
                "pattern": "^[0-9]+$"
            },
            "target": {"type": "integer"}
        },
        "required": ["string","target"],
        "additionalProperties": false
    }';
    Run::WeeklyChallenge::run_weekly_challenge($run_solution, $inputs_example, $inputs_schema_json);
}

main() unless caller;
