(*
* Copyright (c) 2022 XXIV
* 
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
* 
* The above copyright notice and this permission notice shall be included in all
* copies or substantial portions of the Software.
* 
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*)
unit urlencoding.raw;

interface

uses ctypes;

(*
* Percent-encodes every byte except alphanumerics and -, _, ., ~. Assumes UTF-8 encoding.
* 
* Example:
* * *
* program main;
* uses urlencoding.raw;
* 
* var
*    res : pchar;
*    
* begin
*    res := url_encoding_encode('This string will be URL encoded.');
*    writeln(res);
*    url_encoding_free(res);
* end.
* * *
* 
* @param data
* @return encoded string
*)
function url_encoding_encode(const data: pchar): pchar; cdecl; external;

(*
* Percent-encodes every byte except alphanumerics and -, _, ., ~.
* 
* Example:
* * *
* program main;
* uses urlencoding.raw;
* 
* var
*    res : pchar;
*    
* begin
*    res := url_encoding_encode_binary('This string will be URL encoded.',
*                                      byte('This string will be URL encoded.'[0]));
*    writeln(res);
*    url_encoding_free(res);
* end.
* * *
* 
* @param data
* @param length
* @return encoded string
*)
function url_encoding_encode_binary(const data: pchar; length: csize_t): pchar; cdecl; external;

(*
* Decode percent-encoded string assuming UTF-8 encoding.
* 
* Example:
* * *
* program main;
* uses urlencoding.raw;
* 
* var
*    res : pchar;
*    
* begin
*    res := url_encoding_decode('%F0%9F%91%BE%20Exterminate%21');
*    writeln(res);
*    url_encoding_free(res);
* end.
* * *
* 
* @param data
* @return decoded string
*)
function url_encoding_decode(const data: pchar): pchar; cdecl; external;

(*
* Decode percent-encoded string as binary data, in any encoding.
* 
* Example:
* * *
* program main;
* uses urlencoding.raw;
* 
* var
*    res : pchar;
*    
* begin
*    res := url_encoding_decode_binary('%F1%F2%F3%C0%C1%C2',
*                                      byte('%F1%F2%F3%C0%C1%C2'[0]));
*    writeln(res);
*    url_encoding_free(res);
* end.
* * *
* 
* @param data
* @param length
* @return decoded string
*)
function url_encoding_decode_binary(const data: pchar; length: csize_t): pchar; cdecl; external;

(*
* procedure to free the memory after using urlencoding functions
*
* @param ptr string returned from urlencoding functions
*)
procedure url_encoding_free(ptr: pchar); cdecl; external;

implementation

end.
