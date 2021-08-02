#!/usr/bin/env node

// run <script> <space-separated numbers>

const { minBy, sum } = require('lodash')
const { difference } = require('set-operations')
const ps = require('power-set-x').default

function splt(nums) {
    return minBy(ps(nums).filter(x => x.length === Math.floor(nums.length/2)).map(x => [x, Array.from(difference(nums,x))]), x => Math.abs(sum(x[0])-sum(x[1])))
}

const [l,r] = splt(process.argv.slice(2).map(x => parseInt(x)))
console.log(l)
console.log(r)
