let str = "Perl Weekly Challenge";
let count = 0;
for(let i =0; i < str.length; i++){
    if(str[i] === "e"){
        count++;
        str = str.replace("e", "E")
    }  
}
console.log(str)
console.log(count)
