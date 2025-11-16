use 5.040;

use Lingua::EN::Inflect ();
use Time::Piece ();

sub format_date($date_string) {
    use Exception::Class 'InvalidDateString' => { 'description' => "Invalid date string" };

    state @mon_list = Time::Piece::mon_list();
    state %month = map( ($mon_list[$_], $_+1), 0..$#mon_list );
    state @day_list = map Lingua::EN::Inflect::ORD($_), 1..31;
    state %day = map( ($day_list[$_], $_+1), 0..$#day_list );
    state $parse_date_string = do { local $"='|'; qr/^(@day_list) (@mon_list) ((?:19|20)\d\d|2100)\z/a };

    my ($day, $month, $year) = $date_string =~ $parse_date_string
        or InvalidDateString->throw;

    my $formatted_date = sprintf '%04d-%02d-%02d', $year, $month{$month}, $day{$day};

    return $formatted_date;
}

sub main() {
    require Run::WeeklyChallenge;

    my $run_solution = sub ($inputs) {
        format_date($inputs);
    };
    my $inputs_example = '"10th Nov 2025"';
    my $inputs_schema_json = '{
        "type": "string"
    }';
    Run::WeeklyChallenge::run_weekly_challenge($run_solution, $inputs_example, $inputs_schema_json);
}

main() unless caller;
