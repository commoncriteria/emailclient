TRANS?=transforms
# Optionally include some User preferences.
-include User.make

default:
	xsltproc -o output/emailclient.html $(TRANS)/module/module2html.xsl input/emailclient.xml
	xsltproc -o output/emailclient-sd.html $(TRANS)/module/module2sd.xsl input/emailclient.xml
	xsltproc -o output/emailclient-all.html $(TRANS)/pp2html.xsl input/emailclient.xml

# Include the bulk
#include $(TRANS)/Module.make
