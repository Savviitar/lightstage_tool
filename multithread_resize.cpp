#include <iostream>
#include<fstream>
#include<opencv2/opencv.hpp>
#include<string>
#include<thread>
#include<time.h>
#include<mutex>
using namespace std;
std::mutex m;
int main()
{
	char path[100] = "K:/lightstage_data/lightstage_data_2018/CoreView_99";
	
	int index[21] = {1,3,4,5,7,8,9,10,11,12,13,15,16,17,18,19,20,21,22,23,24};
	std::vector<std::thread> workers;
	time_t start, end;
	start = time(NULL);
	for (int i = 0; i < 21; i++)
	{
		int idx = index[i];
		workers.push_back(std::thread([=] 
		{
			char p[100];
			char p2[100];
			for (int j = 1; j <= 100; j++)
			{
				if (i == 0)
					sprintf(p, "%s/Camera (%d)/CoreView_99_Camera(%d)_%03d.jpg", path, idx, idx, j);
				else
					sprintf(p, "%s/Camera (%d)/CoreView_99_Camera_(%d)_%03d.jpg", path, idx, idx, j);
				sprintf(p2, "%s_test/cam%02d/cam%02d_%04d.jpg", path, idx, idx, j);
				cv::Mat img = cv::imread(p);
				cv::Mat img2;
				resize(img, img2, cv::Size(1024, 1024));
				std::lock_guard<std::mutex> lock(m);
				cv::imwrite(p2, img2);
			}
		}));

	}
	for (auto& worker : workers) {
		worker.join();//The main thread wait for thread without do anything!
	}
	end = time(NULL);
	cout << end - start << endl;
    }