// Copyright (c) 2013 Adobe Systems Inc

// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:

// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.

// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.
#include <stdlib.h>
#include "AS3/AS3.h"
#include "md5.h"
// #include "Md5Create.h"
#include <string>


// First we mark the function declaration with a GCC attribute specifying the
// AS3 signature we want it to have in the generated SWC. The function will
// be located in the sample.MurmurHash namespace.
// void ReturnConstNumber() __attribute__((used,
// 	annotate("as3sig:public function ReturnConstNumber(numInt:int):int"),
// 	annotate("as3package:sample.Demo")));

// void ReturnConstNumber()
// {
//     int num = 0;
//     AS3_GetScalarFromVar(num,numInt)

//     int result = num * 2;
//     AS3_Return(result);
// }

// int main(int argc, char const *argv[])
// {
//     AS3_GoAsync();
// }



void StartCMixArray() __attribute__((used,
    annotate("as3sig:public function StartCMixArray(ptr:int,arrayLen:int):int"),
    annotate("as3package:samples.Mix")));

void StartCMixArray()
{
    // printf("%s\n", "fafaffa");
    int aLen = 0;
    AS3_GetScalarFromVar(aLen,arrayLen);

    int *bytes = new int[aLen];
    //测试
    int count = 0;

    //将as的参数保存为c的可用参数
    AS3_GetScalarFromVar(bytes,ptr);

    //对数组元素进行处理
 	for (int i = 0; i < aLen; ++i)
 	{
 		/* code */
 		bytes[i] *= 10;
 		count += bytes[i];
 	}

    // Md5Create *m = new Md5Create();
    // m->CreateMD5();
    
    //定义一个as类型变量，并赋值C++变量给as变量
    AS3_DeclareVar(asResult,int);
    AS3_CopyScalarToVar(asResult,bytes)

    //返回这个变量
	AS3_ReturnAS3Var(asResult);
}


void StartMixStr() __attribute__((used,
    annotate("as3sig:public function StartMixStr(ptr:int):String"),
    annotate("as3package:samples.Mix")));

void StartMixStr()
{
    char* ss;
    AS3_GetScalarFromVar(ss,ptr);

    MD5 md5(ss);
    std::string result= md5.md5();

    const char* c = result.c_str();

    AS3_DeclareVar(asString,String);
    AS3_CopyCStringToVar(asString,c,32);
    //返回这个变量
    AS3_ReturnAS3Var(asString);
    
    //
    // int result = 100;
    // AS3_DeclareVar(asResult,int);
    // AS3_CopyScalarToVar (asResult,result)


 
}

void DeleteBytes() __attribute__((used,
    annotate("as3sig:public function DeleteBytes(self):void"),
    annotate("as3package:samples.Mix")));

void DeleteBytes()
{
    int *d ;
    AS3_GetScalarFromVar(d,self);

    delete []d;
    AS3_ReturnAS3Var(undefined);
}

int main(int argc, char const *argv[])
{
    AS3_GoAsync();
}
