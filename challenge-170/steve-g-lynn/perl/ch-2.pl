#!/usr/bin/perl

# Old-fashioned perl4-style approach modelling a matrix as a hash:
# item at m'th row and n'th column of matrix M represented as $M{'m,n'}
# (sadly the bareword form $M{m,n} is now deprecated.)
#
# This is a convenient representation for computing kronecker products
# when the inputs are sparse matrices.

# logic: compute the kronecker product C=kron(A,B) in an intermediate form 
# first as a hash C{m,n} where the indices m,n are the same as those in A, 
# and C{m,n} is a stringified list of the values in the matrix A{m,n} * B.

# Then flatten C to return it as an old-fashioned hash-style matrix 
# like A and B.
#

use List::Pairwise qw(mapp);

local %A=('1,1',1,'1,2',2,'2,1',3,'2,2',4);
local %B=('1,1',5,'1,2',6,'2,1',7,'2,2',8);

local %C= &kron(*A,*B);

foreach my $i (1 .. 4) {
	foreach my $j (1 .. 4) {
		print $C{$i.','.$j}," ";	
	}
	print "\n";
}

sub kron {
	#-- old-fashioned approach using dynamic scope and typeglobs
	
	local (*A, *B)=@_; #--%A, %B matrices to be kroneckered
	local (*C, *C_wip); 
	#-- %C return value, %C_wip intermediate non-flat object

	#-- nested subs for supporting calculations
	#-- get matrix dimensions
	local *find_mat_dims = sub {
		local (*matrix)=@_;
		my ($nrow, $ncol)=(0,0);
		
		for my $i (keys %matrix){
			my ($row, $col)=split(/,/,$i);
			($row > $nrow) && ($nrow = $row);
			($col > $ncol) && ($ncol = $col);
		}
		return ($nrow, $ncol);
	};

	local *scalar_times_mat = sub {
	#-- nested sub to multiply a scalar into
	#-- every element of a matrix
	
		local ($scalar, *matrix)=@_;
	
		my %matrix_copy = %matrix;
		mapp { $b = $scalar * $b} %matrix_copy;
		#-- $a is key, $b is value in List::Pairwise syntax
		
		return %matrix_copy;
	}; 

	#-- nested sub to create C_wip
	local *assemble_C_wip = sub {
		for my $i (keys %A){
			$C_wip{$i} = join(':',&scalar_times_mat( $A{$i}, *B ));
			#-- e.g., 1,2 -> '1,2:12:2,1:14:1,1:10:2,2:16'
		}
		return %C_wip;
	};

	#-- nested sub to flatten C_wip
	# e.g., 1,2 -> '1,2:12:2,1:14:1,1:10:2,2:16'
	# flattens to ('1,4' -> 12, '2,3'->14, '1,3'->10, '2,4'->16)
	# transform 'rowA,colA' -> '..rowB,colB..'
	# to (rowB+(rowA-1)*nrow_B),(colB+(colA-1)*ncol_B) 
	# which is the 'row, col' in the flattened Kronecker product
	 	 
	local *flatten_C_wip = sub {
		local @C=();
		for my $i (keys %C_wip){
			my ($row_A, $col_A)=split(/,/,$i);
			my ($entry)=$C_wip{$i};			
			$entry =~ s/(\d+),(\d+)/
				($1+($row_A-1)*$nrow_B) .','.
				($2+($col_A-1)*$nrow_B)
				/gex; 
			push @C, split(/:/,$entry);
		}
		return @C;
	};

	#-- end nested sub definitions, back to main &kron
	
	local ($nrow_B, $ncol_B) = &find_mat_dims(*B);	
	
	&assemble_C_wip();
	
	%C=&flatten_C_wip();
	
	return  %C;

}

