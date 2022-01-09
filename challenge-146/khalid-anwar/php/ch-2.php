<?php
//////////////////////////////////////////////////////
// Fraction Tree Solution : Designed by Khalid Anwar//
//  			     	1/1                         //
//                  /            \                  //
//	          1/2				      2/1           //
//           /    \                 /     \         //
//      1/3	 	    3/2		     2/3 	   3/1      //
//     /   \        /  \        /  \       /  \     //
//  1/4     4/3	 3/5   5/2    2/5  5/3   3/4  4/1   //
// ************************************************ //
// Please note, Its working code but Not fully      //
// optimized , can be checked manually by providing //
// member detail from below itself, please refer    // 
// diagram above for Fraction Tree.                 //     
//////////////////////////////////////////////////////

function getNumeratorDenominator($fraction) 
{
    preg_match('/^(?P<whole>\d+)?\s?((?P<numerator>\d+)\/(?P<denominator>\d+))?$/', $fraction, $components);
    // Extract numerator, and denominator components
    $numerator = $components['numerator'] ?: 0;
    $denominator = $components['denominator'] ?: 0;
   return $components;
}

function getParent($c, $d){
	$parent = Array();
	if ($c > $d){ 
		$parent['p_nominator'] = $c-$d;
		$parent['p_denominator'] = $d;
	}else{ 
		$parent['p_nominator'] = $c;
		$parent['p_denominator'] = $d-$c;
	}
	return $parent;
}

// Testing of member input, first input is set as default in this code. Others can be tested by uncommenting it accordingly
// online php editor reference : https://paiza.io/en/projects/new

$member = '3/5'; //input 1
//$member = '4/3'; //input 2
//$member = '3/4';  //input 3

$var = getNumeratorDenominator($member);

echo "For member =".$member."\n";
$parent = getParent($var['numerator'],$var['denominator']);
echo "Parent = ".$parent['p_nominator']."/".$parent['p_denominator'];
echo " and ";
$grandParent = getParent($parent['p_nominator'],$parent['p_denominator']);
echo "GrandParent = ".$grandParent['p_nominator']."/".$grandParent['p_denominator'];

?>
