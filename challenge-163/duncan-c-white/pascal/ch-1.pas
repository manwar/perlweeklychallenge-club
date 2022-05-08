(* 
 * TASK #1 - Sum Bitwise Operator
 * 
 * GUEST LANGUAGE: THIS IS THE PASCAL VERSION OF ch-1a.pl, suitable for
 * the Free Pascal compiler.
 *) 

uses sysutils;

const maxints = 256;

type intarray = array [0..maxints-1] of integer;

var debug : boolean;



(* process_args( nel, v );
 *	Process command line arguments,
 *	specifically process the -d flag,
 *	set nel to the number of remaining arguments,
 *	check that all those remaining arguments are +ve numbers,
 *	copy remaining args to a new integer array v.
 *)
procedure process_args( var nel : integer; var v : intarray );

(* note: paramStr(i)); for i in 1 to paramCount() *)

var
	nparams : integer;
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
	if nel < 2 then
	begin
		writeln( stderr,
			'Usage: sum-bitwise-pairs [-d] list of +ve numbers' );
		halt;
	end;

	if nel > maxints then
	begin
		writeln( stderr,
			'sum-bitwise-pairs: too many numbers (max ',
			maxints, ')' );
		halt;
	end;

	if debug then
	begin
		writeln( 'debug: arg', arg, ', nparams=', nparams, ', nel=',
			nel );
	end;

	// elements are in argv[arg..nparams], copy them to v[]

	// check that all remaining arguments are +ve integers,
	// and then copy them to v[]
	for i := arg to nparams do
	begin
		p := paramStr(i);
		if (p[1] < '0') or (p[1] > '9') then
		begin
			writeln( stderr,
				'sum-bitwise-pairs: arg ', i,
				' (', p, ') is not a +ve number' );
			halt;
		end;
		v[i-arg] := StrToInt( p );
	end;
end;


procedure main;

var
	nel  : integer;
	v    : intarray;
	sum  : integer;
	i, j : integer;
	a, b : integer;
	r    : integer;

begin
	debug := false;

	process_args( nel, v );

	sum := 0;
	for i := 0 to nel-2 do
	begin
		for j:= i+1 to nel-1 do
		begin
			a := v[i];
			b := v[j];
			r := a and b;
			if debug then
			begin
				writeln( 'debug: i=', i, ', j=', j,
					 ', a=', a, ', b=', b, ', a&b=', r );
			end;
			sum := sum + r;
		end;
	end;

	writeln( sum );

end;


begin
  main;
end.
