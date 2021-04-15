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
Journal = ""
Year = ""
Title = ""
PublicationType = ""
Abstract = ""
Abstract_List = []

# parse XML
for event, node in doc:
  if event == START_ELEMENT and node.localName == "MedlineCitation":
    try:
      # Initialize
      PMID = ""
      Journal = ""
      Year = ""
      Title = ""
      PublicationType = ""
      Abstract = ""
      Abstract_List = []
      doc.expandNode(node)
      # PMID
      for t in node.childNodes:
        if t.localName == 'PMID':
          PMID="".join(tt.nodeValue for tt in t.childNodes if tt.nodeType == tt.TEXT_NODE)
      ArticleNode = node.getElementsByTagName('Article')[0]
      # Journal
      JournalNode = ArticleNode.getElementsByTagName('Journal')[0]
      JournalTitleNode = JournalNode.getElementsByTagName('Title')[0]
      Journal = "".join(t.nodeValue for t in JournalTitleNode.childNodes if t.nodeType == t.TEXT_NODE)
      # Year
      YearNode = JournalNode.getElementsByTagName('JournalIssue')[0].getElementsByTagName('PubDate')[0].getElementsByTagName('Year')[0]
      Year = "".join(t.nodeValue for t in YearNode.childNodes if t.nodeType == t.TEXT_NODE)
      # Title
      ATNode = ArticleNode.getElementsByTagName('ArticleTitle')[0]
      Title = "".join(t.nodeValue for t in ATNode.childNodes if t.nodeType == t.TEXT_NODE)
      # PublicationType
      PublicationTypeNode = ArticleNode.getElementsByTagName('PublicationType')[0]
      PublicationType = "".join(t.nodeValue for t in PublicationTypeNode.childNodes if t.nodeType == t.TEXT_NODE)
      # Abstract
      AbstractNode = ArticleNode.getElementsByTagName('Abstract')[0]
      at = AbstractNode.getElementsByTagName('AbstractText')
      for att in at:
        Abstract = "".join(t.nodeValue for t in att.childNodes if t.nodeType == t.TEXT_NODE)
        Abstract_List.append(Abstract)
      Abstract = " ".join(Abstract_List)
      # remove duplicate
      PMID = PMID.replace("|||","")
      PMID = PMID.replace("\n","")
      Journal = Journal.replace("|||","")
      Journal = Journal.replace("\n","")
      Year = Year.replace("|||","")
      Year = Year.replace("\n","")
      Title = Title.replace("|||","")
      Title = Title.replace("\n","")
      PublicationType = PublicationType.replace("|||","")
      PublicationType = PublicationType.replace("\n","")
      Abstract = Abstract.replace("|||","")
      Abstract = Abstract.replace("\n","")
      # output
      out.write(PMID)
      out.write("|||")
      out.write(Journal)
      out.write("|||")
      out.write(Year)
      out.write("|||")
      out.write(Title)
      out.write("|||")
      out.write(PublicationType)
      out.write("|||")
      out.write(Abstract)
      out.write("\n")
    except IndexError:
      pass
    except AttributeError:
      pass
out.close()