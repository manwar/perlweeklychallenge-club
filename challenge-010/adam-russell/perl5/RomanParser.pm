# @(#)yaccpar 1.8 (Berkeley) 01/20/91 (JAKE-P5BP-0.6 04/26/98)
package RomanParser;
#line 2 "roman.y"
#line 4 "RomanParser.pm"
$I=257;
$II=258;
$III=259;
$IV=260;
$V=261;
$IX=262;
$X=263;
$XX=264;
$XXX=265;
$XL=266;
$L=267;
$XC=268;
$C=269;
$CC=270;
$CCC=271;
$CD=272;
$D=273;
$CM=274;
$M=275;
$MM=276;
$MMM=277;
$EOL=278;
$YYERRCODE=256;
@yylhs = (                                               -1,
    0,    0,    1,    1,    2,    2,    2,    2,    2,    2,
    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
    2,    2,    2,    2,    2,    2,
);
@yylen = (                                                2,
    0,    2,    2,    1,    1,    1,    1,    1,    1,    1,
    1,    1,    1,    1,    1,    1,    1,    1,    1,    1,
    1,    1,    1,    1,    1,    2,    2,    2,    2,    2,
    2,    2,    2,    2,    2,    2,    2,    2,    2,    2,
    2,    2,    2,    2,    2,    2,
);
@yydefred = (                                             1,
    0,    5,    6,    7,    8,    9,   10,   11,   12,   13,
   14,   15,   16,   17,   18,   19,   20,   21,   22,   23,
   24,   25,    4,    2,    0,   26,   27,   28,   29,   30,
   31,   32,   33,   34,   35,   36,   37,   38,   39,   40,
   41,   42,   43,   44,   45,   46,    3,
);
@yydgoto = (                                              1,
   24,   25,
);
@yysindex = (                                             0,
 -257,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0, -235,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,
);
@yyrindex = (                                             0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,    0,    0,    0,
    0,    0,    0,    0,    0,    0,    0,
);
@yygindex = (                                             0,
    0,    0,
);
$YYTABLESIZE=43;
@yytable = (                                              2,
    3,    4,    5,    6,    7,    8,    9,   10,   11,   12,
   13,   14,   15,   16,   17,   18,   19,   20,   21,   22,
   23,   26,   27,   28,   29,   30,   31,   32,   33,   34,
   35,   36,   37,   38,   39,   40,   41,   42,   43,   44,
   45,   46,   47,
);
@yycheck = (                                            257,
  258,  259,  260,  261,  262,  263,  264,  265,  266,  267,
  268,  269,  270,  271,  272,  273,  274,  275,  276,  277,
  278,  257,  258,  259,  260,  261,  262,  263,  264,  265,
  266,  267,  268,  269,  270,  271,  272,  273,  274,  275,
  276,  277,  278,
);
$YYFINAL=1;
#ifndef YYDEBUG
#define YYDEBUG 0
#endif
$YYMAXTOKEN=278;
#if YYDEBUG
@yyname = (
"end-of-file",'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','','',
'','','','','','','','','','','','','','','','','','','','','','','',"I","II","III","IV","V","IX","X",
"XX","XXX","XL","L","XC","C","CC","CCC","CD","D","CM","M","MM","MMM","EOL",
);
@yyrule = (
"\$accept : start",
"start :",
"start : start input",
"input : roman EOL",
"input : EOL",
"roman : I",
"roman : II",
"roman : III",
"roman : IV",
"roman : V",
"roman : IX",
"roman : X",
"roman : XX",
"roman : XXX",
"roman : XL",
"roman : L",
"roman : XC",
"roman : C",
"roman : CC",
"roman : CCC",
"roman : CD",
"roman : D",
"roman : CM",
"roman : M",
"roman : MM",
"roman : MMM",
"roman : roman I",
"roman : roman II",
"roman : roman III",
"roman : roman IV",
"roman : roman V",
"roman : roman IX",
"roman : roman X",
"roman : roman XX",
"roman : roman XXX",
"roman : roman XL",
"roman : roman L",
"roman : roman XC",
"roman : roman C",
"roman : roman CC",
"roman : roman CCC",
"roman : roman CD",
"roman : roman D",
"roman : roman CM",
"roman : roman M",
"roman : roman MM",
"roman : roman MMM",
);
#endif
sub yyclearin {
  my  $p;
  ($p) = @_;
  $p->{yychar} = -1;
}
sub yyerrok {
  my  $p;
  ($p) = @_;
  $p->{yyerrflag} = 0;
}
sub new {
  my $p = bless {}, $_[0];
  $p->{yylex} = $_[1];
  $p->{yyerror} = $_[2];
  $p->{yydebug} = $_[3];
  return $p;
}
sub YYERROR {
  my  $p;
  ($p) = @_;
  ++$p->{yynerrs};
  $p->yy_err_recover;
}
sub yy_err_recover {
  my  $p;
  ($p) = @_;
  if ($p->{yyerrflag} < 3)
  {
    $p->{yyerrflag} = 3;
    while (1)
    {
      if (($p->{yyn} = $yysindex[$p->{yyss}->[$p->{yyssp}]]) && 
          ($p->{yyn} += $YYERRCODE) >= 0 && 
          $p->{yyn} <= $#yycheck &&
          $yycheck[$p->{yyn}] == $YYERRCODE)
      {
        warn("yydebug: state " . 
                     $p->{yyss}->[$p->{yyssp}] . 
                     ", error recovery shifting to state" . 
                     $yytable[$p->{yyn}] . "\n") 
                       if $p->{yydebug};
        $p->{yyss}->[++$p->{yyssp}] = 
          $p->{yystate} = $yytable[$p->{yyn}];
        $p->{yyvs}->[++$p->{yyvsp}] = $p->{yylval};
        next yyloop;
      }
      else
      {
        warn("yydebug: error recovery discarding state ".
              $p->{yyss}->[$p->{yyssp}]. "\n") 
                if $p->{yydebug};
        return(undef) if $p->{yyssp} <= 0;
        --$p->{yyssp};
        --$p->{yyvsp};
      }
    }
  }
  else
  {
    return (undef) if $p->{yychar} == 0;
    if ($p->{yydebug})
    {
      $p->{yys} = '';
      if ($p->{yychar} <= $YYMAXTOKEN) { $p->{yys} = 
        $yyname[$p->{yychar}]; }
      if (!$p->{yys}) { $p->{yys} = 'illegal-symbol'; }
      warn("yydebug: state " . $p->{yystate} . 
                   ", error recovery discards " . 
                   "token " . $p->{yychar} . "(" . 
                   $p->{yys} . ")\n");
    }
    $p->{yychar} = -1;
    next yyloop;
  }
0;
} # yy_err_recover

sub yyparse {
  my  $p;
  my $s;
  ($p, $s) = @_;
  if ($p->{yys} = $ENV{'YYDEBUG'})
  {
    $p->{yydebug} = int($1) if $p->{yys} =~ /^(\d)/;
  }

  $p->{yynerrs} = 0;
  $p->{yyerrflag} = 0;
  $p->{yychar} = (-1);

  $p->{yyssp} = 0;
  $p->{yyvsp} = 0;
  $p->{yyss}->[$p->{yyssp}] = $p->{yystate} = 0;

yyloop: while(1)
  {
    yyreduce: {
      last yyreduce if ($p->{yyn} = $yydefred[$p->{yystate}]);
      if ($p->{yychar} < 0)
      {
        if ((($p->{yychar}, $p->{yylval}) = 
            &{$p->{yylex}}($s)) < 0) { $p->{yychar} = 0; }
        if ($p->{yydebug})
        {
          $p->{yys} = '';
          if ($p->{yychar} <= $#yyname) 
             { $p->{yys} = $yyname[$p->{yychar}]; }
          if (!$p->{yys}) { $p->{yys} = 'illegal-symbol'; };
          warn("yydebug: state " . $p->{yystate} . 
                       ", reading " . $p->{yychar} . " (" . 
                       $p->{yys} . ")\n");
        }
      }
      if (($p->{yyn} = $yysindex[$p->{yystate}]) && 
          ($p->{yyn} += $p->{yychar}) >= 0 && 
          $p->{yyn} <= $#yycheck &&
          $yycheck[$p->{yyn}] == $p->{yychar})
      {
        warn("yydebug: state " . $p->{yystate} . 
                     ", shifting to state " .
              $yytable[$p->{yyn}] . "\n") if $p->{yydebug};
        $p->{yyss}->[++$p->{yyssp}] = $p->{yystate} = 
          $yytable[$p->{yyn}];
        $p->{yyvs}->[++$p->{yyvsp}] = $p->{yylval};
        $p->{yychar} = (-1);
        --$p->{yyerrflag} if $p->{yyerrflag} > 0;
        next yyloop;
      }
      if (($p->{yyn} = $yyrindex[$p->{yystate}]) && 
          ($p->{yyn} += $p->{'yychar'}) >= 0 &&
          $p->{yyn} <= $#yycheck &&
          $yycheck[$p->{yyn}] == $p->{yychar})
      {
        $p->{yyn} = $yytable[$p->{yyn}];
        last yyreduce;
      }
      if (! $p->{yyerrflag}) {
        &{$p->{yyerror}}('syntax error', $s);
        ++$p->{yynerrs};
      }
      return(undef) if $p->yy_err_recover;
    } # yyreduce
    warn("yydebug: state " . $p->{yystate} . 
                 ", reducing by rule " . 
                 $p->{yyn} . " (" . $yyrule[$p->{yyn}] . 
                 ")\n") if $p->{yydebug};
    $p->{yym} = $yylen[$p->{yyn}];
    $p->{yyval} = $p->{yyvs}->[$p->{yyvsp}+1-$p->{yym}];
if ($p->{yyn} == 3) {
#line 8 "roman.y"
{ print $p->{yyvs}->[$p->{yyvsp}-1] . "\n"; }
}
if ($p->{yyn} == 5) {
#line 11 "roman.y"
{$p->{yyval} += 1}
}
if ($p->{yyn} == 6) {
#line 12 "roman.y"
{$p->{yyval} +=2}
}
if ($p->{yyn} == 7) {
#line 13 "roman.y"
{$p->{yyval} +=3}
}
if ($p->{yyn} == 8) {
#line 14 "roman.y"
{$p->{yyval} += 4}
}
if ($p->{yyn} == 9) {
#line 15 "roman.y"
{$p->{yyval} += 5}
}
if ($p->{yyn} == 10) {
#line 16 "roman.y"
{$p->{yyval} += 9}
}
if ($p->{yyn} == 11) {
#line 17 "roman.y"
{$p->{yyval} += 10}
}
if ($p->{yyn} == 12) {
#line 18 "roman.y"
{$p->{yyval} += 20}
}
if ($p->{yyn} == 13) {
#line 19 "roman.y"
{$p->{yyval} += 30}
}
if ($p->{yyn} == 14) {
#line 20 "roman.y"
{$p->{yyval} += 40}
}
if ($p->{yyn} == 15) {
#line 21 "roman.y"
{$p->{yyval} += 50}
}
if ($p->{yyn} == 16) {
#line 22 "roman.y"
{$p->{yyval} += 90}
}
if ($p->{yyn} == 17) {
#line 23 "roman.y"
{$p->{yyval} += 100}
}
if ($p->{yyn} == 18) {
#line 24 "roman.y"
{$p->{yyval} += 200}
}
if ($p->{yyn} == 19) {
#line 25 "roman.y"
{$p->{yyval} += 300}
}
if ($p->{yyn} == 20) {
#line 26 "roman.y"
{$p->{yyval} += 400}
}
if ($p->{yyn} == 21) {
#line 27 "roman.y"
{$p->{yyval} += 500}
}
if ($p->{yyn} == 22) {
#line 28 "roman.y"
{$p->{yyval} += 900}
}
if ($p->{yyn} == 23) {
#line 29 "roman.y"
{$p->{yyval} += 1000}
}
if ($p->{yyn} == 24) {
#line 30 "roman.y"
{$p->{yyval} += 2000}
}
if ($p->{yyn} == 25) {
#line 31 "roman.y"
{$p->{yyval} += 3000}
}
if ($p->{yyn} == 26) {
#line 32 "roman.y"
{$p->{yyval} += 1}
}
if ($p->{yyn} == 27) {
#line 33 "roman.y"
{$p->{yyval} += 2}
}
if ($p->{yyn} == 28) {
#line 34 "roman.y"
{$p->{yyval} += 3}
}
if ($p->{yyn} == 29) {
#line 35 "roman.y"
{$p->{yyval} += 4}
}
if ($p->{yyn} == 30) {
#line 36 "roman.y"
{$p->{yyval} += 5}
}
if ($p->{yyn} == 31) {
#line 37 "roman.y"
{$p->{yyval} += 9}
}
if ($p->{yyn} == 32) {
#line 38 "roman.y"
{$p->{yyval} += 10}
}
if ($p->{yyn} == 33) {
#line 39 "roman.y"
{$p->{yyval} += 20}
}
if ($p->{yyn} == 34) {
#line 40 "roman.y"
{$p->{yyval} += 30}
}
if ($p->{yyn} == 35) {
#line 41 "roman.y"
{$p->{yyval} += 40}
}
if ($p->{yyn} == 36) {
#line 42 "roman.y"
{$p->{yyval} += 50}
}
if ($p->{yyn} == 37) {
#line 43 "roman.y"
{$p->{yyval} += 90}
}
if ($p->{yyn} == 38) {
#line 44 "roman.y"
{$p->{yyval} += 100}
}
if ($p->{yyn} == 39) {
#line 45 "roman.y"
{$p->{yyval} += 200}
}
if ($p->{yyn} == 40) {
#line 46 "roman.y"
{$p->{yyval} += 300}
}
if ($p->{yyn} == 41) {
#line 47 "roman.y"
{$p->{yyval} += 400}
}
if ($p->{yyn} == 42) {
#line 48 "roman.y"
{$p->{yyval} += 500}
}
if ($p->{yyn} == 43) {
#line 49 "roman.y"
{$p->{yyval} += 900}
}
if ($p->{yyn} == 44) {
#line 50 "roman.y"
{$p->{yyval} += 1000}
}
if ($p->{yyn} == 45) {
#line 51 "roman.y"
{$p->{yyval} += 2000}
}
if ($p->{yyn} == 46) {
#line 52 "roman.y"
{$p->{yyval} += 3000}
}
#line 468 "RomanParser.pm"
    $p->{yyssp} -= $p->{yym};
    $p->{yystate} = $p->{yyss}->[$p->{yyssp}];
    $p->{yyvsp} -= $p->{yym};
    $p->{yym} = $yylhs[$p->{yyn}];
    if ($p->{yystate} == 0 && $p->{yym} == 0)
    {
      warn("yydebug: after reduction, shifting from state 0 ",
            "to state $YYFINAL\n") if $p->{yydebug};
      $p->{yystate} = $YYFINAL;
      $p->{yyss}->[++$p->{yyssp}] = $YYFINAL;
      $p->{yyvs}->[++$p->{yyvsp}] = $p->{yyval};
      if ($p->{yychar} < 0)
      {
        if ((($p->{yychar}, $p->{yylval}) = 
            &{$p->{yylex}}($s)) < 0) { $p->{yychar} = 0; }
        if ($p->{yydebug})
        {
          $p->{yys} = '';
          if ($p->{yychar} <= $#yyname) 
            { $p->{yys} = $yyname[$p->{yychar}]; }
          if (!$p->{yys}) { $p->{yys} = 'illegal-symbol'; }
          warn("yydebug: state $YYFINAL, reading " . 
               $p->{yychar} . " (" . $p->{yys} . ")\n");
        }
      }
      return ($p->{yyvs}->[1]) if $p->{yychar} == 0;
      next yyloop;
    }
    if (($p->{yyn} = $yygindex[$p->{yym}]) && 
        ($p->{yyn} += $p->{yystate}) >= 0 && 
        $p->{yyn} <= $#yycheck && 
        $yycheck[$p->{yyn}] == $p->{yystate})
    {
        $p->{yystate} = $yytable[$p->{yyn}];
    } else {
        $p->{yystate} = $yydgoto[$p->{yym}];
    }
    warn("yydebug: after reduction, shifting from state " . 
        $p->{yyss}->[$p->{yyssp}] . " to state " . 
        $p->{yystate} . "\n") if $p->{yydebug};
    $p->{yyss}[++$p->{yyssp}] = $p->{yystate};
    $p->{yyvs}[++$p->{yyvsp}] = $p->{yyval};
  } # yyloop
} # yyparse
#line 55 "roman.y"
sub yylex{
    my($s) = @_;
    my($c, $val);

    while(($c = $s->getc) eq " " || $c eq "\t"){ 
        # ignore single spaces and tabs 
    }

    if ($c eq ""){
	return 0;
    }
    elsif($c eq "\n"){
	return $EOL;
    }
    elsif($c eq "I") {
	$val = $c;
        $c = $s->getc;  
        if($c ne "I" && $c ne "X" && $c ne "V" && $c ne "\n"){
            return 0;  
        }  
        elsif($c eq "I"){
            $val .= $c;   
            $c = $s->getc;  
            if($c eq "I"){
                $val .= $c;
                $c = $s->getc;  
                if($c ne "\n"){
                    return 0;  
                }  
                $s->ungetc; 
                return($III, $val);   
            }
            else{
                if($c ne "\n"){
                    return 0;  
                }  
                $s->ungetc; 
                return($II,$val);   
            }  
        }  
        elsif($c eq "V"){
            $val .= $c;  
	    return($IV, $val);
        }  
        elsif($c eq "X"){
            $val .= $c;  
	    return($IX, $val);
        }  
	$s->ungetc;
	return($I, $val);
    }
    elsif($c eq "V"){
        return($V, $c);   
    }  
    elsif($c eq "X"){
	$val = $c;
        $c = $s->getc;  
        if($c eq "X"){
            $val .= $c;   
            $c = $s->getc;  
            if($c eq "X"){
                $val .= $c;
                return($XXX, $val);   
            }
            else{
                $s->ungetc; 
                return($XX,$val);   
            }  
        }  
        if($c eq "L"){
            $val .= $c;  
	    return ($XL, $val);
        }  
        elsif($c eq "C"){
            $val .= $c;  
	    return ($XC, $val);
        }  
	$s->ungetc;
        return($X, $c);   
    }  
    elsif($c eq "L"){
        return($L, $c);   
    }  
    elsif($c eq "C"){
	$val = $c;
        $c = $s->getc;  
        if($c eq "C"){
            $val .= $c;   
            $c = $s->getc;  
            if($c eq "C"){
                $val .= $c;
                return($CCC, $val);   
            }
            else{
                $s->ungetc; 
                return($CC,$val);   
            }  
        }  
        if($c eq "D"){
            $val .= $c;  
	    return ($CD, $val);
        }  
        elsif($c eq "M"){
            $val .= $c;  
	    return ($CM, $val);
        }  
	$s->ungetc;
        return($C, $c);   
    }  
    elsif($c eq "D"){
        return($D, $c);   
    }  
    elsif($c eq "M"){
	$val = $c;
        $c = $s->getc;  
        if($c eq "M"){
            $val .= $c;   
            $c = $s->getc;  
            if($c eq "M"){
                $val .= $c;
                return($MMM, $val);   
            }
            else{
                $s->ungetc; 
                return($MM,$val);   
            }  
        }  
	$s->ungetc;
        return($M, $c);   
    }  
}

sub yyerror{
    my ($msg, $s) = @_;
    die "$msg at " . $s->name . " line " . $s->lineno . ".\n";
}
#line 650 "RomanParser.pm"
1;
