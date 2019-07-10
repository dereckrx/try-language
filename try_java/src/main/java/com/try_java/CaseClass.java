package com.try_java;

import lombok.Builder;
import lombok.Data;
import lombok.NonNull;

@Data
@Builder(toBuilder = true)
public class CaseClass {
    private final @NonNull String id;
    private final @NonNull String name;
    private final @NonNull ValueObj valueObj;
}

//@Data
//public class Element<Props> {
//    private final @NonNull String name;
//    private final @NonNull Function<Props, HTMLElement> renderFn;
//    private final @NonNull List<Element> children;
//}
//
//public class React {
//    public Element createElement(Function<String, String> fn, Map<String, Object> props, List<Element> children) {
//        return new Element(fn, props, children);
//    }
//}