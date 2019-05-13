package com.ldu.dao;

import com.ldu.pojo.Chats;

import java.util.List;

public interface ChatsMapper {

    Chats selectByPrimaryKey(Integer id);

    int insertSelective(Chats record);
    
    int deleteByPrimaryKey(Integer id);
    
    int updateByPrimaryKeySelective(Chats record);
    
    List<Chats > selectAll(Chats chats);
    List<Chats > getChatPeople(Integer uid);

    int selectCount();
    
}