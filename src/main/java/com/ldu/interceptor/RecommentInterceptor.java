package com.ldu.interceptor;

import com.ldu.algorithm.RecommentUser;
import com.ldu.algorithm.UserCF;
import com.ldu.dao.FocusMapper;
import com.ldu.pojo.*;
import com.ldu.service.GoodsService;
import com.ldu.service.ImageService;
import com.ldu.service.UserService;
import com.ldu.service.impl.ChatsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.List;

public class RecommentInterceptor implements HandlerInterceptor {

    @Autowired
    private ChatsService chatsService;
    @Autowired
    private UserService userService;
    @Autowired
    private FocusMapper focusMapper;
    @Autowired
    private GoodsService goodsService;
    @Autowired
    private ImageService imageService;
    public boolean preHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o) throws Exception {
        return true;
    }

    public void postHandle(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, ModelAndView modelAndView) throws Exception {
        User cur_user = (User)httpServletRequest.getSession().getAttribute("cur_user");

        if (cur_user != null){
            UserCF userCF = new UserCF();
            List<RecommentUser> recommentUserList = new ArrayList<>();

            List<User> users = userService.getPageUser(1,999);
            for (int i = 0; i < users.size(); i++) {
                RecommentUser recommentUser = new RecommentUser();
                List<Integer> likeList = new ArrayList<>();
                List<Focus> mylikes = focusMapper.getFocusByUserId(users.get(i).getId());
                if(mylikes != null){
                    for (int j = 0; j < mylikes.size(); j++) {
                        likeList.add(mylikes.get(j).getGoodsId());
                    }
                }
                recommentUser.setId(users.get(i).getId());
                recommentUser.setLikeList(likeList);
                recommentUserList.add(recommentUser);
            }
            List<Integer> recoment = userCF.recoment(recommentUserList, cur_user.getId());
            List<Goods> recomentSongs = new ArrayList<>();
            for (int i = 0; i < recoment.size(); i++) {
                Goods goods = goodsService.getGoodsById(recoment.get(i));
                if (goods == null){
                    continue;
                }
                List<Image> images = imageService.getImagesByGoodsPrimaryKey(goods.getId());
                goods.setImageList(images);
                recomentSongs.add(goods);
                recomentSongs.add(goods);
            }
            httpServletRequest.setAttribute("recomments",recomentSongs);
        }
    }

    public void afterCompletion(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Object o, Exception e) throws Exception {

    }
}
