@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'EwayBill'
@Metadata.ignorePropagatedAnnotations: true
define root view entity ZCDS_EwayBill
  as select from    I_IN_ElectronicDocTransptRegn as a
    left outer join ztable_einvoice               as b on a.ElectronicDocSourceKey = b.billingdoc
    left outer join I_BillingDocumentItem as c on a.ElectronicDocSourceKey = c.BillingDocument 
    left outer join I_BillingDocument as d on c.BillingDocument = d.BillingDocument
{
  key a.ElectronicDocUUID,
  key a.ElectronicDocSourceKey     as Invoice,
      b.irn                        as Irn,
      b.ewayno                     as Ewayno,
      a.ElectronicDocCompanyCode   as CompanyCode, // not added
      a.ElectronicDocCountry       as Country, // not added
      a.ElectronicDocSourceType    as InvoiceType, // not added

      a.ElectronicDocType          as DocumentType, // not added
      a.ElectronicDocProcessStatus as Status, // not added
      a.ElectronicDocProcess, // not added
      a.ElectronicDocSequenceNmbr, // not added
      //      a.IN_ElectronicDocEWbillNmbr as Ew,
      b.ewbillcreatedate,
      //      a.IN_EDocEWbillCreateDate,
      b.ewbillcreatetime,
      b.ewbillvaliditydate,
      b.ewbillvaliditytime,
      b.transptdocnmbr,
      b.transptdocdate,
      b.transptdistanceval,
      b.rmngtransptdistanceval,
      b.vehiclenumber              as VehicleNumber,
      b.vehicletype,
      b.fromplacetxt,
      b.fromstate,
      b.transptmode,
      b.ewbillmodifreasoncode,
      b.ewbillmodifremarkstxt,
      b.transptrupdtdate,
      b.ewbillupdtdate,
      b.ewbillupdttime,
      b.ewbillvaldtyextnrsncode,
      b.ewbillvaldtyextnremarkstxt,
      b.ewbillcancrsncode,
      b.ewbillcanceldate,
      b.ewbillcanceltime,
      c.SalesDocument,
      d.SoldToParty,
      a.IN_EDocEWbillCancRemarksTxt, // not added
      a.IN_ElectronicDocIsCancFlag,  // not added
      a.IN_ElectronicDocEditActionFlag, // not added
      a.IN_ElectronicDocInvcNmbr, // not added
      a.IN_ElectronicDocBusinessPlace, // not added
      a.IN_EDocEWbillIsContingencyFlag, // not added
      b.transptrname,
      b.transptrgstin,
      a.IN_EDocEWbillCtptyRejectStatus, // not added
      a.IN_ElectronicDocCsgnmtStatus, // not added
      b.transittype,
      b.ewbillfrompincode,
      a.IN_EDocEWbillExtnAddrLine1Txt, // not added
      a.IN_EDocEWbillExtnAddrLine2Txt, // not added
      a.IN_EDocEWbillExtnAddrLine3Txt, // not added
      a.IN_EDocEWbillIsMultiVehFlag, // not added
      a.IN_ElectronicDocSubSupplyDesc // not added
}
