#!/usr/bin/make

objects=$(wildcard *.xml) $(wildcard */*.xml) $(wildcard **/*.xml)
bases=$(basename $(objects))
txts=$(addsuffix .txt, $(bases))

rfcs: $(txts)
	@echo "objects: "
	@echo $(objects)
	@echo "bases: "
	@echo $(bases)

all_formats: $(bases).txt $(bases).html $(bases).md

%.txt : %.xml
	xml2rfc $< -o $@ --text

%.html : %.xml
	xml2rfc $< -o $@ --html

%.raw.txt : %.xml
	xml2rfc $< -o $@ --raw

%.md : %.html
	pandoc $< -f html -t markdown_github -s -o $@

clean:
	rm -f $(bases).txt $(bases).html $(bases).raw.txt $(bases).md

