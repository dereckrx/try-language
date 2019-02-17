// kotlinc hello_world.kt -include-runtime -d output/hello.jar
// java -jar output/hello.jar
// IntelliJ Setup:
// *  Kotlin is special and needs a library entry in the .idea/library folder

fun main(args: Array<String>) {
    println("Hello, World!")

  val printer = { println("hello")}
  fun sum0(x: Int, y: Int): Int { return x + y }
  val sum = { x: Int, y: Int -> x + y }
  val sum1: (Int, Int) -> Int = { x, y -> x + y }
  printer()
  println(sum0(1,1))
  println(sum(1,1))
  println(sum1(1,1))

  it("passes if equal", {
    expect(1).toEqual(1)
  })

  it("fails if not equal", {
    expect(1).toEqual(2)
  })
}

fun double(x: Int): Int {
    return 2 * x
}

class Sample() {
    fun foo() { print("Foo") }
}

val s = Sample()

class Expector(val result: Int) {
  fun pass() { println("Pass") }
  fun fail(e: Int) { println("Fail: expected $result to equal $e")}
  fun toEqual(expected: Int) {
    if(result == expected)
      pass()
    else
      fail(expected)
    }
}


val expect = {a: Int -> Expector(a) }

typealias EmptyFn = () -> Unit

val it = { name: String, test: EmptyFn -> test() }

//-------------------------------------------------

// object Stuff {
//   def makeStuff() = println("make stuff")
//   def makeStuff2(a: Int) = println(s"make 2 ${a}")
// }
// val s0 = Stuff.makeStuff _
// val s1: () => Unit = Stuff.makeStuff
// val s2: (Int) => Unit = Stuff.makeStuff2
// val s3 = Stuff.makeStuff2 _
// s0()
// s1()
// s2(1)
// s3(1)

//-------------------------------------------------

