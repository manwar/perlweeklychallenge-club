function similarWords(...strArray){
    let newArray = new Array();
    let output = 0;
    for (const element of strArray) {
        let elem = Array.from(new Set(element));
        elem.sort();
        elem = elem.join('');
        newArray.push(elem);
    }
    console.log(newArray);


  for (let i = 0; i < newArray.length; i++) {
      for (let j = i+1; j < newArray.length; j++) {
          if (newArray[i] == newArray[j]) {
              output++;
          }
      }
    }

    console.log(output);
}

similarWords("aabb", "ab", "ba");
