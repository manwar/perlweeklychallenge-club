<?xml version="1.0"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

<xsl:output omit-xml-declaration="yes"/>

<xsl:template match="/matrix">
    <xsl:apply-templates select="row"/>
</xsl:template>

<xsl:template match="row">
    <xsl:apply-templates select="item"/>
</xsl:template>

<!-- catch 'O's -->
<xsl:template match="item"/>

<xsl:template match="item[text() = 'X']">
    <xsl:variable name="row" select="count(../preceding-sibling::*) + 1"/> <!-- position of parent -->
    <xsl:variable name="col" select="position()"/>

    <xsl:variable name="lonely" select="
        (not(/matrix/row[$row    ]/item[$col - 1]) or /matrix/row[$row    ]/item[$col - 1] = 'O') and
        (not(/matrix/row[$row    ]/item[$col + 1]) or /matrix/row[$row    ]/item[$col + 1] = 'O') and
        (not(/matrix/row[$row + 1]/item[$col    ]) or /matrix/row[$row + 1]/item[$col    ] = 'O') and
        (not(/matrix/row[$row - 1]/item[$col    ]) or /matrix/row[$row - 1]/item[$col    ] = 'O') and
        (not(/matrix/row[$row + 1]/item[$col + 1]) or /matrix/row[$row + 1]/item[$col + 1] = 'O') and
        (not(/matrix/row[$row - 1]/item[$col - 1]) or /matrix/row[$row - 1]/item[$col - 1] = 'O') and
        (not(/matrix/row[$row + 1]/item[$col - 1]) or /matrix/row[$row + 1]/item[$col - 1] = 'O') and
        (not(/matrix/row[$row - 1]/item[$col + 1]) or /matrix/row[$row - 1]/item[$col + 1] = 'O')
    "/>

    <xsl:if test="$lonely">
        <xsl:value-of select="$row"/>
        <xsl:text>, </xsl:text>
        <xsl:value-of select="$col"/>
        <xsl:text disable-output-escaping="yes">&#10;</xsl:text>
    </xsl:if>
</xsl:template>

</xsl:stylesheet>
