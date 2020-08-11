const year = 2019;
const date = new Date(year, 0);
const count = new Map();

while (date.getFullYear() === year) {
  const month = new Intl.DateTimeFormat('en-US', { month: 'long' }).format(date);

  if (!count.get(month)) count.set(month, 0);
  if (date.getDay() !== 0 && date.getDay() !== 6) {
    count.set(month, count.get(month) + 1);
  }

  date.setDate(date.getDate() + 1);
}

count.forEach((v, k) => {
  console.log(`${k}: ${v}`);
});
