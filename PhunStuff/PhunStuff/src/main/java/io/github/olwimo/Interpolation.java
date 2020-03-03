package io.github.olwimo;

import java.util.Arrays;

public class Interpolation<T> {

  public enum Type {
    Linear, 
      Quadratic, 
      Cubic, 
      Exponential
  }

  T frame[];
  int dims[];
  int length;

  public Interpolation () {
    this(new int[] {0});
  }

  public Interpolation (T[] frame) {
    this(frame, new int[] {0});
  }

  public Interpolation (int[] dimensions) {
    this(new T[] {}, dimensions);
  }

  public Interpolation (T[] frame, int[] dimensions) {
    this.setDimensions(dimensions).setFrame(frame);
  }

  public Interpolation<T> setDimensions(int[] dimensions) {
    if (dimensions.length == 0) dims = new int[]{0};
    else dims = dimensions;
    
    length = Arrays.stream(dims).filter(x -> x > 0).reduce((x,y) -> x*y).orElse(0);

    return this;
  }

  public Interpolation<T> setFrame(T[] frame) {
    if (length != 0 && length != frame.length) this.frame = null;
    else this.frame = frame;

    return this;
  }
}
