package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import samples.Mix.CModule;
	import samples.Mix.ram;
	import samples.Mix.DeleteBytes;
	import samples.Mix.StartCMixArray;
	import samples.Mix.StartMixStr;
	import samples.Mix.StartMixKey;
	import samples.Mix.StartMixByKey;

	public class MixArray extends Sprite
	{

		//文本
		private var tf:TextField;

	    public function MixArray()
	    {
	      	addEventListener(Event.ADDED_TO_STAGE, initCode);
	    }
	 
	    public function initCode(e:Event):void
	    {
	      	CModule.startAsync(this);
	      
	      	tf = new TextField;
	      	tf.multiline = true;
	      	tf.width = stage.stageWidth;
	      	tf.height = stage.stageHeight;
	      	addChild(tf);

	      	//var ptr:int = CModule.malloc(4);
	      	//CModule.writeString(ptr,"abdc");
	      	//var result:String = StartMixByKey("abdc");
	      	//tf.appendText("result:" +"\n" +result + "\n");
	      	//result = CModule.readString(ptr,64);
	      	//tf.appendText("read:"+result);

	      	//
	      	


	      	//测试代码
	      	//var writeIntVector:Vector.<int> = Vector.<int>([1,2,3,4,5,6,7,8,20,30,40,50]);
	      	
	      	//调用混淆函数
	      	//var results:Vector.<int> = getMixArray(writeIntVector);

	      	//字符串地址
	      	//var strPtr:int = CModule.malloc(4);
	      	//CModule.writeString(strPtr,"zhuhai");

	      	//var result:String = StartMixStr(strPtr);
	      	//tf.appendText(result + "\n");

	      	//ram.position = strPtr;
	      	//打印
	      	//result = CModule.readString(strPtr,20);
	      	//tf.appendText(result + "\n");
	    }

	    public function getMixArray(source:Vector.<int>):Vector.<int>
	    {
	    	var len:int = source.length;

	    	var i:int = 0;

	    	tf.appendText("source：\n");
	    	//打印原始数组
	    	for(i = 0;i < source.length; i++)
	    	{
	    		//
	      		tf.appendText("" + source[i] + ",");
	    	}
	    	tf.appendText("\n");

			//申请地址
	      	var localPtr:int = malloc(len*4);

	      	tf.appendText("申请的地址:" + localPtr + "\n");

	      	//写入
            writeArray(localPtr,source);

	      	//开始混淆
	      	startMixArray(localPtr,len);

	      	//结果
	      	tf.appendText("result：\n");
	      	//读取
	      	var result:Vector.<int> = readArray(localPtr,len);
			for(i = 0;i<result.length;i++)
			{
				tf.appendText("" + result[i] + ",");
			}

			tf.appendText("\n");

			return result;
	    }

	    /**
	    **申请内存地址
	    */
	    private function malloc(len:int):int
	    {
	    	//申请内存地址
	    	var ptr:int = CModule.malloc(len);
	    	return ptr;
	    }

	    /**
	    *写入
	    */
	    private function writeArray(ptr:int,array:Vector.<int>):void
	    {
			CModule.writeIntVector(ptr,array);
	    }

	    /**
	    **开始混淆
	    */
	    private function startMixArray(ptr:int,len:int):void
	    {
	    	//开始调用C++函数混淆
	    	var result:int = StartCMixArray(ptr,len);
	    	//var result:int = StartTestCMixArray();
	    	//tf.appendText("md5:" + result + "\n");
	    }

	    /**
	    *读取
	    */
	    private function readArray(ptr:int,len:int):Vector.<int>
	    {
	    	var array:Vector.<int> = new Vector.<int>();
	    	ram.position = ptr;
	    	for (var i:int = 0;i < len;i++)
	    	{
	    		//读取数据
	    		array[i] = ram.readInt();
	    	}
	    	return array;
	    }

	    /*
	    *清理
	    */
	    private function destroy(ptr:int,cppPtr:int):void
	    {
	    	//释放申请的内存
	    	CModule.free(ptr);

	    	//调用c++释放内存函数
	      	DeleteBytes(cppPtr);
	    }
	}
}