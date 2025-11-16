use 5.040;

sub format_phone_number($phone_number) {
    # hyphen in the middle of 4 final digits, otherwise every three digits
    join '-', $phone_number =~ y/0-9//cdr =~ /(\d{2,3}(?!\d\z))/ga;
}

sub main() {
    require Run::WeeklyChallenge;

    my $run_solution = sub ($inputs) {
        format_phone_number($inputs);
    };
    my $inputs_example = '"12 345-6789"';
    my $inputs_schema_json = '{
        "type": "string"
    }';
    Run::WeeklyChallenge::run_weekly_challenge($run_solution, $inputs_example, $inputs_schema_json);
}

main() unless caller;
