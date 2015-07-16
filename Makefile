IN = input
OUT = output
TRANS = transforms
APP_XML=$(IN)/emailclient.xml
TABLE=$(OUT)/emailclient-table.html
SIMPLIFIED=$(OUT)/emailclient-table-reqs.html
APP_HTML=$(OUT)/emailclient.html
APP_OP_HTML=$(OUT)/emailclient-optionsappendix.html
APP_RELEASE_HTML=$(OUT)/emailclient-release.html
OUTPUTS=$(TABLE) $(SIMPLIFIED) $(APP_HTML) $(APP_OP_HTML) $(APP_RELEASE_HTML)
all: $(TABLE) $(SIMPLIFIED) $(APP_HTML)

spellcheck: $(OUTPUTS)
	bash -c "hunspell -l -H -p <(cat transforms/dictionaries/CommonCriteria.txt transforms/dictionaries/Computer.txt transforms/dictionaries/Crypto.txt transforms/dictionaries/EmailClientSpecific.txt) output/*.html | sort"

pp:$(APP_HTML)
$(APP_HTML):  $(TRANS)/pp2html.xsl $(APP_XML)
	xsltproc -o $(APP_HTML) $(TRANS)/pp2html.xsl $(APP_XML)
	xsltproc --stringparam appendicize on -o $(APP_OP_HTML) $(TRANS)/pp2html.xsl $(APP_XML)
	xsltproc --stringparam appendicize on --stringparam release final -o $(APP_RELEASE_HTML) $(TRANS)/pp2html.xsl $(APP_XML)

table: $(TABLE)
$(TABLE): $(TRANS)/pp2table.xsl $(APP_XML)
	xsltproc  --stringparam release final -o $(TABLE) $(TRANS)/pp2table.xsl $(APP_XML)

simplified: $(SIMPLIFIED)
$(SIMPLIFIED): $(TRANS)/pp2simplified.xsl $(APP_XML)
	xsltproc --stringparam release final -o $(SIMPLIFIED) $(TRANS)/pp2simplified.xsl $(APP_XML)

transforms/schemas/schema.rnc: transforms/schemas/schema.rng
	trang -I rng -O rnc  transforms/schemas/schema.rng transforms/schemas/schema.rnc

clean:
	@for f in a $(TABLE) $(SIMPLIFIED) $(APP_HTML) $(APP_RELEASE_HTML) $(APP_OP_HTML); do \
		if [ -f $$f ]; then \
			rm "$$f"; \
		fi; \
	done
