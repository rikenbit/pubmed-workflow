#!/usr/bin/python
# -*- coding: utf_8 -*-
import re
import sys

from xml.dom.pulldom import END_ELEMENT, START_ELEMENT, parse

# XML file name
xml_file = sys.argv[1]

doc = parse(xml_file)

Journal = ""
Year = ""
Title = ""
Abstract = ""
Abstract_List = []
PMID = ""
PMCID = ""
DESC_ID_List = []
DESC_Term_List = []
QUAL_ID_List = []
QUAL_Term_List = []
SCR_ID_List = []
SCR_Term_List = []

# open output file
p1 = re.compile("zip/zip/")
p2 = re.compile(".xml")
file1 = p2.sub("", p1.sub("pubmed_", xml_file)) + ".txt"
file2 = p2.sub("", p1.sub("pmc_", xml_file)) + ".txt"
file3 = p2.sub("", p1.sub("descriptor_", xml_file)) + ".txt"
file4 = p2.sub("", p1.sub("qualifier_", xml_file)) + ".txt"
file5 = p2.sub("", p1.sub("scr_", xml_file)) + ".txt"
out1 = open(file1, 'a')
out2 = open(file2, 'a')
out3 = open(file3, 'a')
out4 = open(file4, 'a')
out5 = open(file5, 'a')

# parse XML
for event, node in doc:
  if event == START_ELEMENT and node.localName == "MedlineCitation":
    try:
      # Initialize
      Journal = ""
      Year = ""
      Title = ""
      Abstract = ""
      Abstract_List = []
      PMID = ""
      PMCID = ""
      DESC_ID_List = []
      DESC_Term_List = []
      QUAL_ID_List = []
      QUAL_Term_List = []
      SCR_ID_List = []
      SCR_Term_List = []
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
      Abstract = Abstract.replace("|||","")
      Abstract = Abstract.replace("\n","")

      # output
      out1.write(PMID)
      out1.write("|||")
      out1.write(Journal)
      out1.write("|||")
      out1.write(Year)
      out1.write("|||")
      out1.write(Title)
      out1.write("|||")
      out1.write(Abstract)
      out1.write("\n")
    except IndexError:
      pass
    except AttributeError:
      pass

    # DESCRIPTOR/QUALIFIER ID
    # DESCRIPTOR/QUALIFIER Term
    try:
      # Case 1
      mhl = node.getElementsByTagName('MeshHeadingList')[0].getElementsByTagName('MeshHeading')
      for mh in mhl:
        d = mh.getElementsByTagName('DescriptorName')[0]
        DESC_ID = "".join(d.getAttribute(attname="UI"))
        DESC_Term = "".join(t.nodeValue for t in d.childNodes if t.nodeType == t.TEXT_NODE)

        q = mh.getElementsByTagName('QualifierName')[0]
        QUAL_ID = "".join(q.getAttribute(attname="UI"))
        QUAL_Term = "".join(t.nodeValue for t in q.childNodes if t.nodeType == t.TEXT_NODE)

        DESC_ID_List.append(DESC_ID)
        DESC_Term_List.append(DESC_Term)

        QUAL_ID_List.append(QUAL_ID)
        QUAL_Term_List.append(QUAL_Term)

      # Case 2
      mhl = node.getElementsByTagName('PublicationType')
      for mh in mhl:
        DESC_ID = "".join(mh.getAttribute(attname="UI"))
        DESC_Term = "".join(t.nodeValue for t in d.childNodes if t.nodeType == t.TEXT_NODE)

        DESC_ID_List.append(DESC_ID)
        DESC_Term_List.append(DESC_Term)

      # output
      for num in range(len(DESC_ID_List)):
        DESC_ID = DESC_ID_List[num].replace("|||","")
        DESC_ID = DESC_ID.replace("\n","")
        DESC_Term = DESC_Term_List[num].replace("|||","")
        DESC_Term = DESC_Term.replace("\n","")
        out3.write(PMID)
        out3.write("|||")
        out3.write(DESC_ID)
        out3.write("|||")
        out3.write(DESC_Term)
        out3.write("\n")
      for num in range(len(QUAL_ID_List)):
        QUAL_ID = QUAL_ID_List[num].replace("|||","")
        QUAL_ID = QUAL_ID.replace("\n","")
        QUAL_Term = QUAL_Term_List[num].replace("|||","")
        QUAL_Term = QUAL_Term.replace("\n","")
        out4.write(PMID)
        out4.write("|||")
        out4.write(QUAL_ID)
        out4.write("|||")
        out4.write(QUAL_Term)
        out4.write("\n")
    except IndexError:
      pass
    except AttributeError:
      pass

    # SCR ID
    # SCR Term
    try:
      # Case 1
      mhl = node.getElementsByTagName('Chemical')
      for mh in mhl:
        s = mh.getElementsByTagName('NameOfSubstance')[0]
        SCR_ID = s.getAttribute(attname="UI")
        SCR_Term = "".join(t.nodeValue for t in s.childNodes if t.nodeType == t.TEXT_NODE)
        Match_SCR = re.search("^C.*", SCR_ID)
        if Match_SCR != None:
          SCR_ID_List.append(Match_SCR.group())
          SCR_Term_List.append(SCR_Term)
      # Case 2
      mhl = node.getElementsByTagName('SupplMeshList')
      for mh in mhl:
        s = mh.getElementsByTagName('SupplMeshName')[0]
        SCR_ID = s.getAttribute(attname="UI")
        SCR_Term = "".join(t.nodeValue for t in s.childNodes if t.nodeType == t.TEXT_NODE)
        Match_SCR = re.search("^C.*", SCR_ID)
        if Match_SCR != None:
          SCR_ID_List.append(Match_SCR.group())
          SCR_Term_List.append(SCR_Term)
      # output
      for num in range(len(SCR_ID_List)):
        SCR_ID = SCR_ID_List[num].replace("|||","")
        SCR_ID = SCR_ID.replace("\n","")
        SCR_Term = SCR_Term_List[num].replace("|||","")
        SCR_Term = SCR_Term.replace("\n","")
        out5.write(PMID)
        out5.write("|||")
        out5.write(SCR_ID)
        out5.write("|||")
        out5.write(SCR_Term)
        out5.write("\n")
    except IndexError:
      pass
    except AttributeError:
      pass

    # PMCID
    try:
      mhl = node.getElementsByTagName('OtherID')
      for mh in mhl:
        PMCID = "".join(t.nodeValue for t in mh.childNodes if t.nodeType == t.TEXT_NODE)
        Match_PMC = re.search("^PMC\\d*", PMCID)
        if Match_PMC != None:
          PMCID = Match_PMC.group()
          # Output
          out2.write(PMID)
          out2.write("|||")
          out2.write(PMCID)
          out2.write("\n")
    except IndexError:
      pass
    except AttributeError:
      pass

out1.close()
out2.close()
out3.close()
out4.close()
out5.close()