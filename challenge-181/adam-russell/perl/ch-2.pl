use v5.36;
use strict;
use warnings;
##
# You are given file with daily temperature record in random order.
# Write a script to find out days hotter than previous day.
##
use DBI;
use Text::CSV;
use Time::Piece;

sub hotter_than_previous{
    my($data) = @_;
    my @hotter;
    my $csv_parser = Text::CSV->new();
    my $dbh = DBI->connect(q/dbi:CSV:/, undef, undef, undef);
    $dbh->do(q/CREATE TABLE hotter_than_previous_a(day INTEGER, temperature INTEGER)/);
    $dbh->do(q/CREATE TABLE hotter_than_previous_b(day INTEGER, temperature INTEGER)/);
    for my $line (@{$data}){
        $line =~ tr/ //d;
        $csv_parser->parse($line);
        my($day, $temperature) = $csv_parser->fields();
        $day = Time::Piece->strptime($day, q/%Y-%m-%d/);
        $dbh->do(q/INSERT INTO hotter_than_previous_a VALUES(/ . $day->epoch . qq/, $temperature)/);
        $dbh->do(q/INSERT INTO hotter_than_previous_b VALUES(/ . $day->epoch . qq/, $temperature)/);
    }
    my $statement = $dbh->prepare(q/SELECT day FROM hotter_than_previous_a A INNER JOIN  
                                    hotter_than_previous_b B WHERE (A.day - B.day = 86400)                            
                                    AND A.temperature > B.temperature/);
    $statement->execute();
    while(my $row = $statement->fetchrow_hashref()){
        push @hotter, $row->{day};
    }
    @hotter = map {Time::Piece->strptime($_, q/%s/)->strftime(q/%Y-%m-%d/)} sort @hotter;
    unlink(q/hotter_than_previous_a/);
    unlink(q/hotter_than_previous_b/);
    return @hotter;
}

MAIN:{
    my $data = do{
        local $/;
        <DATA>;
    };
    my @hotter = hotter_than_previous([split(/\n/, $data)]);
    say join(qq/\n/, @hotter);
}

__DATA__
2022-08-01, 20
2022-08-09, 10
2022-08-03, 19
2022-08-06, 24
2022-08-05, 22
2022-08-10, 28
2022-08-07, 20
2022-08-04, 18
2022-08-08, 21
2022-08-02, 25