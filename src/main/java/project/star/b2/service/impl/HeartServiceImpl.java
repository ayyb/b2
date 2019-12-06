package project.star.b2.service.impl;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lombok.extern.slf4j.Slf4j;
import project.star.b2.model.Heart;
import project.star.b2.service.HeartService;
@Slf4j
@Service
public class HeartServiceImpl implements HeartService{

    /** MyBatis */
    // --> import org.apache.ibatis.session.SqlSession
    @Autowired
    SqlSession sqlSession;
	@Override
	public List<Heart> getHeartGalleryList(Heart input) throws Exception {
        List<Heart> result = null;

        try {
            result = sqlSession.selectList("GalleryMapper.selectHeartList", input);

            if (result == null) {
                throw new NullPointerException("result=null");
            }
        } catch (NullPointerException e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("조회된 데이터가 없습니다.");
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }

        return result;
	}

	@Override
	public int getHeartGalleryCount(Heart input) throws Exception {
        int result = 0;
        
        try {
            result = sqlSession.selectOne("GalleryMapper.selectCountAll", null);
        } catch (Exception e) {
            log.error(e.getLocalizedMessage());
            throw new Exception("데이터 조회에 실패했습니다.");
        }
        
        return result;
	}
}