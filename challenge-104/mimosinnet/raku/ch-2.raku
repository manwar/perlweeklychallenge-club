# https://perlweeklychallenge.org/blog/perl-weekly-challenge-104/

class NIM {
  has $!tokens = 12;
  has $.name;
  has $.turn is rw;

  method token-human-get() {
    my $token;
    loop {
      $token = prompt "$!name, there are $!tokens tokens left. How many tokens would you like to pick? (1-3) ";
      last if $token ∈ (1..3);
      say 'You have tu choose between 1 and 3 tokens';
    }
    return $token;
  }

  # The computer strategy follows athanasius solution
  method token-comp-get() {
    return $!tokens     if      $!tokens <  4;
    return $!tokens % 4 unless  $!tokens %% 4;
    return (1..3).pick;
  }

  method start-game() {
    loop {
      given $!turn {
        when 'human' { 
          $!tokens = $!tokens - self.token-human-get();
          self.win if $!tokens == 0;
          $!turn = 'comp';
        }
        when 'comp' {
          my $get-tokens = self.token-comp-get();
          say "There are $!tokens tokens left. I get $get-tokens";
          $!tokens = $!tokens - $get-tokens;
          self.win if $!tokens == 0;
          $!turn = 'human';
        }
      }
    }
  }

  method win() {
    given $!turn {
     when 'human' { say "Congratualtions $.name. You have won" }
     when 'comp'  { say "I am sorry $.name. I have won" }
    }
    exit;
  }
}

sub MAIN( $name = 'Human' ) {
  my $nim = NIM.new( name => $name );
  say "Hello $name";
  if Bool.pick {
    say 'I start the game';
    $nim.turn = 'comp';
  } else {
    say 'You start the game';
    $nim.turn = 'human';
  }
  $nim.start-game;
}

