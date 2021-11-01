<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
    xmlns="http://www.tei-c.org/ns/1.0"
    xmlns:t="http://www.tei-c.org/ns/1.0"
    exclude-result-prefixes="t"
    version="2.0">
    
    <xsl:output encoding="UTF-8" method="xml" indent="no"/>
    
    <!-- RESULT DOCUMENT -->
    
    <xsl:variable name="irtno" select="concat('IRT',(number(//t:idno[@type='filename']) - 71650))"/>
    
    <xsl:template match="t:TEI">    
        <xsl:result-document href="../epidoc/{$irtno}.xml">
                    <xsl:text disable-output-escaping="yes">&#13;</xsl:text>
                    <xsl:processing-instruction name="xml-model">href="http://epidoc.stoa.org/schema/9.2/tei-epidoc.rng" schematypens="http://relaxng.org/ns/structure/1.0"</xsl:processing-instruction>
                    <xsl:text disable-output-escaping="yes">&#13;</xsl:text>
                    <xsl:processing-instruction name="xml-model">href="http://epidoc.stoa.org/schema/9.2/tei-epidoc.rng" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>
                    <xsl:text disable-output-escaping="yes">&#13;</xsl:text>
                    <xsl:processing-instruction name="xml-model">href="http://epidoc.stoa.org/schema/dev/ircyr-checking.sch" schematypens="http://purl.oclc.org/dsdl/schematron"</xsl:processing-instruction>
                    <xsl:text disable-output-escaping="yes">&#13;</xsl:text>
                    <xsl:copy>
                        <xsl:copy-of select="@xmlns"/>
                        <xsl:attribute name="xml:lang">en</xsl:attribute>
                        <xsl:attribute name="xml:id"><xsl:value-of select="$irtno"/></xsl:attribute>
                        <xsl:apply-templates/>
                    </xsl:copy>
        </xsl:result-document>
    </xsl:template>
    
    
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
                <xsl:text>Merged HGV data, Duke Databank text, PE translation from Papyri.info EpiDoc; aligned structure to IRT</xsl:text>
            </xsl:element>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <!-- ||||||||||||||||||||||||||||||||||||||||||||||| -->
    <!-- ||||||||||||||    EXCEPTIONS     |||||||||||||| -->
    <!-- ||||||||||||||||||||||||||||||||||||||||||||||| -->
    
       
    <xsl:template match="t:titleStmt">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:apply-templates/>
            <xsl:text disable-output-escaping="yes">   </xsl:text>
            <editor xml:id="GB" role="translation (English); encoding; scripting">Gabriel Bodard</editor>
            <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
            <editor xml:id="UG" role="translation (Arabic)">Usama Gad</editor>
            <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
            <xsl:comment><xsl:text disable-output-escaping="yes">&lt;editor xml:id="SV" role="translation (English)">Scott Vanderbilt&lt;/editor></xsl:text></xsl:comment>
            <xsl:text disable-output-escaping="yes">&#13;          </xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:publicationStmt">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
            <publisher>Society for Libyan Studies</publisher>
            <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
            <distributor>King’s College London</distributor>
            <xsl:apply-templates/>
            <availability>
                <xsl:text disable-output-escaping="yes">&#13;              </xsl:text>
                <p>Creative Commons licence Attribution 4.0 (<ref>http://creativecommons.org/licenses/by/4.0/</ref>). All reuse or distribution of this work must link back to the URL <ref>http://irt.kcl.ac.uk/</ref></p>
                <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
            </availability>
            <xsl:text disable-output-escaping="yes">&#13;         </xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:idno[@type='filename']">
        <idno type="filename"><xsl:value-of select="$irtno"/></idno>
        <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
        <idno type="hgv"><xsl:value-of select="."/></idno>
    </xsl:template>
    
    <xsl:template match="t:msIdentifier">
        <msIdentifier>
            <repository ref="institution.xml#db1098">Tripoli National Museum</repository>
            <idno><xsl:text> </xsl:text></idno>
        </msIdentifier>
    </xsl:template>
    
    <xsl:template match="t:origPlace">
        <xsl:copy>
            <xsl:text>Unknown.</xsl:text>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:origDate">
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:attribute name="evidence">
                <xsl:choose>
                    <xsl:when test="contains(@notBefore,'-') or contains(@notAfter,'-')">internal</xsl:when>
                    <xsl:otherwise>context</xsl:otherwise>
                </xsl:choose>
            </xsl:attribute>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:provenance[@type='located']">
        <provenance type="found">
            <p><placeName type="ancientFindspot" ref="https://www.slsgazetteer.org/658">Bu Njem</placeName>: <placeName type="monuList" ref="https://www.slsgazetteer.org/826">Fort</placeName>.</p>
        </provenance>
        <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
        <provenance type="observed">
            <p><placeName type="monuList" ref="https://www.slsgazetteer.org/1098">Tripoli National Museum</placeName>.</p>
        </provenance>
    </xsl:template>
    
    <xsl:template match="t:objectDesc">
        <xsl:copy>
            <supportDesc>
             <support><p><material>Ceramic</material><xsl:text> </xsl:text><objectType>ostrakon</objectType>.</p></support>
         </supportDesc>
         <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
         <layoutDesc>
             <layout><rs type="execution" key="pictura">Painted</rs> on one face.</layout>
         </layoutDesc>
        </xsl:copy>
        <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
            <handDesc><handNote></handNote></handDesc>
    </xsl:template>
    
    <xsl:template match="t:encodingDesc">
        <encodingDesc>
            <p>Marked-up according to the EpiDoc Guidelines version 9.</p>
        </encodingDesc>
    </xsl:template>
    
    <xsl:template match="t:textClass">
        <xsl:copy>
           <xsl:copy-of select="@*"/>
           <xsl:apply-templates/>
        </xsl:copy>
        <xsl:text disable-output-escaping="yes">&#13;         </xsl:text>
        <textClass>
            <keywords scheme="IRCyr">
                <term>
                    <geogName type="ancientRegion" key="Tripolitania">Tripolitania</geogName>
                </term>
                <term>
                    <geogName type="modernCountry" key="LY">Libya</geogName>
                </term>
                <term>
                    <placeName type="modernFindspot" ref="https://www.slsgazetteer.org/658">Bu Njem</placeName>
                </term>
                <term><ref type="pleiades" target="https://pleiades.stoa.org/places/344377">Gholaia</ref></term>
                <term><ref type="geonames" target="https://www.geonames.org/2220431">Qaryat Bū Nujaym</ref></term>
                <term><placeName xml:lang="ar">بو نجيم</placeName></term>
            </keywords>
        </textClass>
    </xsl:template>
    
    <xsl:template match="t:body">
        <xsl:variable name="hgvno" select="//t:idno[@type='filename']"/>
        <xsl:variable name="ddbno" select="//t:idno[@type='ddb-filename']"/>
        <xsl:copy>
            <xsl:copy-of select="@*"/>
            <xsl:if test="doc-available(concat('../ddbdp/',$ddbno,'.xml'))">
                <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
                <xsl:apply-templates select="document(concat('../ddbdp/',$ddbno,'.xml'))//t:div[@type='edition']"/>
            </xsl:if>
            <!--<xsl:if test="doc-available(concat('../translation/',$hgvno,'.xml'))">
                <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
                <xsl:apply-templates select="document(concat('../translation/',$hgvno,'.xml'))//t:div[@type='translation']"/>
            </xsl:if>-->
            <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
            <xsl:apply-templates/>
        </xsl:copy>
    </xsl:template>
    
    <xsl:template match="t:expan/text()">
        <abbr><xsl:value-of select="."/></abbr>
    </xsl:template>
    
    <xsl:template match="t:div[@type='bibliography'][@subtype='illustrations']"/>
    
    <xsl:template match="t:div[@type='bibliography'][@subtype='principalEdition']">
        <div type="bibliography">
            <xsl:text disable-output-escaping="yes">&#13;            </xsl:text>
            <p><xsl:apply-templates select="t:listBibl/t:bibl"/></p>
        </div>
    </xsl:template>
    
    <xsl:template match="t:bibl">
        <xsl:copy>
            <ptr target="OBuNjem"/>
            <xsl:text> </xsl:text>
            <xsl:apply-templates select="t:biblScope"/>
        </xsl:copy><xsl:text>; from which </xsl:text>
        <bibl><title>Heidelberger Gesamtverzeichnis</title><xsl:text> </xsl:text><citedRange><xsl:value-of select="//t:idno[@type='filename']"/></citedRange></bibl><xsl:text>, </xsl:text>
        <bibl><title>Duke Databank of Documentary Papyri</title><xsl:text> </xsl:text><citedRange><xsl:value-of select="//t:idno[@type='ddb-filename']"/></citedRange></bibl>.
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