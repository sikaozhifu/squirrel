package com.ldu.test;

import com.ldu.dao.ChatsMapper;
import com.ldu.pojo.Chats;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;

import java.util.List;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration("src/main/resouces")
@ContextConfiguration(locations={"classpath:conf/applicationContext.xml","classpath:conf/spring-mvc.xml"})
public class SquirrelTest {

    protected Logger log = LoggerFactory.getLogger(getClass());
    @Autowired
    private ChatsMapper chatsMapper;

    /*List<Chats > selectAll(Chats chats);
    List<Chats > getChatPeople(Integer uid);
    * */
    @Test
    public void testGetChatPeople() {
        List<Chats> chatsList = chatsMapper.getChatPeople(27);
        for (Chats chats : chatsList) {
            log.info(chats.getLisname());
        }
    }

}
