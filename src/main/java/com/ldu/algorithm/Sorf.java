package com.ldu.algorithm;

public class Sorf implements Comparable<Sorf> {
    private Integer key;

    private Double scoke;

    public Integer getKey() {
        return key;
    }

    public void setKey(Integer key) {
        this.key = key;
    }

    public Double getScoke() {
        return scoke;
    }

    public void setScoke(Double scoke) {
        this.scoke = scoke;
    }

    public Sorf(Integer key, Double scoke) {
        this.key = key;
        this.scoke = scoke;
    }

    public Sorf() {
    }

    @Override
    public int compareTo(Sorf o) {
        if (this.getScoke() < o.getScoke()) {
            return 1;
        }
        if (this.getScoke() == o.getScoke()) {
            return 0;
        }

        return -1;
    }
}
