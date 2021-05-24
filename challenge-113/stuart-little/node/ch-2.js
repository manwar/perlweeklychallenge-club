#!/usr/bin/env node

const printTree = require('print-tree');

function split2trees(lst) {    
    ix = [...lst.keys()].find(i => 2*lst.slice(0,i+1).filter(x => x === ".").length > i+1 );
    return [lst.slice(0,ix+1), lst.slice(ix+1)]
}

function mkTree(lst) {
    if (lst[0] === ".") {
	return { name: "" };
    };
    const nm = lst[0];
    const [lft,rght] = split2trees(lst.slice(1));
    return {
	name: nm,
	children: [mkTree(lft),mkTree(rght)],
    };
}

const inTreeList = (process.argv.length > 2) ? (process.argv.slice(2)) : (["1", "2", "4", ".", "7", ".", ".", ".", "3", "5", ".", ".", "6", ".", "."]);
const sm = inTreeList.reduce((acc,el) => {return acc + (parseInt(el) || 0)}, 0);
const outTreeList = inTreeList.map(x => (parseInt(x)) ? (sm - parseInt(x)) : x);

printTree(
    mkTree(outTreeList),
    node => node.name.toString(),
    node => node.children,
);

/*
run <script> <tree in preorder form with '.' for empty nodes, entered as space-separated values>

ref: https://stackoverflow.com/a/2676849/11064961

e.g. 1 2 4 . 7 . . . 3 5 . . 6 . . represents the tree

        1
       / \
      2   3
     /   / \
    4   5   6
     \
      7

given as an example in the problem formulation at https://perlweeklychallenge.org/blog/perl-weekly-challenge-113/#TASK2
*/

