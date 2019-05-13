package com.ldu.controller;
import com.ldu.pojo.Chats;
import com.ldu.pojo.User;
import com.ldu.service.UserService;
import com.ldu.service.impl.ChatsService;
import org.apache.poi.ss.usermodel.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.http.HttpServletRequest;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping(value="/chats")
public class ChatsController{
    
    @Autowired
    private ChatsService chatsService;
    @Autowired
    private UserService userService;

    
    @RequestMapping(value="/detail")
    public String detail(HttpServletRequest request, Integer id) {
    
        Chats result = chatsService.selectByPrimaryKey(id);
        request.setAttribute("result",result);
     
        return "";
    }
    
    @RequestMapping(value="/list")
    @ResponseBody
    public List<Chats> list(HttpServletRequest request,Chats chats) {
    
        List<Chats> list = chatsService.selectAll(chats);
        if(list!=null){
            for (int i = 0; i < list.size(); i++) {
                Chats chats1 = list.get(i);
                User sayuser = userService.getUserById(chats1.getSayuser());
                User lisuser = userService.getUserById(chats1.getLisuser());
                chats1.setSayname(sayuser.getUsername());
                chats1.setLisname(lisuser.getUsername());
                SimpleDateFormat sd = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                String format = sd.format(chats1.getCreatetime());
                chats1.setTime(format);
            }
        }
        request.setAttribute("list",list);
        return list;
    }



    @RequestMapping(value="save")
    @ResponseBody
    public int save( Chats chats) {
        chats.setCreatetime(new Date());
        return chatsService.insertSelective(chats);
    }
    
    @RequestMapping(value="update")
    @ResponseBody
    public int update(@RequestBody Chats chats) {
        
        return chatsService.updateByPrimaryKeySelective(chats);
    }
    
    @RequestMapping(value="delete")
    @ResponseBody
    public int delete(@RequestBody Integer id) {
        
        return chatsService.deleteByPrimaryKey(id);
    }
    
    @RequestMapping(value="/add")
    public String add(HttpServletRequest request) {
        return "/addchats";
    }
    
}