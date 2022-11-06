(* 
 * Task 1: Greater Character
 * 
 * GUEST LANGUAGE: THIS IS THE PASCAL VERSION OF ch-1.pl, suitable for
 * the Free Pascal compiler.
 *) 

uses sysutils;

type strarray = array [0..100] of string;

var debug : boolean;


(* process_args_exactly_n( n, str[] );
 *	Process command line arguments,
 *	specifically process the -d flag,
 *	check that there are exactly n remaining arguments,
 *	copy remaining args to str[n], a string array
 *)
procedure process_args_exactly_n( n : integer; var str : strarray );

(* note: paramStr(i)); for i in 1 to paramCount() *)

var
	nparams : integer;
	nel : integer;
	arg : integer;
	i : integer;
	p : string;

begin
	nparams := paramCount();

	arg := 1;
	if (nparams>0) and SameText( paramStr(arg), '-d' ) then
	begin
		debug := true;
		arg := 2;
	end;

	nel := 1+nparams-arg;
	if nel <> n then
	begin
		writeln( stderr,
			'Usage: gt-chr [-d] target string' );
		halt;
	end;


	// elements are in argv[arg..nparams], copy them to str[]

	for i := arg to nparams do
	begin
		p := paramStr(i);
		str[i-arg] := p;
	end;
end;


procedure main;

var
	strarr  : strarray;
	str     : string;
	i       : integer;
	len     : integer;
	target  : char;
	minchar : char;
	ch      : char;

begin
	debug := false;

	process_args_exactly_n( 2, strarr );

	target := strarr[0][1];
	str    := strarr[1];

	len := length(str);
	if debug
	then begin
		writeln( 'debug: target=', target, ', str=', str );
	end;
	minchar := chr(127);
	for i:=1 to len do
	begin
		ch := str[i];
		if debug
		then begin
			writeln( 'debug: str[', i, '] = "', ch, '" minsofar="', minchar, '"' );
		end;
		if (ch > target) and (ch < minchar)
		then begin
			minchar := ch;
		end;
	end;
	if minchar = chr(127) then minchar := target;
	writeln( minchar );
end;


begin
  main;
end.
