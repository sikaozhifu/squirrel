
package com.ldu.algorithm;
 
import java.util.*;
import java.util.Map.Entry;

/**
 * 基于用户的协同过滤推荐算法实现
A a b d
B a c
C b e
D c d e
 * @author Administrator
 *
 */
public class UserCF {


	/**
	 *
	 * @param userList 用户喜好集合
	 * @param recommendUser 需要的用户
	 * @return
	 */
	public List<Integer> recoment(List<RecommentUser> userList, Integer recommendUser){
		List<Sorf> sorfList = new ArrayList<>();
		int[][] sparseMatrix = new int[userList.size()][userList.size()];//建立用户稀疏矩阵，用于用户相似度计算【相似度矩阵】
		Map<Integer, Integer> userItemLength = new HashMap<>();//存储每一个用户对应的不同物品总数  eg: A 3
		Map<Integer, Set<Integer>> itemUserCollection = new HashMap<>();//建立物品到用户的倒排表 eg: a A B
		Set<Integer> items = new HashSet<>();//辅助存储物品集合
		Map<Integer, Integer> userID = new HashMap<>();//辅助存储每一个用户的用户ID映射
		Map<Integer, Integer> idUser = new HashMap<>();//辅助存储每一个ID对应的用户映射
		System.out.println("Input user--items maping infermation:<eg:A a b d>");

		for(int i = 0; i < userList.size() ; i++){//依次处理N个用户 输入数据  以空格间隔
			RecommentUser user = userList.get(i);
			int uid = userList.get(i).getId();
			int size = userList.get(i).getLikeList().size();
			userItemLength.put(uid, size);//eg: A 3
			userID.put(uid, i);//用户ID与稀疏矩阵建立对应关系
			idUser.put(i, uid);
			//建立物品--用户倒排表
			for(int j = 0; j < size; j ++){
				if(items.contains(user.getLikeList().get(j))){//如果已经包含对应的物品--用户映射，直接添加对应的用户
					itemUserCollection.get(user.getLikeList().get(j)).add(uid);
				}else{//否则创建对应物品--用户集合映射
					items.add(user.getLikeList().get(j));
					itemUserCollection.put(user.getLikeList().get(j), new HashSet<Integer>());//创建物品--用户倒排关系
					itemUserCollection.get(user.getLikeList().get(j)).add(uid);
				}
			}
		}


		System.out.println(itemUserCollection.toString());
		//计算相似度矩阵【稀疏】
		Set<Entry<Integer, Set<Integer>>> entrySet = itemUserCollection.entrySet();
		Iterator<Entry<Integer, Set<Integer>>> iterator = entrySet.iterator();
		while(iterator.hasNext()){
			Set<Integer> commonUsers = iterator.next().getValue();
			for (Integer user_u : commonUsers) {
				for (Integer user_v : commonUsers) {
					if(user_u.equals(user_v)){
						continue;
					}
					sparseMatrix[userID.get(user_u)][userID.get(user_v)] += 1;//计算用户u与用户v都有正反馈的物品总数
				}
			}
		}

		for (int i = 0; i < userList.size(); i++) {
			System.out.println("用户" + userList.get(i).getId() + ":" + userList.get(i).getLikeList().toString());
		}
		//计算用户之间的相似度【余弦相似性】
		int recommendUserId = userID.get(recommendUser);
		for (int j = 0;j < sparseMatrix.length; j++) {
			if(j != recommendUserId){
				System.out.println(idUser.get(recommendUserId)+"--"+idUser.get(j)+"相似度:"+sparseMatrix[recommendUserId][j]/Math.sqrt(userItemLength.get(idUser.get(recommendUserId))*userItemLength.get(idUser.get(j))));
			}
		}

		//计算指定用户recommendUser的物品推荐度
		for(Integer item: items){//遍历每一件物品
			Set<Integer> users = itemUserCollection.get(item);//得到购买当前物品的所有用户集合
			if(!users.contains(recommendUser)){//如果被推荐用户没有购买当前物品
				// 则进行推荐度计算
				double itemRecommendDegree = 0.0;
				for(Integer user: users){
					itemRecommendDegree += sparseMatrix[userID.get(recommendUser)][userID.get(user)]/Math.sqrt(userItemLength.get(recommendUser)*userItemLength.get(user));//推荐度计算
				}
				System.out.println("商品"+item+" 对用户 "+recommendUser +"'推荐度:"+itemRecommendDegree);
				Sorf sorf = new Sorf(item,itemRecommendDegree);
				sorfList.add(sorf);
			}
		}
		Collections.sort(sorfList);
		int size = 0;
		if(sorfList.size() <5){
			size = sorfList.size();
		}else {
			size = 4;
		}
		List<Integer> ids = new ArrayList<>();
		for (int i = 0; i < size; i++) {
			ids.add(sorfList.get(i).getKey());
		}
		return ids;
	}
}