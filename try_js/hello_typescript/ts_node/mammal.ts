export class Mammal {
  private readonly bark: String;

  constructor() {
    this.bark = "meow"
  }

  public speak() {
    console.log(this.bark);
  }
}
