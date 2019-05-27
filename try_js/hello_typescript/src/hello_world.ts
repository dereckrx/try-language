class Student {
  fullName: string;
  constructor(public firstName: string, public middleName: string, public lastName: string) {
    this.fullName = firstName + " " + middleName + " " + lastName;
  }
}

interface Person {
  firstName: string;
  lastName: string;
}

function greeter(person: Person) {
    return "Hello, " + person.firstName + " " + person.lastName;
}

//const user = [0, 1, 2]; // Compilation error
const user = new Student("Jane", "M", "User");

console.log(greeter(user));

function act(value: number | undefined | null) {
  if(value != null) {
    console.log("pass ", value);
  } else {
    console.log("fail! ", value);
  }
}
act(null)
act(undefined)
act(3)

function notAct(value: number | undefined | null) {
  if(value == null) {
    console.log("pass (nully) ", value);
  } else {
    console.log("fail (ok!)", value);
  }
}
notAct(null)
notAct(undefined)
notAct(3)


if(true) {
  let foo = 123;
}