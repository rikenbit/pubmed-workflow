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
LASTNAME = ""
FORENAME = ""
AFFILIATION = ""
LASTNAME_List = []
FORENAME_List = []
AFFILIATION_List = []

# parse XML
for event, node in doc:
  if event == START_ELEMENT and node.localName == "MedlineCitation":
    try:
      # Initialize
      PMID = ""
      LASTNAME = ""
      FORENAME = ""
      AFFILIATION = ""
      LASTNAME_List = []
      FORENAME_List = []
      AFFILIATION_List = []
      doc.expandNode(node)
      # PMID
      for t in node.childNodes:
        if t.localName == 'PMID':
          PMID="".join(tt.nodeValue for tt in t.childNodes if tt.nodeType == tt.TEXT_NODE)

      # LASTNAME / FORENAME / AFFILIATION
      mhl = node.getElementsByTagName('AuthorList')[0].getElementsByTagName('Author')
      for mh in mhl:
        tmp = mh.getElementsByTagName('LastName')[0].childNodes[0].nodeValue
        tmp2 = mh.getElementsByTagName('ForeName')[0].childNodes[0].nodeValue
        tmp3 = mh.getElementsByTagName('Affiliation')
        LASTNAME_List.append(tmp)
        FORENAME_List.append(tmp2)
        if (tmp3 == []):
          AFFILIATION_List.append("")
        else:
          AFFILIATION_List.append(tmp3[0].childNodes[0].nodeValue)
      # output
      PMID = PMID.replace("|||","")
      PMID = PMID.replace("\n","")
      for num in range(len(LASTNAME_List)):
        # remove duplicate
        LASTNAME = LASTNAME_List[num].replace("|||","").replace("\n","")
        FORENAME = FORENAME_List[num].replace("|||","").replace("\n","")
        AFFILIATION = AFFILIATION_List[num].replace("|||","").replace("\n","")
        # output
        out.write(PMID)
        out.write("|||")
        out.write(LASTNAME)
        out.write("|||")
        out.write(FORENAME)
        out.write("|||")
        out.write(AFFILIATION)
        out.write("\n")
    except IndexError:
      pass
    except AttributeError:
      pass
out.close()