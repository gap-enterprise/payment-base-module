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
    <title><xsl:text>GAP</xsl:text> - <xsl:value-of select="root_page/title"/> - <xsl:value-of select="root_page/subtitle"/>
    </title>
  </xsl:template>
  <xsl:template match="page" mode="header">
    <div class="app-page-title app-page-title-simple">
      <div class="page-title-wrapper">
        <div class="page-title-heading">
          <div class="page-title-icon">
            <i class="lnr-briefcase icon-gradient bg-night-fade"/>
          </div>
          <div>
            <xsl:value-of select="root_page/title"/>
            <div class="page-title-subheading opacity-10">
              <nav aria-label="breadcrumb">
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
                    <xsl:text>Document de référence </xsl:text>
                    <xsl:value-of select="item/reference"/>
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
                <xsl:text>Type</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/type"/>
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
                <xsl:text>Bénéficiaire</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/beneficiary"/>
              </p>
            </div>
            <div class="col-md-3">
              <h5>
                <xsl:text>Montant total</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/amount_in_human"/>
              </p>
            </div>
            <div class="col-md-3">
              <h5>
                <xsl:text>Montant payé antérieurement (avant import)</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/advanced_amount_in_human"/>
              </p>
            </div>
            <div class="col-md-3">
              <h5>
                <xsl:text>Montant total payé</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/amount_paid_in_human"/>
              </p>
            </div>
            <div class="col-md-3">
              <h5>
                <xsl:text>Montant restant</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/amount_left_in_human"/>
              </p>
            </div>
            <div class="col-md-3">
              <h5>
                <xsl:text>Objet</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/object"/>
              </p>
            </div>
            <div class="col-md-3">
              <h5>
                <xsl:text>Lieu</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/place"/>
              </p>
            </div>
            <div class="col-md-3">
              <h5>
                <xsl:text>Date de dépôt</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/deposit_date_view"/>
              </p>
            </div>
            <div class="col-md-3">
              <h5>
                <xsl:text>Date de saisie</xsl:text>
              </h5>
              <p>
                <xsl:value-of select="item/entry_date_view"/>
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
          </div>
          <div class="row">
            <div class="col-md-12">
              <div class="card-header">
                <div class="card-header-title font-size-lg text-capitalize font-weight-normal">
                  <xsl:text>Paiements</xsl:text>
                </div>
              </div>
              <xsl:if test="payments[not(payment)]">
                <h6 class="text-center pb-1 pt-1">
                  <xsl:text>Il n'y a aucun paiement.</xsl:text>
                </h6>
              </xsl:if>
              <xsl:if test="payments[payment]">
                <div class="table-responsive">
                  <table class=" mb-0 table table-hover table-sm">
                    <thead>
                      <tr>
                        <th>N°</th>
                        <th>Date</th>
                        <th>Référence</th>
                        <th>Bénéficiaire</th>
                        <th>Montant</th>
                        <th>Formule</th>
                        <th>Statut</th>
                        <th>Actions</th>
                      </tr>
                    </thead>
                    <tbody>
                      <xsl:for-each select="payments/payment">
                        <tr>
                          <td>
                            <xsl:value-of select="position()"/>
                          </td>
                          <td>
                            <xsl:value-of select="date_view"/>
                          </td>
                          <td>
                            <xsl:value-of select="reference"/>
                          </td>
                          <td>
                            <xsl:value-of select="beneficiary"/>
                          </td>
                          <td>
                            <xsl:value-of select="amount_in_human"/>
                          </td>
                          <td>
                            <xsl:value-of select="note"/>
                          </td>
                          <td>
                            <xsl:value-of select="status"/>
                          </td>
                          <td>
                            <xsl:if test="../../sec:hasAccess(.,'VISUALISER_PAIEMENTS')">
                              <div role="group">
                                <a href="/payment/view?id={id}&amp;{../../current_page/full}" class="mb-2 mr-2 btn btn-sm btn-outline-primary">
                                  <i class="fa fa-eye"/>
                                </a>
                              </div>
                            </xsl:if>
                          </td>
                        </tr>
                      </xsl:for-each>
                    </tbody>
                  </table>
                </div>
              </xsl:if>
            </div>
          </div>
          <div class="row">
            <div class="col-md-12">
              <div class="card-header">
                <div class="card-header-title font-size-lg text-capitalize font-weight-normal p-b-1">
                  <xsl:text>Données compte de gestion </xsl:text>
                </div>
              </div>
              <div class="row p-t-1">
                <xsl:if test="refdata/document_id">
                  <div class="col-md-3">
                    <h5>
                      <xsl:text>Section</xsl:text>
                    </h5>
                    <p>
                      <xsl:value-of select="refdata/section"/>
                    </p>
                  </div>
                  <div class="col-md-3">
                    <h5>
                      <xsl:text>Titre</xsl:text>
                    </h5>
                    <p>
                      <xsl:value-of select="refdata/title"/>
                    </p>
                  </div>
                  <div class="col-md-3">
                    <h5>
                      <xsl:text>Liasse</xsl:text>
                    </h5>
                    <p>
                      <xsl:value-of select="refdata/bundle"/>
                    </p>
                  </div>
                  <div class="col-md-3">
                    <h5>
                      <xsl:text>Imputation</xsl:text>
                    </h5>
                    <p>
                      <xsl:value-of select="refdata/imputation"/>
                    </p>
                  </div>
                </xsl:if>
              </div>
            </div>
          </div>
          <div class="divider"/>
          <div class="clearfix">
            <a href="{root_page/uri}" class="btn-shadow float-right btn-wide btn-pill btn btn-outline-secondary">
              <xsl:text>Retourner </xsl:text>
              <i class="fa fa-arrow-left"/>
            </a>
            <xsl:if test="sec:hasAccess(.,'DEFINIR_DONNEES_COMPTE_GESTION_DOC_REF')">
              <a href="/reference-document/ma-data/edit?document={item/id}&amp;{root_page/full}" class="btn-shadow btn-wide float-right btn-pill mr-1 btn-hover-shine btn btn-primary">
                <xsl:text>Définir données Compte de gestion </xsl:text>
                <i class="fa fa-file"/>
              </a>
            </xsl:if>
            <xsl:if test="item/step_id='TO_TREAT'">
              <a href="/reference-document/ws-select?id={item/id}&amp;{root_page/full}" class="btn-shadow btn-wide float-right btn-pill mr-1 btn-hover-shine btn btn-primary">
                <xsl:text>Sélectionner </xsl:text>
                <i class="fa fa-file"/>
              </a>
            </xsl:if>
            <xsl:if test="sec:hasAccess(.,'EDITER_DOCUMENT_REF')">
              <xsl:if test="not(item/status_id='PAID')">
                <a href="/reference-document/edit?{root_page/full}" class="btn-shadow btn-wide float-right btn-pill mr-1 btn-hover-shine btn btn-success">
                  <xsl:text>Nouveau </xsl:text>
                  <i class="fa fa-file"/>
                </a>
                <a href="/reference-document/delete?id={item/id}&amp;{root_page/full}" class="btn-shadow btn-wide float-right mr-1 btn-pill btn-hover-shine btn btn-danger" onclick="return confirm('Voulez-vous supprimer ce document de référence ?');">
                  <xsl:text>Supprimer </xsl:text>
                  <i class="fa fa-trash"/>
                </a>
                <a href="/reference-document/edit?id={item/id}&amp;{root_page/full}" class="btn-shadow btn-wide float-right btn-pill mr-1 btn-hover-shine btn btn-primary">
                  <xsl:text>Modifier </xsl:text>
                  <i class="fa fa-edit"/>
                </a>
              </xsl:if>
            </xsl:if>
          </div>
        </div>
      </div>
    </div>
  </xsl:template>
  <xsl:template match="page" mode="custom-script"/>
</xsl:stylesheet>
