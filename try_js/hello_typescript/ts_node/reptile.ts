// Run with
// $ npx ts-node reptiles.ts
export class Reptile {
  private readonly bark: String;

  constructor() {
    this.bark = "Growl"
  }

  public speak() {
    console.log(this.bark)
  }
}