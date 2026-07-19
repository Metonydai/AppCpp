#include <fmt/core.h>
#include <vector>
#include <string>
#include <memory>
#include <dlfcn.h> 

#include <opencv2/opencv.hpp>


int main() {
    // 1. 開啟 USB 相機
    cv::utils::logging::setLogLevel(cv::utils::logging::LOG_LEVEL_ERROR);
    cv::VideoCapture cap(0);
    
    if (!cap.isOpened()) {
        fmt::print(stderr, "錯誤：無法開啟 USB 相機！\n");
        return -1;
    }

    // 2. 設定擷取解析度
    cap.set(cv::CAP_PROP_FRAME_WIDTH, 640);
    cap.set(cv::CAP_PROP_FRAME_HEIGHT, 480);

    // 取得實際的硬體參數
    double width = cap.get(cv::CAP_PROP_FRAME_WIDTH);
    double height = cap.get(cv::CAP_PROP_FRAME_HEIGHT);
    double fps = cap.get(cv::CAP_PROP_FPS);
    
    // 使用 fmt::print 替代 std::cout
    fmt::print("相機成功啟動！解析度: {}x{} | 預設 FPS: {}\n", width, height, fps);
    fmt::print("提示：在視窗畫面上按下 'q' 鍵或 ESC 鍵即可關閉程式。\n");

    cv::Mat frame;
    
    // 3. 進入無窮影像擷取迴圈
    while (true) {
        cap >> frame;
        
        if (frame.empty()) {
            fmt::print(stderr, "警告：抓取到空畫面。\n");
            break;
        }

        // 4. 顯示畫面到視窗
        cv::imshow("USB Camera Test", frame);

        // 5. 等待 1 毫秒並偵測鍵盤事件
        char key = (char)cv::waitKey(1);
        if (key == 'q' || key == 27) { 
            break;
        }
    }

    // 6. 釋放相機硬體資源與關閉所有視窗
    cap.release();
    cv::destroyAllWindows();
    
    fmt::print("相機程式安全結束。\n");
    return 0;
}