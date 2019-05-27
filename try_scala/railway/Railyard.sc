/*
Happy path vs sad path "Railway" railroad paths
Source -> Parse -> Transform -> Send -> Success
       +> error -> ... -> Failure
 */

import scala.util.{Failure, Success, Try}

type Input = String
type OneTrack = Input
type TwoTrack = Try[Input]
type DeadEnd = Unit

//////////////////////////////////
// Single track to two track
def normalizeEmail(email: String): String = {
  email.trim().toLowerCase()
}

// Convert one track into two track function
def switch2[A,B](oneTrackFn: A => B): Try[A] => Try[B] = {
  (twoTrackInput: Try[A]) => {
    twoTrackInput match {
      case Success(i) => Success(oneTrackFn(i))
      case Failure(error) => Failure(error)
    }
  }
}

def supervise[A](
                  success: Any => Any,
                  failure: Any => Any
                ): Try[A] => Try[A] = {
  twoTrackInput: Try[A] => {
    twoTrackInput match {
      case Success(i) => success(i); twoTrackInput;
      case Failure(error) => failure(error); Failure(error)
    }
  }
}

///////////////////////////
// Exception fn to two track
def switchEx[A,B,T](exceptionFn: A => B): Try[A] => Try[B] = {
  twoTrackInput: Try[A] => {
    try {
      Success(exceptionFn(twoTrackInput))
    } catch {
      case e: T => Failure(e)
    }
  }
}

def updateDb(input: Input): DeadEnd = {}

def updateDbOneTrack(input: OneTrack): TwoTrack = {
  updateDb(input)
  Success(input)
}

// TwoTrack
def updateDbTwoTrack(input: TwoTrack): TwoTrack = {
  input match {
    case Success(i) => updateDbOneTrack(i)
    case Failure(exception) => Failure(exception)
  }
}

updateDbTwoTrack(Success("hello"))
/////////////////////////////////////////////////


// Convert dead-end into one track function
def tee[A](deadEndFn: A => Unit, input: A): A = {
  deadEndFn(input)
  input
}

// Convert one track into two track function
def switch[A](oneTrackFn: A => A, input: Try[A]): Try[A] = {
  input match {
    case Success(i) => Success(oneTrackFn(i))
    case Failure(error) => Failure(error)
  }
}

val oneTrack: Input => Input = tee[Input](updateDb, _)
val twoTrack = switch[Input](oneTrack, _)
twoTrack(Success("hello"))

///////////////////////
// One Track input to two track input
// aka: Bind
def adapt[A](switchFn: A => Try[A]): Try[A] => Try[A] = {
  twoTrack: Try[A] => {
    twoTrack match {
      case Success(s) => switchFn(s)
      case Failure(f) => Failure(f)
    }
  }
}
//////////////////////
// Two track to single track Result
def join[A](twoTrack: Try[A]): Unit = {
  twoTrack match {
    case Success(s) => println(s)
    case Failure(f) => println(f)
  }
}