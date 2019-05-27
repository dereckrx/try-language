// Run with ts-node hello_generics.ts

const wrapInObj = <T>(myValue: T) => {
  return {
    value: myValue,
  }
};

const wrappedValue = wrapInObj('12345');

const result = wrappedValue.value.split(',');
console.log("Wrapped value: ", result);


type User = {
  user?: {
    name: string,
    friends?: Array<User>,
  }
};

// to safely get friends or friends, we have to write:
const friend1: User = {user: {name: 'bar'}};
const props: User = {user: {name: 'foo', friends: [friend1]}};
const firstFriend: User | undefined = props.user &&
  props.user.friends &&
  props.user.friends[0];
const friendsOfFriends = firstFriend && firstFriend.user!.friends;

console.log("Safe friends: ", friendsOfFriends);

const idx = <T extends {}, U>(props: T, selector: (params: T) => U ): U | undefined => {
  try {
    return selector(props);
  } catch (error) {
    return undefined;
  }
};

// or, if we use idx:
const friendsOfFriendsIdx = idx(props, (_) => _.user!.friends![0].user!.friends);
console.log("IDX friends: ", friendsOfFriendsIdx);

// ---
const foo = (value: string) => {
  return {
    input: value,
    time: Date.now(),
    characters: value.split('')
  }
};

// type ReturnType<T extends (...args: any[]) => any> =
//   T extends (...args: any[]) => infer R ? R : any;

// type FooOutput = {
//   input: string;
//   time: number;
//   characters: Array<string>;
// }
type FooOutput = ReturnType<typeof foo>;
const fooResult: FooOutput = foo('hello');
console.log("Implicit return type: ", fooResult);