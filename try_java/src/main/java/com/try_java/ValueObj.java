package com.try_java;

import lombok.Value;
import lombok.experimental.Accessors;
import lombok.experimental.Wither;

// Immutable value class, with no 'get' prefix on fields
@Value
@Wither
@Accessors(fluent = true)
public class ValueObj {
    String foo;
    String bar;
}
