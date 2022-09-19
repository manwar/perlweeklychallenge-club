#!/usr/bin/env raku

sub hot-day (*@day) {
   my %day{Date()} =  @day;
   %day
   andthen .grep: -> (:$key, :$value) { $value > ( %day{$key.pred} // $value ) } \
   andthen .map: *.key
   andthen .sort
}

multi MAIN (Bool :test($)!) {
    use Test;
    is hot-day(
        '2022-08-01', 20,
        '2022-08-09', 10,
        '2022-08-03', 19,
        '2022-08-06', 24,
        '2022-08-05', 22,
        '2022-08-10', 28,
        '2022-08-07', 20,
        '2022-08-04', 18,
        '2022-08-08', 21,
        '2022-08-02', 25,
    ),
    <2022-08-02
    2022-08-05
    2022-08-06
    2022-08-08
    2022-08-10>;
    done-testing;
}

multi MAIN ($file=$*IN) {
    lines($file)
    andthen .map: |*.split: ','
    andthen hot-day $_
    andthen .put
}
