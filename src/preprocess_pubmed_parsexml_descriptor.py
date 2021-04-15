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
DESC_ID_List = []
DESC_Term_List = []

# parse XML
for event, node in doc:
  if event == START_ELEMENT and node.localName == "MedlineCitation":
    try:
      # Initialize
      PMID = ""
      DESC_ID_List = []
      DESC_Term_List = []
      doc.expandNode(node)
      # PMID
      for t in node.childNodes:
        if t.localName == 'PMID':
          PMID="".join(tt.nodeValue for tt in t.childNodes if tt.nodeType == tt.TEXT_NODE)
      # remove duplicate
      PMID = PMID.replace("|||","")
      PMID = PMID.replace("\n","")
      # Case 1
      mhl = node.getElementsByTagName('MeshHeadingList')[0].getElementsByTagName('MeshHeading')
      for mh in mhl:
        d = mh.getElementsByTagName('DescriptorName')[0]
        tmp = "".join(d.getAttribute(attname="UI"))
        tmp2 = "".join(t.nodeValue for t in d.childNodes if t.nodeType == t.TEXT_NODE)
        DESC_ID_List.append(tmp)
        DESC_Term_List.append(tmp2)
      # Case 2
      mhl = node.getElementsByTagName('PublicationType')
      for mh in mhl:
        tmp3 = "".join(mh.getAttribute(attname="UI"))
        tmp4 = "".join(t.nodeValue for t in d.childNodes if t.nodeType == t.TEXT_NODE)
        DESC_ID_List.append(tmp3)
        DESC_Term_List.append(tmp4)
      # output
      for num in range(len(DESC_ID_List)):
        tmp5 = DESC_ID_List[num].replace("|||","").replace("\n","")
        tmp6 = DESC_Term_List[num].replace("|||","").replace("\n","")
        out.write(PMID)
        out.write("|||")
        out.write(tmp5)
        out.write("|||")
        out.write(tmp6)
        out.write("\n")
    except IndexError:
      pass
    except AttributeError:
      pass
out.close()