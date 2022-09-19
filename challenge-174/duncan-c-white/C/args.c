#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>


bool debug = false;


// process_flag_noarg( name, argc, argv );
//	Process the -d flag, and check that there are no
//	remaining arguments.
void process_flag_noarg( char *name, int argc, char **argv )
{
	int arg=1;
	if( argc>1 && strcmp( argv[arg], "-d" ) == 0 )
	{
		debug = true;
		arg++;
	}

	int left = argc-arg;
	if( left != 0 )
	{
		fprintf( stderr, "Usage: %s [-d]\n", name );
		exit(1);
	}
}


// process_onenumarg_default( name, argc, argv, defvalue, &n );
//	Process the -d flag, and check that there is a single
//	remaining numeric argument (or no arguments, in which case
//	we use the defvalue), putting it into n
void process_onenumarg_default( char *name, int argc, char **argv, int defvalue, int *n )
{
	int arg=1;
	if( argc>1 && strcmp( argv[arg], "-d" ) == 0 )
	{
		debug = true;
		arg++;
	}

	int left = argc-arg;
	if( left > 1 )
	{
		fprintf( stderr, "Usage: %s [-d] n\n", name );
		exit(1);
	}

	if( left == 0 )
	{
		*n = defvalue;
		return;
	}

	// element is in argv[arg]

	if( debug )
	{
		printf( "debug: remaining arguments are in arg=%d, "
		        "firstn=%s\n", arg, argv[arg] );
	}

	*n = atoi( argv[arg] );
}


// process_onenumarg( name, argc, argv, &n );
//	Process the -d flag, and check that there is a single
//	remaining numeric argument, putting it into n
void process_onenumarg( char *name, int argc, char **argv, int *n )
{
	int arg=1;
	if( argc>1 && strcmp( argv[arg], "-d" ) == 0 )
	{
		debug = true;
		arg++;
	}

	int left = argc-arg;
	if( left != 1 )
	{
		fprintf( stderr, "Usage: %s [-d] n\n", name );
		exit(1);
	}

	// element is in argv[arg]

	if( debug )
	{
		printf( "debug: remaining arguments are in arg=%d, "
		        "firstn=%s\n", arg, argv[arg] );
	}

	*n = atoi( argv[arg] );
}


// process_twonumargs( name, argc, argv, &m, &n );
//	Process the -d flag, and check that there are 2
//	remaining numeric arguments, putting them into m and n
void process_twonumargs( char *name, int argc, char **argv, int *m, int *n )
{
	int arg=1;
	if( argc>1 && strcmp( argv[arg], "-d" ) == 0 )
	{
		debug = true;
		arg++;
	}

	int left = argc-arg;
	if( left != 2 )
	{
		fprintf( stderr, "Usage: %s [-d] m n\n", name );
		exit(1);
	}

	// elements are in argv[arg] and argv[arg+1]

	if( debug )
	{
		printf( "debug: remaining arguments are in arg=%d, "
		        "firstn=%s, secondn=%s\n",
			arg, argv[arg], argv[arg+1] );
	}

	*m = atoi( argv[arg++] );
	*n = atoi( argv[arg] );
}

// int arr[100];
// int nel = process_listnumargs( name, argc, argv, arr, 100 );
//	Process the -d flag, and check that there are >= 2
//	remaining numeric arguments, putting them into arr[0..nel-1]
//	and returning nel.
int process_listnumargs( char *name, int argc, char **argv, int *arr, int maxel )
{
	int arg=1;
	if( argc>1 && strcmp( argv[arg], "-d" ) == 0 )
	{
		debug = true;
		arg++;
	}

	int left = argc-arg;
	if( left < 2 )
	{
		fprintf( stderr, "Usage: %s [-d] list_of_numeric_args\n", name );
		exit(1);
	}
	if( left > maxel )
	{
		fprintf( stderr, "%s: more than %d args\n", name, maxel );
		exit(1);
	}

	// elements are in argv[arg], argv[arg+1]...

	if( debug )
	{
		printf( "debug: remaining arguments are in arg=%d, "
		        "firstn=%s, secondn=%s..\n",
			arg, argv[arg], argv[arg+1] );
	}

	int nel = 0;
	for( int i=arg; i<argc; i++ )
	{
		arr[nel++] = atoi( argv[i] );
	}
	arr[nel] = -1;
	return nel;
}
