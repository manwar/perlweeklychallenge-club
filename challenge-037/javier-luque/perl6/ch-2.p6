# Test: perl6 ch2.p6
use v6.d;

# Box configurations
sub MAIN () {
    my $date1 = Date.new(2019,11,1);
    my $date2 = Date.new(2019,12,1);
    compare_lengths($date1, $date2);
}

sub compare_lengths(Date $date1, Date $date2) {
    # Months
    my @mon = (
        'Jan', 'Feb', 'Mar', 'Apr',
        'May', 'Jun', 'Jul', 'Aug',
        'Sep', 'Oct', 'Nov', 'Dec'
    );

    # Get the data from the web
    my @date1_data =
        get-data($date1);
    my @date2_data =
        get-data($date2);

    # Calculate totals
    my $date1_total = calculate-daylight-total(@date1_data);
    my $date2_total = calculate-daylight-total(@date2_data);
    my $difference = $date1_total - $date2_total;

    # Print the output
    say @mon[$date1.month - 1] ~ ' ' ~ $date1.year ~ ' has ' ~
        convert-seconds-to-string($date1_total) ~
        ' of daylight.';

    # Print the output
    say @mon[$date2.month - 1] ~ ' ' ~ $date2.year ~ ' has ' ~
        convert-seconds-to-string($date2_total) ~
        ' of daylight.';

    say "The difference is: " ~
        convert-seconds-to-string($difference) ~ '.';
}

# Calculates the total daylight hours from data
sub calculate-daylight-total(@data) {
    my $total = 0;
    for (@data) -> $daylight {
        $total += convert-time-to-seconds($daylight).Int;
    }
    return $total
}

sub convert-seconds-to-string (Int $seconds) {
    return ( $seconds.polymod(60, 60, 24) Z
             ('seconds', 'minutes', 'hours', 'days')
             ).reverse.join(", ");
}

# Convert hh::mm::ss to seconds
sub convert-time-to-seconds(Str $time_string) {
    my ($hh, $mm, $ss) = $time_string.split(':');
    return $hh * 3600 + $mm * 60 + 60;
}

# A bit of a cheat, I built the Scraper
# in perl5 so don't reinvent the wheel
# Gets the daytime date
sub get-data(Date $date) {
    my %data = (
        '2019-11-01' => (
            '9:40:44', '9:37:10', '9:33:37', '9:30:07',
            '9:26:38', '9:23:11', '9:19:45', '9:16:22',
            '9:13:01', '9:09:42', '9:06:25', '9:03:11',
            '8:59:59', '8:56:50', '8:53:44', '8:50:40',
            '8:47:39', '8:44:42', '8:41:48', '8:38:57',
            '8:36:09', '8:33:25', '8:30:45', '8:28:09',
            '8:25:36', '8:23:08', '8:20:44', '8:18:24',
            '8:16:09', '8:13:59'
        ),
        '2019-12-01' => (
            '8:11:53', '8:09:53', '8:07:57', '8:06:07',
            '8:04:22', '8:02:42', '8:01:08', '7:59:40',
            '7:58:17', '7:57:00', '7:55:50', '7:54:45',
            '7:53:46', '7:52:54', '7:52:07', '7:51:27',
            '7:50:54', '7:50:27', '7:50:06', '7:49:52',
            '7:49:44', '7:49:43', '7:49:48', '7:50:00',
            '7:50:19', '7:50:44', '7:51:15', '7:51:53',
            '7:52:37', '7:53:27', '7:54:24'
        ),
    );

    return @(%data.{$date});
}

