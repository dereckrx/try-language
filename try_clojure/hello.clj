; clojure hello.clj
; IntelliJ Setup:
; * Requires 'clojure-1.9.0.jar' in the try_clojure/lib directory
(defn greet  [name]  (str "Hello, " name))

(println (greet "dereck"))

(defn pass [] (println "Pass"))

(defn fail [result expected]
  (println (str "Fail: expected " result " to equal " expected)))

(defn toEqual [result expected]
  (if (== result expected) (pass) (fail result expected)))

; (defn toEqualFn [expected]
;   (toEqual expected)

(defn expect [result testFn expected] (testFn result expected))

(expect 1 toEqual 1)
(expect 1 toEqual 2)

(def x 7)
(println x)

; (ns hello
;   ; (:require [clj-time.core :as t]
;   ;           [clj-time.format :as f]))

; (defn time-str
;   "Returns a string representation of a datetime in the local time zone."
;   [dt]
;   (f/unparse
;     (f/with-zone (f/formatter "hh:mm aa") (t/default-time-zone))
;     dt))

; (defn -main []
;   (println "Hello world, the time is" (time-str (t/now))))

;; Equivalent to: (fn [x] (+ 6 x))
; #(+ 6 %)

; ;; Equivalent to: (fn [x y] (+ x y))
; #(+ %1 %2)

; ;; Equivalent to: (fn [x y & zs] (println x y zs))
; #(println %1 %2 %&)

; class Expector(val result: Int) {
;   fun pass() { println("Pass") }
;   fun fail(e: Int) { println("Fail: expected $result to equal $e")}
;   fun toEqual(expected: Int) {
;     if(result == expected)
;       pass()
;     else
;       fail(expected)
;     }
; }

; val expect = {a: Int -> Expector(a) }

; typealias EmptyFn = () -> Unit

; val it = { name: String, test: EmptyFn -> test() }

;   it("passes if equal", {
;     expect(1).toEqual(1)
;   })

;   it("fails if not equal", {
;     expect(1).toEqual(2)
;   })