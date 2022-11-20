(* 
 * Task 1: Capital Detection
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
			'Usage: cap-det [-d] target string' );
		halt;
	end;


	// elements are in argv[arg..nparams], copy them to str[]

	for i := arg to nparams do
	begin
		p := paramStr(i);
		str[i-arg] := p;
	end;
end;


const
	Upper = ['A'..'Z'];
	Lower = ['a'..'z'];


function capdetect( str : string ) : boolean;
var
	alllower, allupper : boolean;
	len, i		   : integer;
begin
	len := length(str);
	if debug then
	begin
		writeln( 'debug: capdetect(', str, '): entry, str1=', str[1] );
	end;
	if str[1] in Upper then
	begin
		if debug then
		begin
			writeln( 'debug: capdetect(', str, '): starts with upper' );
		end;
		alllower := true;
		allupper := true;
		for i := 2 to len do
		begin
			if not( str[i] in Lower) then
			begin
				if debug then
				begin
					writeln( 'debug: capdetect(', str, '): found ', str[i], ' not lower case' );
				end;
				alllower := false;
			end;
			if not( str[i] in Upper) then
			begin
				if debug then
				begin
					writeln( 'debug: capdetect(', str, '): found ', str[i], ' not upper case' );
				end;
				allupper := false;
			end;
		end;
		if alllower or allupper then exit( true );
	end else if str[1] in Lower then
	begin
		if debug then
		begin
			writeln( 'debug: capdetect(', str, '): starts with lower' );
		end;
		alllower := true;
		for i := 2 to len do
		begin
			if not( str[i] in Lower) then
			begin
				writeln( 'debug: capdetect(', str, '): found ', str[i], ' not lower case' );
				alllower := false;
			end;
		end;
		if alllower then exit( true );
	end;
	exit( false );
end;


procedure main;

var
	strarr : strarray;
	str    : string;
	ok     : boolean;

begin
	debug := false;

	process_args_exactly_n( 1, strarr );
	str := strarr[0];

	if debug
	then begin
		writeln( 'debug: str=', str );
	end;

	ok := capdetect( str );

	if ok then
	begin
		writeln( 1 );
	end else
	begin
		writeln( 0 );
	end;

end;


begin
  main;
end.
