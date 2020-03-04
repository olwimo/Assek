package io.github.olwimo;

import java.util.Arrays;
import java.util.LinkedList;

public class Interpolation<T extends Number> {

  public enum Type {
    Linear, 
      Quadratic, 
      Cubic, 
      Exponential
  }

  List<T[]> frame;
  int[] dims;
  int f_length;

  public T get(double[] i) {

  }


  public Interpolation () {
    this(new int[] {});
  }

  public Interpolation (T[] frame) {
    this(frame, new int[] {});
  }

  public Interpolation (int[] dimensions) {
    this(new T[] {}, dimensions);
  }

  public Interpolation (T[] frame, int[] dimensions) {
    this.setDimensions(dimensions).setFrame(frame);
  }

  public Interpolation<T> setDimensions(int[] dimensions) {
    dims = dimensions;
    
    f_length = Arrays.stream(dims).filter(x -> x > 0).reduce((x,y) -> x*y).orElse(0);

    frame = new LinkedList<T[]>();

    return this;
  }

  public Interpolation<T> addFrame(T[] frame) {
    if (frame.length == f_length || f_length == 0) this.frame.add(frame);

    return this;
  }
}
