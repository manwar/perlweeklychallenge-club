use 5.010;
use Time::Piece; # Easy weekday + math

my $date_fmt = '%Y-%m-%d'; # Per task description

sub bank_holiday_ofs {
    my ($start_date, $offset, @holidays) = @_;

    my $t = Time::Piece->strptime($start_date => $date_fmt) - 86400;

    my %holiday = map { $_ => 1 } @holidays;
    $offset++; # Account for today
    
    while ($offset) {
        $t += 86400; # Advance day
        $offset-- unless $t->wday == 1 or $t->wday == 7 
                      or $holiday{ $t->strftime($date_fmt) };
    }

    $t->strftime($date_fmt);
}

#say bank_holiday_ofs('2018-06-28', 3);               # 2018-07-03
#say bank_holiday_ofs('2018-06-28', 3, '2018-07-03'); # 2018-07-04
