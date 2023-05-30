#! /usr/bin/node

"use strict"

function travelexpenditure(costs, days0) {
    let days = days0;
    days.sort(function(a,b) {
        return a-b;
    });
    const validities = [1, 7, 30];
    let stack = [];
    stack.push([0, days]);
    let cheapest = days.length * costs[0];
    while (stack.length > 0) {
        const c = stack.shift();
        if (c[1].length == 0) {
            if (c[0] < cheapest) {
                cheapest = c[0];
            }
        } else {
            if (c[0] >= cheapest) {
                continue;
            }
            const start = c[1][0];
            for (let i = 0; i <= 2; i++) {
                const ed = start + validities[i] - 1;
                let dtd = c[1].filter(x => x > ed);
                stack.push([c[0] + costs[i], dtd]);
            }
        }
    }
    return cheapest;
}

if (travelexpenditure([2, 7, 25], [1, 5, 6, 7, 9, 15]) == 11) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write(" ");
if (travelexpenditure([2, 7, 25], [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31]) == 20) {
  process.stdout.write("Pass");
} else {
  process.stdout.write("FAIL");
}
process.stdout.write("\n");
