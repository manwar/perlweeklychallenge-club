(* 
 * TASK #2 - Summations
 * 
 * GUEST LANGUAGE: THIS IS THE C VERSION OF ch-2.pl, suitable for
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
			'Usage: summations [-d] list of +ve numbers' );
		halt;
	end;

	if nel > maxints then
	begin
		writeln( stderr,
			'summations too many numbers (max ',
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
				'summations arg ', i,
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
	r, i : integer;
	pos  : integer;

begin
	debug := false;

	process_args( nel, v );

	r := 1;

	if debug then
	begin
		write( 'row ', r, ':' );
		for i := 0 to nel-1 do
		begin
			write( ' ', v[i] );
		end;
		writeln;
	end;
	while nel > 1 do
	begin
		// shift v array down
		for i := 0 to nel-1 do
		begin
			v[i] := v[i+1];
		end;
		v[nel-1] := -1;
		nel := nel - 1;

		for pos := 1 to nel-1 do
		begin
			v[pos] += v[pos-1];
		end;
		r := r+1;

		if debug then
		begin
			write( 'row ', r, ':' );
			for i := 0 to nel-1 do
			begin
				write( ' ', v[i] );
			end;
			writeln;
		end;
	end;

	writeln( v[0] );

end;


begin
  main;
end.
