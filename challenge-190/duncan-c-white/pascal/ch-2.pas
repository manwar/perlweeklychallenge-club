(* 
 * TASK #2 - Array Degree
 * 
 * GUEST LANGUAGE: THIS IS THE Pascal VERSION OF ch-2.{c,pl},
 * suitable for the Free Pascal compiler.
 *) 

uses sysutils;

const maxints = 256;

type intarray = array [0..maxints-1] of integer;

var debug : boolean;


type
	pair = record
		el : integer;	(* an element *)
		freq : integer;	(* and it's associated frequency *)
	end;

type
	pairarray = array [ 1..1000 ] of pair;


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


(*
 * rement the frequency of el in freq (adding an element if
 * it's not there yet)
 *)
procedure incfreq( var freq : pairarray; var np : integer; el : integer );

var
	i    : integer;
	over : boolean;

begin
	over := false;
	for i:=0 to np-1 do
	begin
		if not over and (freq[i].el = el)
		then begin
			inc( freq[i].freq );
			over := true;
		end;
	end;
	if not over then
	begin;
		freq[np].el := el;
		freq[np].freq := 1;
		inc( np );
	end;
end;



(*
 * int deg = degree( arr, f, t );
 *	Calculate the degree (max frequency) of array[f..t].
 *)
function degree( arr : intarray; f, t : integer ) : integer;

var
	i, max : integer;
	np : integer; (* number of pairs in freq *)
	freq : pairarray;

begin
	np := 0;

	for i:=f to t
	do begin
		incfreq( freq, np, arr[i] );
	end;

	(* now find the maximum frequency in freq[] *)
	max := 0;
	for i:=0 to np-1
	do begin
		if freq[i].freq > max
		then begin
			max := freq[i].freq;
		end;
	end;
	degree := max;
end;


(*
 * makeslicestr( arr, f, t, slicestr );
 *	Build slicestr, a plain text string containing all elements
 *	arr[f..t], comma separated
 *	Sort of like slicestr = join(',', arr[f..t]);
 *)
procedure makeslicestr( arr : intarray; f, t : integer; var slicestr : ansistring );

var
	i : integer;

begin
	slicestr := '';
	for i:=f to t
	do begin
		if i>f
		then begin
			AppendStr( slicestr, ',' );
		end;
		AppendStr( slicestr, IntToStr( arr[i] ) );
	end;
end;


procedure main;

var
	nel        : integer;
	ilist      : intarray;
	wholedeg   : integer;
	slicestr   : ansistring;
	smallarray : ansistring;
	smallestarraysize : integer;
	f, t       : integer;
	deg, size  : integer;

begin
	debug := false;

	process_args( nel, ilist );

	wholedeg := degree( ilist, 0, nel-1 );

	makeslicestr( ilist, 0, nel-1, slicestr );

	if debug then
	begin
		writeln( 'debug: wholedeg = ', wholedeg );
	end;

	smallestarraysize := nel+1;

	for f:=0 to nel-2 do
	begin
		for t:=f+1 to nel-1 do
		begin
			deg := degree( ilist, f, t );
			if deg = wholedeg then
			begin
				makeslicestr( ilist, f, t, slicestr );
				if debug then
				begin
					writeln( 'debug: found sub-array ',
					     slicestr, ' with degree ', deg );
				end;

				size := t+1-f;
				if size < smallestarraysize then
				begin
					smallestarraysize := size;
					smallarray := slicestr;
				end;
			end;
		end;
	end;

	writeln( smallarray );
end;


begin
  main;
end.
