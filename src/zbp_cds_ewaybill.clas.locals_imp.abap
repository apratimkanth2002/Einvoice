CLASS lhc_zcds_ewaybill DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zcds_ewaybill RESULT result.

    METHODS get_global_authorizations FOR GLOBAL AUTHORIZATION
      IMPORTING REQUEST requested_authorizations FOR zcds_ewaybill RESULT result.
    METHODS createirn FOR MODIFY
      IMPORTING keys FOR ACTION zcds_ewaybill~createirn RESULT result.
    METHODS getinvoicedata FOR READ
      IMPORTING keys FOR FUNCTION zcds_ewaybill~getinvoicedata RESULT result.

ENDCLASS.

CLASS lhc_zcds_ewaybill IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD get_global_authorizations.
  ENDMETHOD.

  METHOD createirn.
    DATA : lv_url  TYPE string.
    lv_url = 'https://sgnhelpdesk.com/antas_einvoice_json/ats_einv_process/?sapcd=GENUS&gst=21AAICS5549M1ZZ&ebn=N'.

    DATA(lo_dest) =
        cl_http_destination_provider=>create_by_url( lv_url ).

    DATA(lo_client) =
      cl_web_http_client_manager=>create_by_http_destination( lo_dest ).

    DATA(lo_request) = lo_client->get_http_request( ).

    DATA(lv_payload) = zcl_einvoice_payload=>get_payload( bill_doc = '12345' ).

    lo_request->set_text( lv_payload ).
    lo_request->set_content_type( 'application/json' ).
    lo_request->set_header_field(
        i_name  = 'Accept'
        i_value = 'application/json'
         ).

    lo_request->set_header_field(
      i_name  = 'Content-Type'
      i_value = 'application/json'
    ).

    TRY.
        DATA(lv_req_header) = lo_request->get_header_fields(  ).
        DATA(lo_response) = lo_client->execute( if_web_http_client=>post ).
        DATA(status1) = lo_response->get_status( ).
        IF status1-code <> 200 AND status1-code <> 201.
          DATA(lv_error_msg) = lo_response->get_text( ).
        ENDIF.
      CATCH cx_web_http_client_error INTO DATA(lv_error_response2).
    ENDTRY.
  ENDMETHOD.

  METHOD getinvoicedata.
  ENDMETHOD.

ENDCLASS.
