#!/usr/bin/env node

const { maxBy } = require('lodash')

function lr(tree) {
    if (tree.length < 3 || tree[0] === '.') { return [[],[]] }        
    if (tree.length === 3) { return [["."],["."]] }        
    left=[]
    let [sm,ix] = [0,1]
    while (sm !== -1) { 
        left.push(tree[ix])
        sm+=(tree[ix] == '.' ? -1 : 1)
        ix+=1
    }
    return [left,tree.slice(left.length+1)]
}

function lrLongPath(tree) {
    if (tree[0] === '.') { return [[],[]] }        
    if (tree.length === 3) { return [[tree[0]],[tree[0]]] }        
    return lr(tree).map( ar => [tree[0], ...maxBy(lrLongPath(ar), x => x.length)] )
}

function biLongPath(tree) {
    if (tree.length < 3 || tree[0] == '.') { return [] }
    if (tree.length === 3) { return [tree[0]] }
    let [lPath,rPath] = lrLongPath(tree)
    let path = [...([...(lPath.slice(1))].reverse()),...rPath]
    let [left,right] = lr(tree)
    return maxBy([path, ...[left,right].map(biLongPath)], x => x.length)
}

console.log(biLongPath(process.argv.slice(2)).join(" "))

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
