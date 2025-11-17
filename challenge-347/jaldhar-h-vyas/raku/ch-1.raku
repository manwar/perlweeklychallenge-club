#!/usr/bin/raku

sub MAIN(
    $str
) {
    my %months = (
        Jan => '01',
        Feb => '02',
        Mar => '03',
        Apr => '04',
        May => '05',
        Jun => '06',
        Jul => '07',
        Aug => '08',
        Sep => '09',
        Oct => '10',
        Nov => '11',
        Dec => '12'
    );
    my $date = S:g/(st|nd|rd|th)// given $str;
    my ($day, $month, $year) = $date.words;
 
    Date.new($year, %months{$month}, $day).say;
}