#!/usr/bin/env perl

# Macro preprocessor for brainfuck

use Modern::Perl;

my %macros = (
    INPUT => <<END,

Get ASCII number convert to integer and store in current cell

    ==== ==== ====
    cont digi num
    ==== ==== ====

    +
    [
     -                         cont=0
     >,
     ======SUB10======
     ----------

     [                         not 10
      <+>                      cont=1
      =====SUB38======
      ----------
      ----------
      ----------
      --------
      >
      =====MUL10=======
      [>+>+<<-]>>[<<+>>-]<     dup

      >>>+++++++++
      [
       <<<
       [>+>+<<-]>>[<<+>>-]<    dup
       [<<+>>-]
       >>-
      ]
      <<<[-]<
      ======RMOVE1======
      <
      [>+<-]
     ]
     <
    ]
    >>[<<+>>-]<<
END

    OUTPUT => <<END,

Output number in current cell

      [>+<-]>

      [
       ======DUP======
       [>+>+<<-]>>[<<+>>-]<


       ======MOD10====
       >+++++++++<
       [
        >>>+<<              bool= 1
        [>+>[-]<<-]         bool= ten==0
        >[<+>-]             ten = tmp
        >[<<++++++++++>>-]  if ten=0 ten=10
        <<-                 dec ten
        <-                  dec num
       ]
       +++++++++            num=9
       >[<->-]<             dec num by ten

       =======RROT======
          [>+<-]
       <  [>+<-]
       <  [>+<-]
       >>>[<<<+>>>-]
       <

       =======DIV10========
       >+++++++++<
       [
        >>>+<<                bool= 1
        [>+>[-]<<-]           bool= ten==0
        >[<+>-]               ten = tmp
        >[<<++++++++++>>>+<-] if ten=0 ten=10  inc div
        <<-                   dec ten
        <-                    dec num
       ]
       >>>>[<<<<+>>>>-]<<<<   copy div to num
       >[-]<                  clear ten

       =======INC1=========
       <+>
      ]

      <
      [
       =======MOVER=========
       [>+<-]

       =======ADD48========
       +++++++[<+++++++>-]<->

       =======PUTC=======
       <.[-]>

       ======MOVEL2========
       >[<<+>>-]<

       <-
      ]

      >++++[<++++++++>-]<.[-]
END

    DUP1R => "[>+>+<<-]>>[<<+>>-]<<",                   # duplicate a cell right
    DUP2R => "[>>+>+<<<-]>>>[<<<+>>>-]<<<",             # duplicate a cell 2 right
    DUP3R => "[>>>+>+<<<<-]>>>>[<<<<+>>>>-]<<<<",       # duplicate a cell 3 right
    DUP4R => "[>>>>+>+<<<<<-]>>>>>[<<<<<+>>>>>-]<<<<<", # duplicate a cell 4 right

    MOVE1L => "<[-]>[-<+>]",                            # move a cell left
    MOVE2L => "<<[-]>>[-<<+>>]",                        # move a cell 2 right
    MOVE3L => "<<<[-]>>>[-<<<+>>>]",                    # move a cell 3 right
    MOVE4L => "<<<<[-]>>>>[-<<<<+>>>>]",                # move a cell 4 right

    PLUS => <<END,

  == add x=x(plus)y ( *x y temp0 )
  >>[-]
  <[<+>>+<-]
  >[<+>-]
  [-]<[-]<
  ==            ( *x(plus)y )

END

    DIVMOD => <<END,

  == divmod         ( *n d )
  [->[->+>>]>[<<+>>[-<+>]>+>>]<<<<<]>[>>>]>[[-<+>]>+>>]<<<<<
  ==            ( 0 (divisor minus mod) mod div )
  >>>[-<<<+>>>]<<<  move div to first cell
  >[-]>[-<+>]<<     move mod to second cell
  ==                ( *div mod )

END

    MULT => <<END,

  == mult x=x*y     ( *x y temp0 temp1 )
  >>[-]         temp0=0
  >[-]          temp1=0
  <<<[>>>+<<<-]
  >>>[<<[<+>>+<-]>[<+>-]
  >-]
  [-]<[-]<[-]<
  ==                ( *x*y )

END

);

sub expand_macro {
    my($name) = @_;
    my $text = $macros{$name} // '';
    $text =~ s/[^-+<>\[\],.#]//g;
    return $text;
}

my $out = '';
while (<>) {
    s/\@(\w+)/ expand_macro($1) /ge;
    s/[^-+<>\[\],.#]//g;
    $out .= $_;
}

while ($out ne '') {
    say substr($out, 0, 64);
    substr($out, 0, 64) = '';
}
