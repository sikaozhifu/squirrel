package com.ldu.pojo;

import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

public class Chats {
    public Chats() {

    }

    /*   */
    private Integer id;
    /* 发言人  */
    private Integer sayuser;
    /* 聊天对象  */
    private Integer lisuser;
    /* 发送内容  */
    private String content;
    /* 创建时间  */
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createtime;
    /*   */
    private Integer sate;

    private String time;

    private String sayname;

    private String lisname;

    public String getTime() {
        return time;
    }

    public String getSayname() {
        return sayname;
    }

    public String getLisname() {
        return lisname;
    }

    public void setTime(String time) {
        this.time = time;
    }

    public void setSayname(String sayname) {
        this.sayname = sayname;
    }

    public void setLisname(String lisname) {
        this.lisname = lisname;
    }

    public Integer getId() {
        return this.id;
    }

    public Integer getSayuser() {
        return this.sayuser;
    }

    public Integer getLisuser() {
        return this.lisuser;
    }

    public String getContent() {
        return this.content;
    }

    @JsonFormat(timezone = "GMT+8", pattern = "yyyy-MM-dd HH:mm:ss")
    public Date getCreatetime() {
        return this.createtime;
    }

    public Integer getSate() {
        return this.sate;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public void setSayuser(Integer sayuser) {
        this.sayuser = sayuser;
    }

    public void setLisuser(Integer lisuser) {
        this.lisuser = lisuser;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public void setCreatetime(Date createtime) {
        this.createtime = createtime;
    }

    public void setSate(Integer sate) {
        this.sate = sate;
    }
}