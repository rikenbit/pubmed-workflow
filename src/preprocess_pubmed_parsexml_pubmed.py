#!/usr/bin/python
# -*- coding: utf_8 -*-
import re
import sys

from xml.dom.pulldom import END_ELEMENT, START_ELEMENT, parse

# XML file name
xml_file = sys.argv[1]
doc = parse(xml_file)

# open output file
out_file = sys.argv[2]
out = open(out_file, 'w')

# Initialize
PMID = ""

# parse XML
for event, node in doc:
  if event == START_ELEMENT and node.localName == "MedlineCitation":
    try:
      # Initialize
      PMID = ""
      doc.expandNode(node)
      # PMID
      for t in node.childNodes:
        if t.localName == 'PMID':
          PMID="".join(tt.nodeValue for tt in t.childNodes if tt.nodeType == tt.TEXT_NODE)
      # remove duplicate
      PMID = PMID.replace("|||","")
      PMID = PMID.replace("\n","")
      # output
      out.write(PMID)
      out.write("\n")
    except IndexError:
      pass
    except AttributeError:
      pass
out.close()