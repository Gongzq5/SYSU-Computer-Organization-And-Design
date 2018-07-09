一、编译器
1. 编译
g++ Compiler.cpp -o Compiler.exe -std=c++11

2. 使用
(a) Compiler.exe
在test.txt中存放指令
Compiler.exe < test.txt

输出文件在out.txt中

(b) Click.exe
在test.txt中存放指令，在out.txt中输出
双击运行即可
(源文件内重定向了输入文件)

二、转换16进制
这个比较简单，推荐命令行
ConvertBinaryToHex.exe < out.txt > outinhex.txt

要对out.txt做一下处理，要求是4个一组

例如:
0010 0000 0000 0100
0011 0011 1001 1011
...