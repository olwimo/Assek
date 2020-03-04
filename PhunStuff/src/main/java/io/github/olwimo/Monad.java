package io.github.olwimo;

import java.lang.Function;

public abstract Class Monad<U> {

    public abstract <V>Monad<V> bind(Function<U, Monad<V>> g);
    public static abstract Monad<U> ret(U value);
}
