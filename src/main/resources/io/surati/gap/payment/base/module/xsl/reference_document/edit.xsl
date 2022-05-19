<?xml version="1.0" encoding="UTF-8"?>
<!--
Copyright (c) 2022 Surati

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to read
the Software only. Permissions is hereby NOT GRANTED to use, copy, modify,
merge, publish, distribute, sublicense, and/or sell copies of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NON-INFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
-->
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
  <xsl:output method="html" include-content-type="no" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes"/>
  <xsl:include href="/io/surati/gap/web/base/xsl/layout.xsl"/>
  <xsl:template match="page" mode="head">
    <title><xsl:text>GAP</xsl:text> - <xsl:value-of select="root_page/title"/> - Editer document de référence
      <link rel="stylesheet" href="/css/select2.css"/>
      <link rel="stylesheet" href="/css/select2-bootstrap4.css"/>
    </title>
  </xsl:template>
  <xsl:template match="page" mode="header">
    <xsl:variable name="is_new" select="not(item/id)"/>
    <div class="app-page-title app-page-title-simple">
      <div class="page-title-wrapper">
        <div class="page-title-heading">
          <div class="page-title-icon">
            <i class="lnr-inbox icon-gradient bg-night-fade"/>
          </div>
          <div>
            <xsl:value-of select="root_page/title"/>
            <div class="page-title-subheading opacity-10">
              <nav class="" aria-label="breadcrumb">
                <ol class="breadcrumb">
                  <li class="breadcrumb-item">
                    <a href="/home">
                      <i aria-hidden="true" class="fa fa-home"/>
                    </a>
                  </li>
                  <li class="breadcrumb-item">
                    <a href="{root_page/uri}">
                      <xsl:value-of select="root_page/subtitle"/>
                    </a>
                  </li>
                  <xsl:choose>
                    <xsl:when test="$is_new">
                      <li class="active breadcrumb-item" aria-current="page">
                        <xsl:text>Créer un document de référence</xsl:text>
                      </li>
                    </xsl:when>
                    <xsl:otherwise>
                      <li class="active breadcrumb-item" aria-current="page">
                        <xsl:text>Modifier un document de référence</xsl:text>
                      </li>
                    </xsl:otherwise>
                  </xsl:choose>
                </ol>
              </nav>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="page" mode="body">
    <xsl:variable name="is_new" select="not(item/id)"/>
    <div class="main-card mb-3 card">
      <div class="card">
        <div class="card-body">
          <form action="/reference-document/save?{root_page/full}" method="post">
            <xsl:if test="not($is_new)">
              <input name="id" type="hidden" value="{item/id}"/>
            </xsl:if>
            <div class="form-row">
              <div class="col-md-6">
                <div class="position-relative form-group">
                  <label for="beneficiary_id" class="">
                    <xsl:text>Bénéficiaire</xsl:text>
                    <span style="color: red"> *</span>
                  </label>
                  <select name="beneficiary_id" class="form-control" data-placeholder="Rechercher bénéficiaire par nom, abrégé..." required="">
                    <option value=""/>
                    <xsl:for-each select="third_parties/third_party">
                      <option value="{id}">
                        <xsl:if test="not($is_new) and id = ../../item/beneficiary_id">
                          <xsl:attribute name="selected">selected</xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="name"/>
                      </option>
                    </xsl:for-each>
                  </select>
                </div>
              </div>
              <div class="col-md-3">
                <div class="position-relative form-group">
                  <label for="type_id" class="">
                    <xsl:text>Type de document</xsl:text>
                    <span style="color: red"> *</span>
                  </label>
                  <select id="type_id" name="type_id" class="form-control" required="">
                    <option value="">-- SVP choisir un type --</option>
                    <xsl:for-each select="reference_document_types/reference_document_type">
                      <option value="{id}">
                        <xsl:if test="not($is_new) and id = ../../item/type_id">
                          <xsl:attribute name="selected">selected</xsl:attribute>
                        </xsl:if>
                        <xsl:if test="$is_new and id = ../../default_reference_document_type_id">
                          <xsl:attribute name="selected">selected</xsl:attribute>
                        </xsl:if>
                        <xsl:value-of select="name"/>
                      </option>
                    </xsl:for-each>
                  </select>
                </div>
              </div>
              <div class="col-md-3">
                <div class="position-relative form-group">
                  <label for="reference">
                    <xsl:text>Référence</xsl:text>
                    <span style="color: red"> *</span>
                  </label>
                  <input name="reference" id="reference" value="{item/reference}" placeholder="Entrez une reference..." type="text" class="form-control" required=""/>
                </div>
              </div>
              <div class="col-md-3">
                <div class="position-relative form-group">
                  <label for="amount">
                    <xsl:text>Montant</xsl:text>
                    <span style="color: red"> *</span>
                  </label>
                  <input name="amount" id="amount" value="{item/amount}" placeholder="Entrez un montant ..." type="number" class="form-control" required=""/>
                </div>
              </div>
              <div class="col-md-4">
                <div class="position-relative form-group">
                  <label for="advanced_amount">
                    <xsl:text>Montant payé antérieurement (avant import)</xsl:text>
                    <span style="color: red"> *</span>
                  </label>
                  <input name="advanced_amount" id="advanced_amount" value="{item/advanced_amount}" placeholder="Entrez un montant..." type="number" class="form-control" required="">
                    <xsl:if test="$is_new">
                      <xsl:attribute name="value">0</xsl:attribute>
                    </xsl:if>
                  </input>
                </div>
              </div>
              <div class="col-md-9">
                <div class="position-relative form-group">
                  <label for="object">
                    <xsl:text>Objet</xsl:text>
                    <span style="color: red"> *</span>
                  </label>
                  <input name="object" id="object" value="{item/object}" placeholder="Entrez un objet ..." type="text" class="form-control" required=""/>
                </div>
              </div>
              <div class="col-md-3">
                <div class="position-relative form-group">
                  <label for="date">
                    <xsl:text>Date d'édition</xsl:text>
                    <span style="color: red"> *</span>
                  </label>
                  <div class="input-group">
                    <input name="date" id="date" value="{item/date}" placeholder="Entrez une date ..." type="date" class="form-control" required=""/>
                    <div class="input-group-append">
                      <button onclick="document.getElementById('date').value = ''" class="btn btn-outline-secondary" type="button">X</button>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-3">
                <div class="position-relative form-group">
                  <label for="place">
                    <xsl:text>Lieu d'édition</xsl:text>
                    <span style="color: red"> *</span>
                  </label>
                  <input name="place" id="place" value="{item/place}" placeholder="Entrez un lieu ..." type="text" class="form-control" required=""/>
                </div>
              </div>
              <div class="col-md-3">
                <div class="position-relative form-group">
                  <label for="deposit_date">
                    <xsl:text>Date de dépôt</xsl:text>
                  </label>
                  <div class="input-group">
                    <input name="deposit_date" id="deposit_date" value="{item/deposit_date}" type="date" class="form-control"/>
                    <div class="input-group-append">
                      <button onclick="document.getElementById('deposit_date').value = ''" class="btn btn-outline-secondary" type="button">X</button>
                    </div>
                  </div>
                </div>
              </div>
              <div class="col-md-3">
                <div class="position-relative form-group">
                  <label for="entry_date">
                    <xsl:text>Date de saisie</xsl:text>
                    <span style="color: red"> *</span>
                  </label>
                  <div class="input-group">
                    <xsl:choose>
                      <xsl:when test="$is_new">
                        <input name="entry_date" id="entry_date" value="{today}" type="date" class="form-control" required=""/>
                      </xsl:when>
                      <xsl:otherwise>
                        <input name="entry_date" id="entry_date" value="{item/entry_date}" type="date" class="form-control" required=""/>
                      </xsl:otherwise>
                    </xsl:choose>
                    <div class="input-group-append">
                      <button onclick="document.getElementById('entry_date').value = ''" class="btn btn-outline-secondary" type="button">X</button>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div class="divider"/>
            <div class="clearfix">
              <button type="submit" class="btn-shadow btn-wide float-right btn-pill btn-hover-shine btn btn-primary">
                <xsl:choose>
                  <xsl:when test="$is_new">
                    <xsl:text>Créer </xsl:text>
                  </xsl:when>
                  <xsl:otherwise>
                    <xsl:text>Modifier </xsl:text>
                  </xsl:otherwise>
                </xsl:choose>
                <i class="fa fa-check"/>
              </button>
              <xsl:choose>
                <xsl:when test="$is_new">
                  <a href="{root_page/uri}" class="btn-shadow float-right btn-wide btn-pill mr-1 btn btn-outline-secondary">
                    <xsl:text>Annuler </xsl:text>
                    <i class="fa fa-undo"/>
                  </a>
                </xsl:when>
                <xsl:otherwise>
                  <a href="/reference-document/view?id={item/id}&amp;{root_page/full}" class="btn-shadow float-right btn-wide btn-pill mr-1 btn btn-outline-secondary">
                    <xsl:text>Annuler </xsl:text>
                    <i class="fa fa-undo"/>
                  </a>
                </xsl:otherwise>
              </xsl:choose>
            </div>
          </form>
        </div>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="page" mode="custom-script">
    <script src="/io/surati/gap/web/base/js/select2.js"/>
    <script type="text/javascript"><![CDATA[
    	  $('select').select2({
		    theme: 'bootstrap4',
		});			
        ]]></script>
  </xsl:template>
</xsl:stylesheet>
