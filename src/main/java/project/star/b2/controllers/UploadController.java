package project.star.b2.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import project.star.b2.helper.DownloadHelper;
import project.star.b2.helper.RegexHelper;
import project.star.b2.helper.UploadItem;
import project.star.b2.helper.WebHelper;


@Controller
public class UploadController {
    // -> import study.spring.springhelper.helper.WebHelper;
    @Autowired
    WebHelper webHelper;
    
    // -> import study.spring.springhelper.helper.DownloadHelper;
    @Autowired
    DownloadHelper downloadHelper;
    
    // -> import study.spring.springhelper.helper.RegexHelper;
    @Autowired
    RegexHelper regexHelper;
    
    /** 업로드 폼을 구성하는 페이지 */
    @RequestMapping(value = "/upload/upload.do", method = RequestMethod.GET)
    public String upload() {
        return "upload/upload";
    }
    
    /** 업로드 폼에 대한 action 페이지 */
    @RequestMapping(value = "/upload/upload_ok.do", method = RequestMethod.POST)
    public ModelAndView uploadOk(Model model) {        
        /** 1) 업로드를 수행 */
        try {
            webHelper.upload();
        } catch (Exception e) {
            e.printStackTrace();
            return webHelper.redirect(null, "업로드에 실패했습니다.");
        }

        /** 2) 업로드 된 정보 추출하기 */
        // 파일 정보 추출
        List<UploadItem> fileList = webHelper.getFileList();
        // 그 밖의 일반 데이터를 저장하기 위한 컬렉션
        Map<String, String> paramMap = webHelper.getParamMap();
        
        // 텍스트 데이터에서 입력값을 추출한다.
        String subject = paramMap.get("subject");
        
        // 입력값에 대한 유효성 검사
        if (!regexHelper.isValue(subject)) {
            return webHelper.redirect(null, "제목을 입력하세요.");
        }
        
        if (!regexHelper.isKor(subject)) {
            return webHelper.redirect(null, "제목은 한글로만 입력하세요.");
        }
        
        /** 3) 업로드 결과를 View에게 전달한다 */
        model.addAttribute("fileList", fileList);
        model.addAttribute("subject", subject);

        // 중단 없이 정상적인 실행 종료를 통해 View를 호출해야 하는 경우
        // View의 경로를 ModelAndView 타입의 객체로 생성하여 리턴한다.
        String viewPath = "upload/upload_ok";
        return new ModelAndView(viewPath);
    }
    
    /** 파일 다운로드 및 썸네일을 생성하는 페이지 */
    // --> 다운로드 ex) /upload/download.do?file=이미지경로&origin=원본파일이름
    // --> 썸네일 ex) /upload/download.do?file=이미지경로&size=240x320&crop=true
    @RequestMapping(value = "/upload/download.do", method = RequestMethod.GET)
    public ModelAndView download(Model model) {
        // 서버상에 저장되어 있는 파일경로 (필수)
        String filePath = webHelper.getString("file");
        // 원본 파일이름 (미필수)
        String originName = webHelper.getString("origin");
        // 축소될 이미지 해상도 --> 320x320
        String size = webHelper.getString("size");
        // 이미지 크롭 여부 --> 값이 없을 경우 기본값 false
        String crop = webHelper.getString("crop", "false");

        /** 다운로드 스트림 출력하기 */
        if (filePath != null) {
            try {
                // 썸네일 생성을 위해 축소될 이미지의 사이즈가 요청되었다면?
                if (size != null) {
                    // x를 기준으로 나눠서 숫자로 변환
                    String[] temp = size.split("x");
                    int width = Integer.parseInt(temp[0]);
                    int height = Integer.parseInt(temp[1]);

                    // 모든 파라미터는 문자열이므로 크롭 여부를 boolean으로 재설정
                    boolean is_crop = false;
                    if (crop.equals("true")) {
                        is_crop = true;
                    }

                    // 썸네일 생성 후 다운로드 처리
                    downloadHelper.download(filePath, width, height, is_crop);
                } else {
                    // 원본에 대한 다운로드 처리
                    downloadHelper.download(filePath, originName);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        
        // View를 사용하지 않고 FileStream을 출력하므로 리턴값은 없다.
        return null;
    }
}