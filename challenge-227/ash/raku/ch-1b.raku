sub count-friday-the13s($year) {
    [+] map {
        5 == DateTime.new(year => $year, month => $_, day => 13).day-of-week
    }, 1..12;   
}

say count-friday-the13s(2023);
