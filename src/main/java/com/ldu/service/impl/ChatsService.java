package com.ldu.service.impl;

import com.ldu.dao.ChatsMapper;
import com.ldu.pojo.Chats;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service
public class ChatsService {
    @Autowired
    private ChatsMapper chatsDao;

    public Chats selectByPrimaryKey(Integer id) {
        Chats result = chatsDao.selectByPrimaryKey(id);
        return result;
    }
    public int insertSelective(Chats record) {
         return chatsDao.insertSelective(record);
    }

    public int deleteByPrimaryKey(Integer id) {
        return chatsDao.deleteByPrimaryKey(id);
    }
  
    public int updateByPrimaryKeySelective(Chats record) {
        return chatsDao.updateByPrimaryKeySelective(record);
    }
    
    public List<Chats> selectAll(Chats chats){
        return chatsDao.selectAll(chats);
    }
    public List<Chats> getChatPeople(Integer chats){
        return chatsDao.getChatPeople(chats);
    }
    
    public int selectCount(){
         return chatsDao.selectCount();
    }
}