#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
$|++;

my $stack = VerboseStack->new;
$stack->print;

# run with --interactive to have... an interactive session
if (@ARGV && $ARGV[0] eq '--interactive') {
   my $real_stack = $stack->stack;
   my $prompt = "\ncommand> ";
   print {*STDOUT} $prompt;
   while (<STDIN>) {
      my ($cmd, @args) = split m{\s+}mxs;
      $cmd = lc($cmd);
      last if grep { $_ eq $cmd } qw< quit exit bye >;
      eval {
         my $v = $real_stack->$cmd(@args);
         say "$cmd: $v" if grep { $_ eq $cmd } qw< max min pop top >;
         1;
      } or do {
         say $@ =~ m{\s at \s}mxs ? "unknown command $cmd" : "error: $@";
      };
      $stack->print;
      print {*STDOUT} $prompt;
   }
}
else {
   $stack->push(2);
   $stack->push(-1);
   $stack->push(0);
   $stack->pop;       # removes 0
   say 'top returns --> ', $stack->top; # prints -1
   $stack->push(0);
   say 'min returns --> ', $stack->min; # prints -1
}

package VerboseStack;
use 5.024;
use experimental qw< postderef signatures >;
sub AUTOLOAD ($self, @as) {
   my ($stack, $echo) = $self->@{qw< stack echo >};
   (my $mname = our $AUTOLOAD) =~ s{\A.*::}{}mxs;
   say "\n$mname @as" if $echo;
   my $method = $stack->can($mname) or die "no method '$mname'\n";
   my @r = wantarray ? $stack->$method(@as) : scalar $stack->$method(@as);
   $self->print;
   return wantarray ? @r : defined(wantarray) ? $r[0] : ();
}
sub DESTROY {}
sub echo ($s) { $s->{echo} = 1 }
sub new ($pk, @as) { bless {echo => 1, @as, stack => Stack->new}, $pk }
sub noecho ($s) { $s->{echo} = 0 }
sub print ($self) {
   my $stack = $self->{stack};
   my ($n, $dump, $siz_ind) = ($stack->size, '', 'empty');
   ($dump, $siz_ind) = ("$stack\n", $n == 1 ? '1 item' : "$n items") if $n;
   print {*STDOUT} "---\n$dump------- ($siz_ind)\n";
}
sub stack ($self) { return $self->{stack} }
1;

package Stack;
use 5.024;
use experimental qw< postderef signatures >;
use List::Util ();
use overload qq{""} => \&to_string;
sub is_empty ($s)  { !($s->@*) }
sub max ($s)       { $s->@* ? List::Util::max($s->@*) : die "empty\n" }
sub min ($s)       { $s->@* ? List::Util::min($s->@*) : die "empty\n" }
sub new ($package) { bless [], $package }
sub pop ($s)       { $s->@* ? CORE::pop $s->@* : die "empty\n" }
sub push ($s, $e)  { CORE::push $s->@*, $e }
sub size ($s)      { scalar $s->@* }
sub top ($s)       { $s->@* ? $s->[-1] : die "empty\n" }
sub to_string ($s, @rest) {
   return '' unless $s->@*;
   my ($min, $max, $is_top, @lines) = ($s->min, $s->max, 1);
   for my $e (reverse $s->@*) {
      CORE::push @lines, sprintf '{%5s}', $e;
      my @features;
      CORE::push @features, 'top' if $is_top;
      CORE::push @features, 'min' if $e == $min;
      CORE::push @features, 'max' if $e == $max;
      $lines[-1] .= ' (' . join(', ', @features) . ')' if @features;
      $is_top = 0;
   }
   return join "\n", @lines;
}
1;
