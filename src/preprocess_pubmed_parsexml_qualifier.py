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
QUAL_ID_List = []
QUAL_Term_List = []

# parse XML
for event, node in doc:
  if event == START_ELEMENT and node.localName == "MedlineCitation":
    try:
      # Initialize
      PMID = ""
      QUAL_ID_List = []
      QUAL_Term_List = []
      doc.expandNode(node)
      # PMID
      for t in node.childNodes:
        if t.localName == 'PMID':
          PMID="".join(tt.nodeValue for tt in t.childNodes if tt.nodeType == tt.TEXT_NODE)
      # remove duplicate
      PMID = PMID.replace("|||","")
      PMID = PMID.replace("\n","")
      # Case
      mhl = node.getElementsByTagName('MeshHeadingList')[0].getElementsByTagName('MeshHeading')
      for mh in mhl:
        q = mh.getElementsByTagName('QualifierName')[0]
        tmp = "".join(q.getAttribute(attname="UI"))
        tmp2 = "".join(t.nodeValue for t in q.childNodes if t.nodeType == t.TEXT_NODE)
        QUAL_ID_List.append(tmp)
        QUAL_Term_List.append(tmp2)
      # output
      for num in range(len(QUAL_ID_List)):
        tmp3 = QUAL_ID_List[num].replace("|||","").replace("\n","")
        tmp4 = QUAL_Term_List[num].replace("|||","").replace("\n","")
        out.write(PMID)
        out.write("|||")
        out.write(tmp3)
        out.write("|||")
        out.write(tmp4)
        out.write("\n")
    except IndexError:
      pass
    except AttributeError:
      pass
out.close()