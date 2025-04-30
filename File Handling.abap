REPORT ZFILE_HANDLING1.



types: BEGIN OF str1,
  emp_id(10) type N,
  emp_name(40) type c,
  end of str1.

  data it type  table of str1.
  data wa type str1.
  data lv_file  type string.

PARAMETERS: p_file type localfile.

at SELECTION-SCREEN on VALUE-REQUEST FOR p_file.

CALL FUNCTION 'F4_FILENAME'
* EXPORTING
*   PROGRAM_NAME        = SYST-CPROG
*   DYNPRO_NUMBER       = SYST-DYNNR
*   FIELD_NAME          = ' '
 IMPORTING
   FILE_NAME           =  p_file
            .

START-OF-SELECTION.

lv_file = p_file.

CALL FUNCTION 'GUI_UPLOAD'
  EXPORTING
    FILENAME                      = lv_file
*   FILETYPE                      = 'ASC'
   HAS_FIELD_SEPARATOR           = ' '
*   HEADER_LENGTH                 = 0
*   READ_BY_LINE                  = 'X'
*   DAT_MODE                      = ' '
*   CODEPAGE                      = ' '
*   IGNORE_CERR                   = ABAP_TRUE
*   REPLACEMENT                   = '#'
*   CHECK_BOM                     = ' '
*   VIRUS_SCAN_PROFILE            =
*   NO_AUTH_CHECK                 = ' '
* IMPORTING
*   FILELENGTH                    =
*   HEADER                        =
  TABLES
    DATA_TAB                      = it
* CHANGING
*   ISSCANPERFORMED               = ' '
 EXCEPTIONS
   FILE_OPEN_ERROR               = 1
   FILE_READ_ERROR               = 2
   NO_BATCH                      = 3
   GUI_REFUSE_FILETRANSFER       = 4
   INVALID_TYPE                  = 5
   NO_AUTHORITY                  = 6
   UNKNOWN_ERROR                 = 7
   BAD_DATA_FORMAT               = 8
   HEADER_NOT_ALLOWED            = 9
   SEPARATOR_NOT_ALLOWED         = 10
   HEADER_TOO_LONG               = 11
   UNKNOWN_DP_ERROR              = 12
   ACCESS_DENIED                 = 13
   DP_OUT_OF_MEMORY              = 14
   DISK_FULL                     = 15
   DP_TIMEOUT                    = 16
   OTHERS                        = 17
          .
IF SY-SUBRC <> 0.
* Implement suitable error handling here
ENDIF.


loop at it INTO wa.
 write :  / wa-emp_id,  wa-emp_name.
 endloop.