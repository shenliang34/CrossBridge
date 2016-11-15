T05: check
	@echo "-------- Sample 5 --------"

	@echo && echo "Now compile a SWC and demo SWF"
	"$(FLASCC)/usr/bin/g++" $(BASE_CFLAGS) -O4 -flto-api=exports.txt md5.cpp as3api.cpp -emit-swc=samples.Mix -o Mix.swc -jvmopt=-Xmx1G
	# "$(FLEX)/bin/mxmlc" -static-link-runtime-shared-libraries -compiler.omit-trace-statements=false -library-path=Mix.swc -debug=false MixArray.as -o MixArray.swf

include ../Makefile.common

clean:
	rm -f *.swf *.swc *.bc *.exe
