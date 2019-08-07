package com.try_java;

// Beautiful, Simple, Testable Functional Effects for Scala
// http://degoes.net/articles/zio-environment

import lombok.Value;
import lombok.val;

import java.io.IOException;
import java.util.function.Supplier;

@Value
class Effect<T> {

  Supplier<T> effect;

  static <T> Effect of(Supplier<T> eff) {
    return new Effect(() -> eff);
  }
}

public class FuntionalSideEffects {

//  class IO[A](Supplier<A> unsafeInterpret) { s =>
//    void map[B](f: A => B) = flatMap(f.andThen(IO.effect(_)));
//    void flatMap[B](f: A => IO[B]): IO[B] =
//        IO.effect(f(s.unsafeInterpret()).unsafeInterpret());
//
//    static void effect[A](eff: => A) = new IO(() => eff);
//  }

  public Effect<Void> putStrLn(String line) {
    return new Effect(() -> {
      System.out.println(line);
      return null;
    });
  }

  public void testEffects() {

    Effect<Void> printHello = putStrLn("Hello side-effect!");
    Effect<Integer> getStrLn = new Effect(() -> {
      try {
        return System.in.read();
      } catch (IOException e) {
        e.printStackTrace();
        return null;
      }
    });
  }

}

