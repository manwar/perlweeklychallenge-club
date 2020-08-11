my @ascii_num= (
    ["  0000  "," 00  00 "," 00  00 "," 00  00 ","  0000  "],
    ["   11   ","   11   ","   11   ","   11   ","   11   "],
    [" 222222 ","     22 "," 222222 "," 22     "," 222222 "],
    [" 333333 ","     33 "," 333333 ","     33 "," 333333 "],
    [" 44  44 "," 44  44 "," 444444 ","     44 ","     44 "],
    [" 555555 "," 55     "," 555555 ","     55 "," 555555 "],
    [" 666666 "," 66     "," 666666 "," 66  66 "," 666666 "],
    [" 777777 ","     77 ","     77 ","     77 ","     77 "],
    [" 888888 "," 88  88 "," 888888 "," 88  88 "," 888888 "],
    [" 999999 "," 99  99 "," 999999 ","     99 "," 999999 "],
    ["    "," :: ","    "," :: ","    "],
    ["    ","    ","    ","    ","    "]
);
my $toggler = 1;
loop {
    my $dig_time = DateTime.now;
    my @printline;
    
    $toggler = !$toggler;
    for $dig_time.hh-mm-ss.split("",:skip-empty) -> $x {
        for (0 .. 4) -> $i {
            @printline[$i] ~= @ascii_num[ ($x~~/\:/) ?? ( $toggler ?? 10 !! 11) !! $x ][$i];
        }
    }

    #This might cause flicker
    shell (($*DISTRO.name eq 'mswin32') ?? 'cls' !! 'clear');

    for (0 .. 4) -> $i {
        say @printline[$i];
    }

    say "\nToday is "~qw|Monday Tuesday Wednesday Thursday Friday Saturday Sunday|[$dig_time.day-of-week-1]
    ~": "~qw|January February March April May June July August September October November December|[$dig_time.month-1]
    ~" "~$dig_time.day~","
    ~" "~$dig_time.year;
    sleep .5
}