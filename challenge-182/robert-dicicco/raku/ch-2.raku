use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-09-14
# Challenge 182 Common Path ( Raku )

my @dirs = << /a/b/c/1/x.pl
              /a/b/c/d/e/2/x.pl
              /a/b/c/d/3/x.pl
              /a/b/c/4/x.pl
              /a/b/c/d/5/x.pl
              >>;

my $dir_cnt = @dirs.elems;

my $count = 0;

sub count-substring($big, $little) { +$big.comb: / :r $little / }

sub Intro() {

  print("Input:\n");

  for (@dirs) -> $d {

    print("\t$d\n");

  }

}

sub GetDirs( $test ) {

  my @test_dirs = $test.split('/');

  @test_dirs.pop();

  my $new_path = @test_dirs.join('/');

  return $new_path;

}

sub TestDir( $np) {

  for ( @dirs) -> $d {

    if count-substring($d, $np) {

      $count++;

    }

  }

  if $count == $dir_cnt {

    print("Output:\n");

    print("\t$np\n");

    exit();

  }

}

sub main() {

  Intro();

  my $new_path = GetDirs( @dirs[0]);

  my $secnew = $new_path;

  while (True) {

    $count = 0;

    $new_path = GetDirs($secnew);

    TestDir($new_path);

    $secnew = $new_path;

  }

}

main();
