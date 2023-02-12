//
// Task 2: Copy Directory
// 
// C version.
// 

#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include <ctype.h>
#include <fcntl.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <dirent.h>
#include <assert.h>

#include "args.h"


typedef char filename[256];


//
// make_path( path );
//	mkdir path (and all it's parental dirs
void make_path( char *path )
{
	assert( strlen(path)>1 );
	char *p = strchr(path+1,'/');
	if( p != NULL )
	{
		*p = '\0';
		if( debug ) printf( "mkdir %s\n", path );
		mkdir( path, 0700 );
		*p = '/';
		while( (p = strchr(p+1, '/')) != NULL )
		{
			*p = '\0';
			if( debug ) printf( "mkdir %s\n", path );
			mkdir( path, 0700 );
			*p = '/';
		}
	}
	if( debug ) printf( "mkdir %s\n", path );
	mkdir( path, 0700 );
	//exit(1);
}


//
// bool isd = isdir( path );
//	Return true iff path is a directory; false otherwise
//
bool isdir( char *path )
{
	struct stat buf;
	if( stat(path,&buf) == 0 )
	{
		if( S_ISDIR(buf.st_mode) )
		{
			return true;
		}
	}
	return false;
}


typedef void (*callback)( char *dir );


int strcompare( const void *a, const void *b )
{
	return strcmp( (char *)a, (char *)b );
}


#define MAXSUBDIRSPERDIR 1024


//
// find_dirs( srcpath, callback );
//	Recursively find all directories inside srcpath,
//	calling callback( dir ) for each one.
//
void find_dirs( char *srcpath, callback cb )
{
	if( ! isdir( srcpath ) ) return;
	DIR *dh = opendir( srcpath );
	if( dh == NULL )
	{
		fprintf( stderr, "Can't opendir %s\n", srcpath );
		return;
	}
	struct dirent *dinfo;
	filename subdirs[MAXSUBDIRSPERDIR];
	int ndirs = 0;
	while( (dinfo = readdir( dh )) != NULL )
	{
		char *name = dinfo->d_name;
		filename dname;
		if( strcmp(name,".")==0 || strcmp(name,"..")==0 ) continue;

		sprintf( dname, "%s/%s", srcpath, name );
		if( isdir(dname) )
		{
			strcpy( subdirs[ndirs++], dname );
			assert( ndirs<MAXSUBDIRSPERDIR );
			printf( "debug: subdir %s\n", dname );
		}
	}
	closedir( dh );

	qsort( subdirs, ndirs, sizeof(filename), &strcompare );

	if( debug )
	{
		for( int i=0; i<ndirs; i++ )
		{
			//printf( "debug: sorted subdir %s\n", subdirs[i] );
			(*cb)( subdirs[i] );
			find_dirs( subdirs[i], cb );
		}
	}
}


char *srcpath;
char *dstpath;

void eachdir( char *path )
{
	int slen = strlen(srcpath);
	filename dpath;
	sprintf( dpath, "%s/%s", dstpath, path+slen+1 );
	printf( "mkdir %s\n", dpath );
	mkdir( dpath, 0700 );
}


int main( int argc, char **argv )
{
	int argno = process_flag_n_args( "copy-dir-structure", argc, argv,
		2, "srcpath dstpath" );

	srcpath = argv[argno++];
	dstpath = argv[argno++];

	if( ! isdir(srcpath) )
	{
		fprintf( stderr, "copy-dir-structure: no src path %s\n",
			srcpath );
		exit(1);
	}
	if( isdir(dstpath) )
	{
		fprintf( stderr, "copy-dir-structure: dst path %s exists\n",
			dstpath );
		exit(1);
	}

	make_path( dstpath );

	if( ! isdir(dstpath) )
	{
		fprintf( stderr, "copy-dir-structure: no dst path %s\n",
			dstpath );
		exit(1);
	}

	find_dirs( srcpath, &eachdir );

	return 0;
}
