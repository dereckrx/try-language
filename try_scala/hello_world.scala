// scala hello_world.scala
//
// IntelliJ Setup:
// * Scala works because it has "scala-sdk-2.12.8" in the "Global Libraries"

def modMethod1(i: Int) = i % 2 == 0
def modMethod2(i: Int) = { i % 2 == 0 }
def modMethod3(i: Int): Boolean = i % 2 == 0
def modMethod4(i: Int): Boolean = { i % 2 == 0 }

def modMethod(i: Int) = i % 2 == 0

val list = List.range(1, 10)
println(list.filter(modMethod))

val addThenDouble: (Int, Int) => Int = (x,y) => {
    val a = x + y
    2 * a
}

// implicit approach
val add1 = (x: Int, y: Int) => { x + y }
val add2 = (x: Int, y: Int) => x + y

// explicit approach
val add3: (Int, Int) => Int = (x,y) => { x + y }
val add4: (Int, Int) => Int = (x,y) => x + y

val c = scala.math.cos _

val add5 = add1
add5(1,1)

object Stuff {
  def makeStuff() = println("make stuff")
  def makeStuff2(a: Int) = println(s"make 2 ${a}")
}
val s0 = Stuff.makeStuff _
val s1: () => Unit = Stuff.makeStuff
val s2: (Int) => Unit = Stuff.makeStuff2
val s3 = Stuff.makeStuff2 _
s0()
s1()
s2(1)
s3(1)

//-------------------------------------------------
case class Expector(result: Integer) {
  def pass = () => println("Pass")
  def fail = (e: Integer) => println(s"Fail: expected ${result} to equal ${e}")
  def toEqual(expected: Integer) =
    if(result == expected)
      pass()
    else
      fail(expected)
}

val expect = (a: Integer) => Expector(a)

val it = (name: String, test: () => Unit) => test()

it("passes if equal", () =>
  expect(1).toEqual(1)
)

it("fails if not equal", () =>
  expect(1).toEqual(2)
)



