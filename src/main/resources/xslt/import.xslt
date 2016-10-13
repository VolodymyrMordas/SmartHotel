<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
                xmlns="http://www.w3.org/1999/xhtml"
                xmlns:java="java">
    <xsl:output method="xml" indent="yes"
                doctype-public="-//W3C//DTD XHTML 1.0 Strict//EN"
                doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd"/>
    <!--XHTML document outline-->
    <xsl:template match="/">
        <html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
            <head>
                <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
                <title>Order List</title>
                <style type="text/css">
                    h1 {
                        padding: 10px;
                        padding-width: 100%;
                        background-color: silver
                    }

                    td, th {
                        width: 40%;
                        border: 1px solid silver;
                        padding: 10px
                    }

                    td:first-child, th:first-child {
                        width: 20%
                    }

                    table {
                        width: 650px
                    }
                </style>
            </head>
            <body>
                <xsl:apply-templates/>
            </body>
        </html>
    </xsl:template>

    <!--Table headers and outline-->
    <xsl:template match="document">
        <h1>Order list at
            <strong><xsl:value-of select="java:util.Date.new()"/></strong>
        </h1>
        <table>
            <tr>
                <th>#</th>
                <th>Code</th>
                <th>Amount</th>
                <th>Currency</th>
                <th>Date</th>
            </tr>
            <xsl:for-each select="order">
                <tr>
                    <td><xsl:value-of select="position()" /></td>
                    <td><xsl:value-of select="code"/></td>
                    <td><xsl:value-of select="amount" /></td>
                    <td><xsl:value-of select="currency/abbr" />(<xsl:value-of select="currency/code" />)</td>
                    <td><xsl:value-of select="date" /></td>
                </tr>
            </xsl:for-each>
        </table>
    </xsl:template>
</xsl:stylesheet>