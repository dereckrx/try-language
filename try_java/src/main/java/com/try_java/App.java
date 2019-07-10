package com.try_java;

//public interface Fooable {
//    String foo();
//}
//
//public class StaticFoo implements Fooable {
//    public static String foo() {
//        return "foo";
//    }
//}
//
//public class InstanceFoo implements Fooable {
//    public String foo() {
//        return "foo";
//    }
//}


public class App {

    public static void log(Object message) {
        System.out.println(message);
    }

    public static void main(String[] args) {
        ValueObj v =  new ValueObj("666", "zoo");
        CaseClass c = new CaseClass("123", "foo", v);

        // Changing fields
        log(c.toBuilder().name("bar").build());
        log(v.withBar("zar"));
    }
}

