let ip = "1.1.1.1";
proc(ip);
ip = "255.101.1.0";
proc(ip);

function proc(ip) {
    let nums = ip.split('\.');
    let out = nums.join("[.]");
    console.log( "Input:", ip);
    console.log( "Output:", out);
}
