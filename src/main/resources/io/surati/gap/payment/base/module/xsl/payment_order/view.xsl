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
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:sec="http://www.surati.io/Security/User/Profile" version="2.0">
  <xsl:output method="html" include-content-type="no" doctype-system="about:legacy-compat" encoding="UTF-8" indent="yes"/>
  <xsl:include href="/io/surati/gap/web/base/xsl/layout.xsl"/>
  <xsl:template match="page" mode="head">
    <title>
      <xsl:text> GAP - Ordre de paiement </xsl:text>
    </title>
  </xsl:template>
  <xsl:template match="page" mode="header">
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
                  <li class="active breadcrumb-item" aria-current="page">
                      Visualiser un ordre de paiement
                  </li>
                </ol>
              </nav>
            </div>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="page" mode="body">
    <div class="main-card mb-3 card">
      <div class="card">
        <div class="card-body">
          <div class="row">
            <div class="col-md-12 mb-3">
              <div class="card-header">
                <div class="card-header-title font-size-lg text-capitalize font-weight-normal">
                  <xsl:text>Ordre de paiement</xsl:text>
                </div>
              </div>
            </div>
            <div class="col-md-3">
              <h5>
                <xsl:text>Date</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/date_view"/>
              </p>
            </div>
            <div class="col-md-3">
              <h5>
                <xsl:text>Référence</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/reference"/>
              </p>
            </div>
            <div class="col-md-3">
              <h5>
                <xsl:text>Montant à payer</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/amount_to_pay_in_human"/>
              </p>
            </div>
            <div class="col-md-3">
              <h5>
                <xsl:text>Bénéficiaire</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/beneficiary"/>
              </p>
            </div>
            <div class="col-md-6">
              <h5>
                <xsl:text>Motif de règlement</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/reason"/>
              </p>
            </div>
            <div class="col-md-6">
              <h5>
                <xsl:text>Description</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/description"/>
              </p>
            </div>
            <div class="col-md-12">
              <h5>
                <xsl:text>Etat</xsl:text>
              </h5>
              <p class="badge badge-primary">
                <xsl:value-of select="item/status"/>
              </p>
            </div>
            <xsl:if test="item/ref_doc_id">
              <div class="col-md-12 mb-3">
                <div class="card-header">
                  <div class="card-header-title font-size-lg text-capitalize font-weight-normal">
                    <xsl:text>Facture associée</xsl:text>
                  </div>
                </div>
              </div>
              <div class="col-md-3">
                <h5>
                  <xsl:text>Document de référence</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/ref_doc_name"/>
                </p>
              </div>
              <div class="col-md-3">
                <h5>
                  <xsl:text>Montant du document</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/ref_doc_amount_in_human"/>
                </p>
              </div>
              <div class="col-md-3">
                <h5>
                  <xsl:text>Date et lieu d'édition du document</xsl:text>
                </h5>
                <p><xsl:value-of select="item/ref_doc_date_view"/> à <xsl:value-of select="item/ref_doc_place"/></p>
              </div>
              <div class="col-md-3">
                <h5>
                  <xsl:text>Date de dépôt du document</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/ref_doc_deposit_date_view"/>
                </p>
              </div>
              <div class="col-md-3">
                <h5>
                  <xsl:text>Date de saisie du document</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/ref_doc_entry_date_view"/>
                </p>
              </div>
              <div class="col-md-6">
                <h5>
                  <xsl:text>Objet du document</xsl:text>
                </h5>
                <p>
                  <xsl:value-of select="item/ref_doc_object"/>
                </p>
              </div>
            </xsl:if>
          </div>
          <div class="divider"/>
          <div class="clearfix">
            <a href="{root_page/uri}" class="btn-shadow float-right btn-wide btn-pill btn btn-outline-secondary">
              <xsl:text>Retourner </xsl:text>
              <i class="fa fa-arrow-left"/>
            </a>
            <xsl:if test="sec:hasAccess(.,'PREPARER_ORDRES_PAIEMENT') and item/status_id = 'TO_PREPARE'">
              <a href="/payment-order/edit?{root_page/full}" class="btn-shadow btn-wide float-right btn-pill mr-1 btn-hover-shine btn btn-success">
                <xsl:text>Nouveau </xsl:text>
                <i class="fa fa-file"/>
              </a>
            </xsl:if>
            <xsl:if test="sec:hasAccess(.,'PREPARER_ORDRES_PAIEMENT')">
              <a href="/payment-order/delete?id={item/id}&amp;{root_page/full}" class="btn-shadow btn-wide float-right mr-1 btn-pill btn-hover-shine btn btn-danger" onclick="return confirm('Voulez-vous supprimer cet ordre de paiement ?');">
                <xsl:text>Supprimer </xsl:text>
                <i class="fa fa-trash"/>
              </a>
            </xsl:if>
            <xsl:if test="item/status_id = 'TO_PREPARE'">
              <a href="/payment-order/edit?id={item/id}&amp;{root_page/full}" class="btn-shadow btn-wide float-right btn-pill mr-1 btn-hover-shine btn btn-primary">
                <xsl:text>Modifier </xsl:text>
                <i class="fa fa-edit"/>
              </a>
            </xsl:if>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="page" mode="custom-script"/>
</xsl:stylesheet>
