CLASS zcl_einvoice_payload DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_oo_adt_classrun.
    CLASS-METHODS get_payload
      IMPORTING bill_doc      TYPE string
      RETURNING VALUE(result) TYPE string.

  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_EINVOICE_PAYLOAD IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
    TYPES: BEGIN OF ty_trandtls,
             taxsch      TYPE string,
             suptyp      TYPE string,
             regrev      TYPE string,
             ecmgstin    TYPE string,
             igstonintra TYPE string,
           END OF ty_trandtls.

    TYPES: BEGIN OF ty_docdtls,
             typ TYPE string,
             no  TYPE string,
             dt  TYPE string,
           END OF ty_docdtls.

    TYPES: BEGIN OF ty_sellerdtls,
             gstin TYPE string,
             lglnm TYPE string,
             trdnm TYPE string,
             addr1 TYPE string,
             addr2 TYPE string,
             loc   TYPE string,
             pin   TYPE i,
             stcd  TYPE string,
             ph    TYPE string,
             em    TYPE string,
           END OF ty_sellerdtls.

    TYPES: BEGIN OF ty_buyerdtls,
             gstin TYPE string,
             lglnm TYPE string,
             trdnm TYPE string,
             pos   TYPE string,
             addr1 TYPE string,
             addr2 TYPE string,
             loc   TYPE string,
             pin   TYPE i,
             stcd  TYPE string,
             ph    TYPE string,
             em    TYPE string,
           END OF ty_buyerdtls.

    TYPES: BEGIN OF ty_dispdtls,
             nm    TYPE string,
             addr1 TYPE string,
             addr2 TYPE string,
             loc   TYPE string,
             pin   TYPE i,
             stcd  TYPE string,
           END OF ty_dispdtls.

    TYPES: BEGIN OF ty_shipdtls,
             gstin TYPE string,
             lglnm TYPE string,
             trdnm TYPE string,
             addr1 TYPE string,
             addr2 TYPE string,
             loc   TYPE string,
             pin   TYPE i,
             stcd  TYPE string,
           END OF ty_shipdtls.

    TYPES: BEGIN OF ty_item,
             slno       TYPE string,
             prddesc    TYPE string,
             isservc    TYPE string,
             hsncd      TYPE string,
             barcde     TYPE string,
             qty        TYPE p LENGTH 10 DECIMALS 2,
             freeqty    TYPE p LENGTH 10 DECIMALS 2,
             unit       TYPE string,
             unitprice  TYPE p LENGTH 10 DECIMALS 2,
             totamt     TYPE p LENGTH 10 DECIMALS 2,
             discount   TYPE p LENGTH 10 DECIMALS 2,
             pretaxval  TYPE p LENGTH 10 DECIMALS 2,
             assamt     TYPE p LENGTH 10 DECIMALS 2,
             gstrt      TYPE p LENGTH 5 DECIMALS 2,
             igstamt    TYPE p LENGTH 10 DECIMALS 2,
             cgstamt    TYPE p LENGTH 10 DECIMALS 2,
             sgstamt    TYPE p LENGTH 10 DECIMALS 2,
             cesrt      TYPE p LENGTH 5 DECIMALS 2,
             cesamt     TYPE p LENGTH 10 DECIMALS 2,
             othchrg    TYPE p LENGTH 10 DECIMALS 2,
             totitemval TYPE p LENGTH 10 DECIMALS 2,
           END OF ty_item.

    TYPES tt_item TYPE STANDARD TABLE OF ty_item WITH EMPTY KEY.

    TYPES: BEGIN OF ty_valdtls,
             assval    TYPE p LENGTH 10 DECIMALS 2,
             cgstval   TYPE p LENGTH 10 DECIMALS 2,
             sgstval   TYPE p LENGTH 10 DECIMALS 2,
             igstval   TYPE p LENGTH 10 DECIMALS 2,
             cesval    TYPE p LENGTH 10 DECIMALS 2,
             stcesval  TYPE p LENGTH 10 DECIMALS 2,
             discount  TYPE p LENGTH 10 DECIMALS 2,
             othchrg   TYPE p LENGTH 10 DECIMALS 2,
             rndoffamt TYPE p LENGTH 10 DECIMALS 2,
             totinvval TYPE p LENGTH 10 DECIMALS 2,
           END OF ty_valdtls.

    TYPES: BEGIN OF ty_main,
             version     TYPE string,
             trandtls    TYPE ty_trandtls,
             docdtls     TYPE ty_docdtls,
             sellerdtls  TYPE ty_sellerdtls,
             buyerdtls   TYPE ty_buyerdtls,
             dispdtls    TYPE ty_dispdtls,
             shipdtls    TYPE ty_shipdtls,
             itemlist    TYPE tt_item,
             valdtls     TYPE ty_valdtls,
             paydtls     TYPE string,
             refdtls     TYPE string,
             addldocdtls TYPE string,
             expdtls     TYPE string,
             ewbdtls     TYPE string,
           END OF ty_main.


    DATA: ls_main TYPE ty_main,
          ls_item TYPE ty_item,
          lv_json TYPE string.

*-------------------------
* Fill Header Data
*-------------------------

    ls_main-version = '1.01'.

    ls_main-trandtls-taxsch = 'GST'.
    ls_main-trandtls-suptyp = 'B2B'.
    ls_main-trandtls-regrev = 'N'.

    ls_main-docdtls-typ = 'INV'.
    ls_main-docdtls-no  = '90021296'.
    ls_main-docdtls-dt  = '28/02/2026'.

*-------------------------
* Seller
*-------------------------

    ls_main-sellerdtls-gstin = '21AAICS5549M1ZZ'.
    ls_main-sellerdtls-lglnm = 'SEVEN STAR STEELS LIMITED'.
    ls_main-sellerdtls-trdnm = 'SEVEN STAR STEELS LIMITED'.
    ls_main-sellerdtls-addr1 = 'Kelendamal, P.O-Gudigaon, Odisha'.
    ls_main-sellerdtls-loc   = 'Jharsugra'.
    ls_main-sellerdtls-pin   = 768202.
    ls_main-sellerdtls-stcd  = '21'.

*-------------------------
* Buyer
*-------------------------

    ls_main-buyerdtls-gstin = '21AABCP9346E1ZN'.
    ls_main-buyerdtls-lglnm = 'PENGUIN TRADING AND AGENCY LTDBSPL'.
    ls_main-buyerdtls-trdnm = 'PENGUIN TRADING AND AGENCY LTDBSPL'.
    ls_main-buyerdtls-pos   = '21'.
    ls_main-buyerdtls-addr1 = 'PLOT NO-05 IDCO GROWTH CENTRE BADMAL'.
    ls_main-buyerdtls-loc   = 'JHARSUGUDA'.
    ls_main-buyerdtls-pin   = 768202.
    ls_main-buyerdtls-stcd  = '21'.

*-------------------------
* Item
*-------------------------

    ls_item-slno      = '10'.
    ls_item-prddesc   = 'Auction Coal Fines 0 - 8'.
    ls_item-isservc   = 'N'.
    ls_item-hsncd     = '27011200'.
    ls_item-qty       = '30.14'.
    ls_item-unit      = 'MTS'.
    ls_item-unitprice = '2000'.
    ls_item-totamt    = '60280'.
    ls_item-assamt    = '60280'.
    ls_item-gstrt     = '18'.
    ls_item-cgstamt   = '5425.2'.
    ls_item-sgstamt   = '5425.2'.
    ls_item-totitemval = '71130.4'.

    APPEND ls_item TO ls_main-itemlist.

*-------------------------
* Value Details
*-------------------------

    ls_main-valdtls-assval    = '60280'.
    ls_main-valdtls-cgstval   = '5425.2'.
    ls_main-valdtls-sgstval   = '5425.2'.
    ls_main-valdtls-totinvval = '71130.4'.

*-------------------------
* Serialize JSON
*-------------------------

    lv_json = /ui2/cl_json=>serialize(
               data = ls_main
               pretty_name = /ui2/cl_json=>pretty_mode-none ).

*-------------------------
* Replace field names to match API
*-------------------------

    REPLACE ALL OCCURRENCES OF 'VERSION'     IN lv_json WITH 'Version'.

    REPLACE ALL OCCURRENCES OF 'TRANDTLS'    IN lv_json WITH 'TranDtls'.
    REPLACE ALL OCCURRENCES OF 'TAXSCH'      IN lv_json WITH 'TaxSch'.
    REPLACE ALL OCCURRENCES OF 'SUPTYP'      IN lv_json WITH 'SupTyp'.
    REPLACE ALL OCCURRENCES OF 'REGREV'      IN lv_json WITH 'RegRev'.
    REPLACE ALL OCCURRENCES OF 'ECMGSTIN'    IN lv_json WITH 'EcmGstin'.
    REPLACE ALL OCCURRENCES OF 'IGSTONINTRA' IN lv_json WITH 'IgstOnIntra'.

    REPLACE ALL OCCURRENCES OF 'DOCDTLS'     IN lv_json WITH 'DocDtls'.
    REPLACE ALL OCCURRENCES OF 'TYP'         IN lv_json WITH 'Typ'.
    REPLACE ALL OCCURRENCES OF 'NO'          IN lv_json WITH 'No'.
    REPLACE ALL OCCURRENCES OF 'DT'          IN lv_json WITH 'Dt'.

    REPLACE ALL OCCURRENCES OF 'SELLERDTLS'  IN lv_json WITH 'SellerDtls'.
    REPLACE ALL OCCURRENCES OF 'GSTIN'       IN lv_json WITH 'Gstin'.
    REPLACE ALL OCCURRENCES OF 'LGLNM'       IN lv_json WITH 'LglNm'.
    REPLACE ALL OCCURRENCES OF 'TRDNM'       IN lv_json WITH 'TrdNm'.
    REPLACE ALL OCCURRENCES OF 'ADDR1'       IN lv_json WITH 'Addr1'.
    REPLACE ALL OCCURRENCES OF 'ADDR2'       IN lv_json WITH 'Addr2'.
    REPLACE ALL OCCURRENCES OF 'LOC'         IN lv_json WITH 'Loc'.
    REPLACE ALL OCCURRENCES OF 'PIN'         IN lv_json WITH 'Pin'.
    REPLACE ALL OCCURRENCES OF 'STCD'        IN lv_json WITH 'Stcd'.
    REPLACE ALL OCCURRENCES OF 'PH'          IN lv_json WITH 'Ph'.
    REPLACE ALL OCCURRENCES OF 'EM'          IN lv_json WITH 'Em'.

    REPLACE ALL OCCURRENCES OF 'BUYERDTLS'   IN lv_json WITH 'BuyerDtls'.
    REPLACE ALL OCCURRENCES OF 'POS'         IN lv_json WITH 'Pos'.

    REPLACE ALL OCCURRENCES OF 'DISPDTLS'    IN lv_json WITH 'DispDtls'.
    REPLACE ALL OCCURRENCES OF 'NM'          IN lv_json WITH 'Nm'.

    REPLACE ALL OCCURRENCES OF 'SHIPDTLS'    IN lv_json WITH 'ShipDtls'.

    REPLACE ALL OCCURRENCES OF 'ITEMLIST'    IN lv_json WITH 'ItemList'.
    REPLACE ALL OCCURRENCES OF 'SLNO'        IN lv_json WITH 'SlNo'.
    REPLACE ALL OCCURRENCES OF 'PRDDESC'     IN lv_json WITH 'PrdDesc'.
    REPLACE ALL OCCURRENCES OF 'ISSERVC'     IN lv_json WITH 'IsServc'.
    REPLACE ALL OCCURRENCES OF 'HSNCD'       IN lv_json WITH 'HsnCd'.
    REPLACE ALL OCCURRENCES OF 'BARCDE'      IN lv_json WITH 'Barcde'.
    REPLACE ALL OCCURRENCES OF 'QTY'         IN lv_json WITH 'Qty'.
    REPLACE ALL OCCURRENCES OF 'FREEQTY'     IN lv_json WITH 'FreeQty'.
    REPLACE ALL OCCURRENCES OF 'UNIT'        IN lv_json WITH 'Unit'.
    REPLACE ALL OCCURRENCES OF 'UNITPRICE'   IN lv_json WITH 'UnitPrice'.
    REPLACE ALL OCCURRENCES OF 'TOTAMT'      IN lv_json WITH 'TotAmt'.
    REPLACE ALL OCCURRENCES OF 'DISCOUNT'    IN lv_json WITH 'Discount'.
    REPLACE ALL OCCURRENCES OF 'PRETAXVAL'   IN lv_json WITH 'PreTaxVal'.
    REPLACE ALL OCCURRENCES OF 'ASSAMT'      IN lv_json WITH 'AssAmt'.
    REPLACE ALL OCCURRENCES OF 'GSTRT'       IN lv_json WITH 'GstRt'.
    REPLACE ALL OCCURRENCES OF 'IGSTAMT'     IN lv_json WITH 'IgstAmt'.
    REPLACE ALL OCCURRENCES OF 'CGSTAMT'     IN lv_json WITH 'CgstAmt'.
    REPLACE ALL OCCURRENCES OF 'SGSTAMT'     IN lv_json WITH 'SgstAmt'.
    REPLACE ALL OCCURRENCES OF 'CESRT'       IN lv_json WITH 'CesRt'.
    REPLACE ALL OCCURRENCES OF 'CESAMT'      IN lv_json WITH 'CesAmt'.
    REPLACE ALL OCCURRENCES OF 'OTHCHRG'     IN lv_json WITH 'OthChrg'.
    REPLACE ALL OCCURRENCES OF 'TOTITEMVAL'  IN lv_json WITH 'TotItemVal'.

    REPLACE ALL OCCURRENCES OF 'VALDTLS'     IN lv_json WITH 'ValDtls'.
    REPLACE ALL OCCURRENCES OF 'ASSVAL'      IN lv_json WITH 'AssVal'.
    REPLACE ALL OCCURRENCES OF 'CGSTVAL'     IN lv_json WITH 'CgstVal'.
    REPLACE ALL OCCURRENCES OF 'SGSTVAL'     IN lv_json WITH 'SgstVal'.
    REPLACE ALL OCCURRENCES OF 'IGSTVAL'     IN lv_json WITH 'IgstVal'.
    REPLACE ALL OCCURRENCES OF 'CESVAL'      IN lv_json WITH 'CesVal'.
    REPLACE ALL OCCURRENCES OF 'STCESVAL'    IN lv_json WITH 'StCesVal'.
    REPLACE ALL OCCURRENCES OF 'RNDOFFAMT'   IN lv_json WITH 'RndOffAmt'.
    REPLACE ALL OCCURRENCES OF 'TOTINVVAL'   IN lv_json WITH 'TotInvVal'.
  ENDMETHOD.


  METHOD get_payload.

    TYPES: BEGIN OF ty_trandtls,
             taxsch      TYPE string,
             suptyp      TYPE string,
             regrev      TYPE string,
             ecmgstin    TYPE string,
             igstonintra TYPE string,
           END OF ty_trandtls.

    TYPES: BEGIN OF ty_docdtls,
             typ TYPE string,
             no  TYPE string,
             dt  TYPE string,
           END OF ty_docdtls.

    TYPES: BEGIN OF ty_sellerdtls,
             gstin TYPE string,
             lglnm TYPE string,
             trdnm TYPE string,
             addr1 TYPE string,
             addr2 TYPE string,
             loc   TYPE string,
             pin   TYPE i,
             stcd  TYPE string,
             ph    TYPE string,
             em    TYPE string,
           END OF ty_sellerdtls.

    TYPES: BEGIN OF ty_buyerdtls,
             gstin TYPE string,
             lglnm TYPE string,
             trdnm TYPE string,
             pos   TYPE string,
             addr1 TYPE string,
             addr2 TYPE string,
             loc   TYPE string,
             pin   TYPE i,
             stcd  TYPE string,
             ph    TYPE string,
             em    TYPE string,
           END OF ty_buyerdtls.

    TYPES: BEGIN OF ty_dispdtls,
             nm    TYPE string,
             addr1 TYPE string,
             addr2 TYPE string,
             loc   TYPE string,
             pin   TYPE i,
             stcd  TYPE string,
           END OF ty_dispdtls.

    TYPES: BEGIN OF ty_shipdtls,
             gstin TYPE string,
             lglnm TYPE string,
             trdnm TYPE string,
             addr1 TYPE string,
             addr2 TYPE string,
             loc   TYPE string,
             pin   TYPE i,
             stcd  TYPE string,
           END OF ty_shipdtls.

    TYPES: BEGIN OF ty_item,
             slno       TYPE string,
             prddesc    TYPE string,
             isservc    TYPE string,
             hsncd      TYPE string,
             barcde     TYPE string,
             qty        TYPE p LENGTH 10 DECIMALS 2,
             freeqty    TYPE p LENGTH 10 DECIMALS 2,
             unit       TYPE string,
             unitprice  TYPE p LENGTH 10 DECIMALS 2,
             totamt     TYPE p LENGTH 10 DECIMALS 2,
             discount   TYPE p LENGTH 10 DECIMALS 2,
             pretaxval  TYPE p LENGTH 10 DECIMALS 2,
             assamt     TYPE p LENGTH 10 DECIMALS 2,
             gstrt      TYPE p LENGTH 5 DECIMALS 2,
             igstamt    TYPE p LENGTH 10 DECIMALS 2,
             cgstamt    TYPE p LENGTH 10 DECIMALS 2,
             sgstamt    TYPE p LENGTH 10 DECIMALS 2,
             cesrt      TYPE p LENGTH 5 DECIMALS 2,
             cesamt     TYPE p LENGTH 10 DECIMALS 2,
             othchrg    TYPE p LENGTH 10 DECIMALS 2,
             totitemval TYPE p LENGTH 10 DECIMALS 2,
           END OF ty_item.

    TYPES tt_item TYPE STANDARD TABLE OF ty_item WITH EMPTY KEY.

    TYPES: BEGIN OF ty_valdtls,
             assval    TYPE p LENGTH 10 DECIMALS 2,
             cgstval   TYPE p LENGTH 10 DECIMALS 2,
             sgstval   TYPE p LENGTH 10 DECIMALS 2,
             igstval   TYPE p LENGTH 10 DECIMALS 2,
             cesval    TYPE p LENGTH 10 DECIMALS 2,
             stcesval  TYPE p LENGTH 10 DECIMALS 2,
             discount  TYPE p LENGTH 10 DECIMALS 2,
             othchrg   TYPE p LENGTH 10 DECIMALS 2,
             rndoffamt TYPE p LENGTH 10 DECIMALS 2,
             totinvval TYPE p LENGTH 10 DECIMALS 2,
           END OF ty_valdtls.

    TYPES: BEGIN OF ty_main,
             version     TYPE string,
             trandtls    TYPE ty_trandtls,
             docdtls     TYPE ty_docdtls,
             sellerdtls  TYPE ty_sellerdtls,
             buyerdtls   TYPE ty_buyerdtls,
             dispdtls    TYPE ty_dispdtls,
             shipdtls    TYPE ty_shipdtls,
             itemlist    TYPE tt_item,
             valdtls     TYPE ty_valdtls,
             paydtls     TYPE string,
             refdtls     TYPE string,
             addldocdtls TYPE string,
             expdtls     TYPE string,
             ewbdtls     TYPE string,
           END OF ty_main.


    DATA: ls_main TYPE ty_main,
          ls_item TYPE ty_item,
          lv_json TYPE string.

*-------------------------
* Fill Header Data
*-------------------------

    ls_main-version = '1.01'.

    ls_main-trandtls-taxsch = 'GST'.
    ls_main-trandtls-suptyp = 'B2B'.
    ls_main-trandtls-regrev = 'N'.

    ls_main-docdtls-typ = 'INV'.
    ls_main-docdtls-no  = '90021296'.
    ls_main-docdtls-dt  = '28/02/2026'.

*-------------------------
* Seller
*-------------------------

    ls_main-sellerdtls-gstin = '21AAICS5549M1ZZ'.
    ls_main-sellerdtls-lglnm = 'SEVEN STAR STEELS LIMITED'.
    ls_main-sellerdtls-trdnm = 'SEVEN STAR STEELS LIMITED'.
    ls_main-sellerdtls-addr1 = 'Kelendamal, P.O-Gudigaon, Odisha'.
    ls_main-sellerdtls-loc   = 'Jharsugra'.
    ls_main-sellerdtls-pin   = 768202.
    ls_main-sellerdtls-stcd  = '21'.

*-------------------------
* Buyer
*-------------------------

    ls_main-buyerdtls-gstin = '21AABCP9346E1ZN'.
    ls_main-buyerdtls-lglnm = 'PENGUIN TRADING AND AGENCY LTDBSPL'.
    ls_main-buyerdtls-trdnm = 'PENGUIN TRADING AND AGENCY LTDBSPL'.
    ls_main-buyerdtls-pos   = '21'.
    ls_main-buyerdtls-addr1 = 'PLOT NO-05 IDCO GROWTH CENTRE BADMAL'.
    ls_main-buyerdtls-loc   = 'JHARSUGUDA'.
    ls_main-buyerdtls-pin   = 768202.
    ls_main-buyerdtls-stcd  = '21'.

*-------------------------
* Item
*-------------------------

    ls_item-slno      = '10'.
    ls_item-prddesc   = 'Auction Coal Fines 0 - 8'.
    ls_item-isservc   = 'N'.
    ls_item-hsncd     = '27011200'.
    ls_item-qty       = '30.14'.
    ls_item-unit      = 'MTS'.
    ls_item-unitprice = '2000'.
    ls_item-totamt    = '60280'.
    ls_item-assamt    = '60280'.
    ls_item-gstrt     = '18'.
    ls_item-cgstamt   = '5425.2'.
    ls_item-sgstamt   = '5425.2'.
    ls_item-totitemval = '71130.4'.

    APPEND ls_item TO ls_main-itemlist.

*-------------------------
* Value Details
*-------------------------

    ls_main-valdtls-assval    = '60280'.
    ls_main-valdtls-cgstval   = '5425.2'.
    ls_main-valdtls-sgstval   = '5425.2'.
    ls_main-valdtls-totinvval = '71130.4'.

*-------------------------
* Serialize JSON
*-------------------------

    lv_json = /ui2/cl_json=>serialize(
               data = ls_main
               pretty_name = /ui2/cl_json=>pretty_mode-none ).

*-------------------------
* Replace field names to match API
*-------------------------

    REPLACE ALL OCCURRENCES OF 'VERSION'     IN lv_json WITH 'Version'.

    REPLACE ALL OCCURRENCES OF 'TRANDTLS'    IN lv_json WITH 'TranDtls'.
    REPLACE ALL OCCURRENCES OF 'TAXSCH'      IN lv_json WITH 'TaxSch'.
    REPLACE ALL OCCURRENCES OF 'SUPTYP'      IN lv_json WITH 'SupTyp'.
    REPLACE ALL OCCURRENCES OF 'REGREV'      IN lv_json WITH 'RegRev'.
    REPLACE ALL OCCURRENCES OF 'ECMGSTIN'    IN lv_json WITH 'EcmGstin'.
    REPLACE ALL OCCURRENCES OF 'IGSTONINTRA' IN lv_json WITH 'IgstOnIntra'.

    REPLACE ALL OCCURRENCES OF 'DOCDTLS'     IN lv_json WITH 'DocDtls'.
    REPLACE ALL OCCURRENCES OF 'TYP'         IN lv_json WITH 'Typ'.
    REPLACE ALL OCCURRENCES OF 'NO'          IN lv_json WITH 'No'.
    REPLACE ALL OCCURRENCES OF 'DT'          IN lv_json WITH 'Dt'.

    REPLACE ALL OCCURRENCES OF 'SELLERDTLS'  IN lv_json WITH 'SellerDtls'.
    REPLACE ALL OCCURRENCES OF 'GSTIN'       IN lv_json WITH 'Gstin'.
    REPLACE ALL OCCURRENCES OF 'LGLNM'       IN lv_json WITH 'LglNm'.
    REPLACE ALL OCCURRENCES OF 'TRDNM'       IN lv_json WITH 'TrdNm'.
    REPLACE ALL OCCURRENCES OF 'ADDR1'       IN lv_json WITH 'Addr1'.
    REPLACE ALL OCCURRENCES OF 'ADDR2'       IN lv_json WITH 'Addr2'.
    REPLACE ALL OCCURRENCES OF 'LOC'         IN lv_json WITH 'Loc'.
    REPLACE ALL OCCURRENCES OF 'PIN'         IN lv_json WITH 'Pin'.
    REPLACE ALL OCCURRENCES OF 'STCD'        IN lv_json WITH 'Stcd'.
    REPLACE ALL OCCURRENCES OF 'PH'          IN lv_json WITH 'Ph'.
    REPLACE ALL OCCURRENCES OF 'EM'          IN lv_json WITH 'Em'.

    REPLACE ALL OCCURRENCES OF 'BUYERDTLS'   IN lv_json WITH 'BuyerDtls'.
    REPLACE ALL OCCURRENCES OF 'POS'         IN lv_json WITH 'Pos'.

    REPLACE ALL OCCURRENCES OF 'DISPDTLS'    IN lv_json WITH 'DispDtls'.
    REPLACE ALL OCCURRENCES OF 'NM'          IN lv_json WITH 'Nm'.

    REPLACE ALL OCCURRENCES OF 'SHIPDTLS'    IN lv_json WITH 'ShipDtls'.

    REPLACE ALL OCCURRENCES OF 'ITEMLIST'    IN lv_json WITH 'ItemList'.
    REPLACE ALL OCCURRENCES OF 'SLNO'        IN lv_json WITH 'SlNo'.
    REPLACE ALL OCCURRENCES OF 'PRDDESC'     IN lv_json WITH 'PrdDesc'.
    REPLACE ALL OCCURRENCES OF 'ISSERVC'     IN lv_json WITH 'IsServc'.
    REPLACE ALL OCCURRENCES OF 'HSNCD'       IN lv_json WITH 'HsnCd'.
    REPLACE ALL OCCURRENCES OF 'BARCDE'      IN lv_json WITH 'Barcde'.
    REPLACE ALL OCCURRENCES OF 'QTY'         IN lv_json WITH 'Qty'.
    REPLACE ALL OCCURRENCES OF 'FREEQTY'     IN lv_json WITH 'FreeQty'.
    REPLACE ALL OCCURRENCES OF 'UNIT'        IN lv_json WITH 'Unit'.
    REPLACE ALL OCCURRENCES OF 'UNITPRICE'   IN lv_json WITH 'UnitPrice'.
    REPLACE ALL OCCURRENCES OF 'TOTAMT'      IN lv_json WITH 'TotAmt'.
    REPLACE ALL OCCURRENCES OF 'DISCOUNT'    IN lv_json WITH 'Discount'.
    REPLACE ALL OCCURRENCES OF 'PRETAXVAL'   IN lv_json WITH 'PreTaxVal'.
    REPLACE ALL OCCURRENCES OF 'ASSAMT'      IN lv_json WITH 'AssAmt'.
    REPLACE ALL OCCURRENCES OF 'GSTRT'       IN lv_json WITH 'GstRt'.
    REPLACE ALL OCCURRENCES OF 'IGSTAMT'     IN lv_json WITH 'IgstAmt'.
    REPLACE ALL OCCURRENCES OF 'CGSTAMT'     IN lv_json WITH 'CgstAmt'.
    REPLACE ALL OCCURRENCES OF 'SGSTAMT'     IN lv_json WITH 'SgstAmt'.
    REPLACE ALL OCCURRENCES OF 'CESRT'       IN lv_json WITH 'CesRt'.
    REPLACE ALL OCCURRENCES OF 'CESAMT'      IN lv_json WITH 'CesAmt'.
    REPLACE ALL OCCURRENCES OF 'OTHCHRG'     IN lv_json WITH 'OthChrg'.
    REPLACE ALL OCCURRENCES OF 'TOTITEMVAL'  IN lv_json WITH 'TotItemVal'.

    REPLACE ALL OCCURRENCES OF 'VALDTLS'     IN lv_json WITH 'ValDtls'.
    REPLACE ALL OCCURRENCES OF 'ASSVAL'      IN lv_json WITH 'AssVal'.
    REPLACE ALL OCCURRENCES OF 'CGSTVAL'     IN lv_json WITH 'CgstVal'.
    REPLACE ALL OCCURRENCES OF 'SGSTVAL'     IN lv_json WITH 'SgstVal'.
    REPLACE ALL OCCURRENCES OF 'IGSTVAL'     IN lv_json WITH 'IgstVal'.
    REPLACE ALL OCCURRENCES OF 'CESVAL'      IN lv_json WITH 'CesVal'.
    REPLACE ALL OCCURRENCES OF 'STCESVAL'    IN lv_json WITH 'StCesVal'.
    REPLACE ALL OCCURRENCES OF 'RNDOFFAMT'   IN lv_json WITH 'RndOffAmt'.
    REPLACE ALL OCCURRENCES OF 'TOTINVVAL'   IN lv_json WITH 'TotInvVal'.


    """ extra
    REPLACE ALL OCCURRENCES OF 'SELLERDtLS'   IN lv_json WITH 'SellerDtls'.
    REPLACE ALL OCCURRENCES OF 'BUYERDtLS'   IN lv_json WITH 'BuyerDtls'.
    REPLACE ALL OCCURRENCES OF 'DISPDtLS'   IN lv_json WITH 'DispDtls'.
    REPLACE ALL OCCURRENCES OF 'SHIPDtLS'   IN lv_json WITH 'ShipDtls'.
    REPLACE ALL OCCURRENCES OF 'ITEmLIST'   IN lv_json WITH 'ItemList'.
    REPLACE ALL OCCURRENCES OF 'SLNo'   IN lv_json WITH 'SlNo'.

    result = lv_json.
  ENDMETHOD.
ENDCLASS.
