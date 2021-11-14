use v6;
unit sub MAIN(
    #|[ A yyyy/mm/dd formatted birthday. ]
    Str:D $input where ?m/ ^ $<year>=[\d+] '/' $<month>=[\d ** 2] '/' $<day>=[\d ** 2] $ /
) {
    my Date:D $birthday .= new: +$<year>, +$<month>, +$<day>, :&formatter;
    my Date:D $today    .= new: 2021, 9, 22, :&formatter;
    my Int:D  $lifespan  = $today - $birthday;
    put $birthday - $lifespan, ', ', $today + $lifespan;
    sub formatter(Dateish:D $date --> Str:D) { '%d/%02d/%02d'.sprintf: $date.year, $date.month, $date.day }
}
