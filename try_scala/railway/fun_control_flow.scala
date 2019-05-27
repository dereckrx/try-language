package railway


/*
Happy path vs sad path "Railway" railroad paths
Source -> Parse -> Transform -> Send -> Success
       +> error -> ... -> Failure
 */
object Main {
  def main(args: Array[String]): Unit = ???
  private def go(emit: () => Seq[RawUser]): Result = ???
  private def transform(r: RawUser): User = ???
  private def toResult(v: User): Result = ???
}

case class Result(successes: Int, failures: Int)

// Outside data source
case class RawUser(
                 fullName: String,
                 email: String,
                 phone: String,
                 streetAddress: String,
                 city: String,
                 zipCode: String)

// Domain User
case class User(
               person: Person,
               phoneNumber: PhoneNumber
               )

case class Person(firstName: String, lastName: String)
case class PhoneNumber(areaCode: String)

