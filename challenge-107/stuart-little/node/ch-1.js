#!/usr/bin/env node

// run <script>

const nrs = {
    100: [4,1210],
    136: [4,2020],
    1425: [5,21200]
};

Object.keys(nrs).forEach((k,i) => {
    console.log(`Base 10: ${k}
Base ${nrs[k][0]}: ${nrs[k][1]}
`)
});
