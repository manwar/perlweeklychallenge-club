use MONKEY;
use nqp;

class Contextualizer {
  submethod ctxsave(*@args --> Nil) {
    $*MAIN_CTX := nqp::ctxcaller(nqp::ctx());
  }
}

sub MAIN(Str $s) {
  my $compiler = nqp::getcomp('perl6');

  my $*MAIN_CTX := nqp::ctx();
  my $*CTXSAVE := Contextualizer;

  $compiler.eval("my \${$s.uc} = ':)'", :outer_ctx($*MAIN_CTX), :interactive(1));
  $compiler.eval("\${$s.uc}.say", :outer_ctx($*MAIN_CTX), :interactive(1));
}