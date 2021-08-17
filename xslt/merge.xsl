<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t"
    version="2.0">
    
    <xsl:output encoding="UTF-8" method="xml" indent="no"/>
    
    <!-- ||||||||||||||||||||||||||||||||||||||||||||||| -->
    <!-- |||||||||  copy all existing elements ||||||||| -->
    <!-- ||||||||||||||||||||||||||||||||||||||||||||||| -->
    
    <xsl:template match="t:*">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!-- |||||||||||||||||||||||||||||||||||||||||||||||||||| -->
    <!-- |||||||||||||||| copy any comments  |||||||||||||||| -->
    <!-- |||||||||||||||||||||||||||||||||||||||||||||||||||| -->
    
    <xsl:template match="comment()">
        <xsl:copy>
            <xsl:value-of select="."/>
        </xsl:copy>
        <xsl:text>
</xsl:text>
    </xsl:template>
    
    <!-- ||||||||||||||||||||||||||||||||||||||||||||||| -->
    <!-- ||||||||||||     LIST CHANGES     ||||||||||||| -->
    <!-- ||||||||||||||||||||||||||||||||||||||||||||||| -->
    
    <xsl:template match="t:revisionDesc">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:text>
         </xsl:text>
            <xsl:element name="change">
                <xsl:attribute name="when">
                    <xsl:value-of select="substring(string(current-date()),1,10)"/>
                </xsl:attribute>
                <xsl:attribute name="who">
                    <xsl:text>#GB</xsl:text>
                </xsl:attribute>
                <xsl:text>Merged HGV data, Duke Databank text, PE translation from Papyri.info EpiDoc</xsl:text>
            </xsl:element>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!-- ||||||||||||||||||||||||||||||||||||||||||||||| -->
    <!-- ||||||||||||||    EXCEPTIONS     |||||||||||||| -->
    <!-- ||||||||||||||||||||||||||||||||||||||||||||||| -->
    
    <xsl:template match="t:TEI">
        <xsl:text disable-output-escaping="yes">&#13;</xsl:text>
        <xsl:processing-instruction name="xml-model">href="http://epidoc.stoa.org/schema/latest/tei-epidoc.rng" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
        <xsl:text disable-output-escaping="yes">&#13;</xsl:text>
        <xsl:processing-instruction name="xml-model">href="http://epidoc.stoa.org/schema/latest/tei-epidoc.rng" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>
        <xsl:text disable-output-escaping="yes">&#13;</xsl:text>
        <xsl:processing-instruction name="xml-model">href="http://epidoc.stoa.org/schema/dev/ircyr-checking.sch" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>
        <xsl:text disable-output-escaping="yes">&#13;</xsl:text>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:titleStmt">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
            <xsl:text disable-output-escaping="yes">   </xsl:text>
            <editor xml:id="GB" role="translation (English)">Gabriel Bodard</editor>
            <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
            <editor xml:id="UG" role="translation (Arabic)">Usama Gad</editor>
            <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
            <editor xml:id="SV" role="translation (English)">Scott Vanderbilt</editor>
            <xsl:text disable-output-escaping="yes">&#13;          </xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:publicationStmt">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:text disable-output-escaping="yes">&#13;</xsl:text>
            <authority>King's College London</authority>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:origPlace">
        <xsl:copy>
            <xsl:text>Findspot.</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:provenance[@type='located']">
        <provenance type="found">
            <p><placeName type="ancientFindspot" ref="https://www.slsgazetteer.org/658">Bu-Ngem</placeName>: <placeName ref="https://www.slsgazetteer.org/826">Fort</placeName> from one of the gates.</p>
        </provenance>
        <provenance type="observed">
            <p><placeName ref="https://www.slsgazetteer.org/1098">Tripoli Castle</placeName>.</p>
        </provenance>
    </xsl:template>
    
    <xsl:template match="t:body">
        <xsl:variable name="hgvno" select="//t:idno[@type='filename']"/>
        <xsl:variable name="ddbno" select="//t:idno[@type='ddb-filename']"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:if test="doc-available(concat('../ddbdp/',$ddbno,'.xml'))">
                <xsl:apply-templates select="document(concat('../ddbdp/',$ddbno,'.xml'))//t:div[@type='edition']"/>
            </xsl:if>
            <xsl:if test="doc-available(concat('../translation/',$hgvno,'.xml'))">
                <xsl:apply-templates select="document(concat('../translation/',$hgvno,'.xml'))//t:div[@type='translation']"/>
            </xsl:if>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:expan/text()">
        <abbr><xsl:value-of select="."/></abbr>
    </xsl:template>
    
    <xsl:template match="t:biblScope">
        <citedRange>
            <xsl:if test="@type">
                <xsl:attribute name="unit" select="@type"/>
            </xsl:if>
            <xsl:apply-templates/>
        </citedRange>
    </xsl:template>
    
</xsl:stylesheet>