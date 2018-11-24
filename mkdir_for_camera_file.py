import os
import sys
def run():
    path="C:/Users/Administrator/Desktop/20181123/20181123_data0"
    for i in range(19):
        cmd="c: && cd "+path+" && mkdir {0:02}".format(i)
        print(cmd)
        os.system(cmd)
        cmd="c: && cd "+path+"/{0:02}".format(i)
        cmd2=" && mkdir Data Mask Opt Raw Seg Tmp"
        cmd3= cmd+cmd2
        print(cmd3)
        os.system(cmd3)





if __name__=='__main__':
    run()