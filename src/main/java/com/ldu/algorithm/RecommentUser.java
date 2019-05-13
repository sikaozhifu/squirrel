package com.ldu.algorithm;

import java.util.List;

public class RecommentUser {

    public RecommentUser(int id) {
        this.id = id;
    }

    private int id;

    private List<Integer> likeList;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public List<Integer> getLikeList() {
        return likeList;
    }

    public void setLikeList(List<Integer> likeList) {
        this.likeList = likeList;
    }


    public RecommentUser() {
    }
}
