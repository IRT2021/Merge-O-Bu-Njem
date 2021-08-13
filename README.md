# Merge-O-Bu-Njem
XML and stylesheets to merge O. Bu Njem data, text and translation from Papyri.info into a single EpiDoc file for IRT 2021

### Repository contains:

* **XML**: from ddbdp (Duke Databank: Latin texts), hgv (Heidelberger Gesamtverzeichnis: object descriptions), translation (translations produced by users of Papyri.info: principally Gabriel Bodard and Scott Vanderbilt [into English] and Usama Gad [into Arabic]); currently manual copies from the Papyri.info repository.
* **XSLT**: a simple XSLT stylesheet that imports the text and translation into the HGV metadata file, creating a single EpiDoc file.
* **Output XML** (folder "epidoc"): currently a few sample transformed files. These will need to be further enhanced—both programmatically and manually—to align them to Inscription of Roman Tripolitania house style and metadata, authority lists, etc.

### Scripts by:

* Gabriel Bodard
