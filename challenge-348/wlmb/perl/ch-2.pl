#!/usr/bin/env perl
# Perl weekly challenge 348
# Task 2:  Covert Time
#
# See https://wlmb.github.io/2025/11/17/PWC348/#task-2-covert-time
use v5.36;
use feature qw(try);
use POSIX qw(floor);
die <<~"FIN" unless @ARGV and @ARGV%2==0;
    Usage: $0 S0 T0 S1 T1...
    to find how many operations (add 60, 15, 5 or 1 minute) are necessary to convert
    the source time Sn to the target time Tn. The times are specified in the HH::MM
    24 hour format.
    FIN
my @minutes_to_add=(60, 15, 5, 1);
for my($source, $target)(@ARGV){
    try {
        my($source_mins, $target_mins) = map {
            die "Wrong format: $_" unless /^(\d?\d):(\d{2})$/;
            my ($hours, $minutes) = ($1, $2);
            die "Invalid hours: $hours" unless 0<=$hours<24;
            die "Invalid minutes: $minutes" unless 0<=$minutes<60;
            $hours*60+$minutes
        } $source, $target;
        my $difference = ($target_mins - $source_mins)%(24*60); # modulo one day
        my $operations = 0;
        my $count;
        $operations += $_ for map{
            ($count, $difference)=(floor($difference/$_), $difference%$_);
            $count
        } @minutes_to_add;
        say "$source, $target -> $operations";
    }
    catch($e){warn $e}
}
