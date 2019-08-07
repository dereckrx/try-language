package com.try_java;

import lombok.Value;

import java.util.Arrays;
import java.util.List;
import java.util.Map;
import java.util.function.Function;
import java.util.stream.Collectors;

public class ClojureAsJava {
  interface StringLike {}

  @Value
  class Symbol implements StringLike { String name; }

  @Value
  class Keyword implements StringLike { String name; }

  List L(Object e1) {
    return List.of(e1);
  }
  List L(Object e1, Object e2) { return List.of(e1, e2); }
  List L(Object e1, Object e2, Object e3, Object e4) { return List.of(e1, e2, e3, e4); }
  Map M(Object k1, Object v1, Object k2, Object v2) {
    return Map.of(k1, v1, k2, v2);
  }

  List<StringLike> $(String ...names) {
    var list = Arrays.stream(names).collect(Collectors.toList());
    return map(
        name -> name.startsWith(":") ? (new Keyword(name)) : (new Symbol(name)),
        list
    );
  }

  <T, R>List<R> map(Function<T, R> fn, List<T> list) {
    return list.stream().map(fn).collect(Collectors.toList());
  }

  /*
  (defn plus-one [a b] {
    :time System/currentTimeMillis,
    :result (+ a b 1)
  }
 */

  void clojureAsJava2() {
    L("defn", "plus-one", L("a", "b"),
        M(":time", L("System/currentTimeMillis"),
            ":result", L("+", "a", "b", 1L)));
  }

  void clojureAsJava() {
    List.of(
        new Symbol("defn"),
        new Symbol("plus-one"),
        List.of(
            new Symbol("a"),
            new Symbol("b")
        ),
        Map.of(
            new Keyword(":time"), List.of(new Symbol("System/currentTimeMillis")),
            new Keyword(":result"), List.of(
                new Symbol("+"),
                new Symbol("a"),
                new Symbol("b"),
                1L)));
  }

  public void foo() {
    var clientBonus =
        Map.of(
            "client", Map.of("id", "123233"),
            "deposits", List.of(
                Map.of(
                    "amount", 3,
                    "type", "CASH"
                ),
                Map.of(
                    "amount", 234,
                    "type", "CARD")));

    ((List) clientBonus.get("deposits"))
        .stream()
        .collect(
            Collectors.summarizingInt(m ->
                (int) ((Map) m).get("amount")));
  }
}
