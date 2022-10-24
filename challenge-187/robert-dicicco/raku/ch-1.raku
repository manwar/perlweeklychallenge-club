use v6;

# AUTHOR: Robert DiCicco

# DATE: 2022-10-18

# Challenge 187 Days Together ( Raku )



my @dates = <2022-01-12 2022-01-20 2022-01-15 2022-01-18

             2022-03-02 2022-03-12 2022-03-13 2022-03-14

             2022-03-02 2022-03-12 2022-03-11 2022-03-15

             2022-03-30 2022-04-05 2022-03-28 2022-04-02>

             ;

 my  @B = ();

 my  @E = ();

 my  @O = ();



sub RangeDates ( Str $b,Str $e, Str $s) {

  my ($year,$month,$day)= split("-",$b);

  my $dt = Date.new($b);

 ($year,$month,$day)= split("-",$e);

  my $dt2 = Date.new($e);

  while $dt <= $dt2 {

    $s eq "B" ?? @B.push: $dt !! @E.push: $dt;

    $dt = $dt.later(:1days);

  }

}



sub main {

  loop (my $i = 0; $i < @dates.elems; $i += 4) {

    RangeDates(@dates[$i],@dates[$i+1], "B");

    RangeDates(@dates[$i+2],@dates[$i+3], "E");

    for @B -> $b {

      if $b eq @E.any {

        @O.push: $b;

      }

    }

    print "Output: " ~ @O.elems ~ "\n";

    @B = ();

    @E = ();

    @O = ();

  }

}



main();
