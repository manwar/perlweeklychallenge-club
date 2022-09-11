use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-09-07
# Challenge #181 Hot Day ( Raku )

my %daytemps;

sub getPreviousDay ( $dt1 ) {

    my $d = Date.new($dt1);

    my $prev = $d.earlier(:1days);

    return $prev;

}

sub setupHashArray {

  for 'temperature.txt'.IO.lines -> $item is copy {

    chomp($item);

    $item ~~ s:g/\s+//;

    if $item {

        my @arr = $item.split(',');

        %daytemps{@arr[0]} = @arr[1];

    }

  }

}

sub main {

  setupHashArray();

  for 'temperature.txt'.IO.lines -> $item is copy {

    chomp($item);

    $item ~~ s:g/\s+//;

    my @arr = $item.split(',');

      if %daytemps{getPreviousDay(@arr[0])} {

        if %daytemps{@arr[0]} > %daytemps{getPreviousDay(@arr[0])} {

          say @arr[0];

        }

      }

  }

}

main();
