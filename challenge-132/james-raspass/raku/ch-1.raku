unit sub MAIN(Date() $birthday, Date() $today = Date.today);

my $age = $today - $birthday;

printf q:to/END/, $birthday - $age, $today + $age;
    On the date you were born, someone who was your current age, would have been born on %s.
    Someone born today will be your current age on %s.
    END
