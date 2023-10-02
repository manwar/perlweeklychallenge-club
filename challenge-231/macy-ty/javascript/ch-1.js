function minMax (...elements){
    let array = Object.values(elements);

    const min_num = Math.min(...array);
    const max_num = Math.max(...array);
    var result = array.filter((num) => num != min_num &&  num != max_num);
    if (result.length == 0){
        result = -1;
    }
    console.log(result);
}
minMax(3, 1);
