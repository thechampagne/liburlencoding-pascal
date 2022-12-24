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
unit urlencoding;

interface

uses urlencoding.raw;

(*
* Percent-encodes every byte except alphanumerics and -, _, ., ~. Assumes UTF-8 encoding.
* 
* Example:
* * *
* program main;
* uses urlencoding;
* 
* var
*    res : string;
*    
* begin
*    res := encode('This string will be URL encoded.');
*    writeln(res);
* end.
* * *
* 
* @param data
* @return encoded string
*)
function encode(const data: string): string;

(*
* Percent-encodes every byte except alphanumerics and -, _, ., ~.
* 
* Example:
* * *
* program main;
* uses urlencoding;
* 
* var
*    res : string;
*    
* begin
*    res := encodeBinary('This string will be URL encoded.');
*    writeln(res);
* end.
* * *
* 
* @param data
* @return encoded string
*)
function encodeBinary(const data: string): string;

(*
* Decode percent-encoded string assuming UTF-8 encoding.
* 
* Example:
* * *
* program main;
* uses urlencoding;
* 
* var
*    res : string;
*    
* begin
*    res := decode('%F0%9F%91%BE%20Exterminate%21');
*    writeln(res);
* end.
* * *
* 
* @param data
* @return decoded string
*)
function decode(const data: string): string;

(*
* Decode percent-encoded string as binary data, in any encoding.
* 
* Example:
* * *
* program main;
* uses urlencoding;
* 
* var
*    res : string;
*    
* begin
*    res := decodeBinary('%F1%F2%F3%C0%C1%C2');
*    writeln(res);
* end.
* * *
* 
* @param data
* @return decoded string
*)
function decodeBinary(const data: string): string;

implementation

function encode(const data: string): string;
var
   arr	: array of char;
   cstr	: pchar;
   pstr	: string;
   i	: integer;
   stri	: integer = 1;
begin
   setlength(arr,byte(data[0]) + 1);
   for i := 0 to byte(data[0]) do
   begin
      arr[i] := data[stri];
      stri := stri + 1;
   end;
   arr[byte(data[0])] := #0;
   cstr := url_encoding_encode(pchar(arr));
   if cstr = nil then
      encode := ''
   else
   begin
      pstr := string(cstr);
      url_encoding_free(cstr);
      encode := pstr;
   end;
end;

function encodeBinary(const data: string): string;
var
   arr	: array of char;
   cstr	: pchar;
   pstr	: string;
   i	: integer;
   stri	: integer = 1;
begin
   setlength(arr,byte(data[0]) + 1);
   for i := 0 to byte(data[0]) do
   begin
      arr[i] := data[stri];
      stri := stri + 1;
   end;
   arr[byte(data[0])] := #0;
   cstr := url_encoding_encode_binary(pchar(arr), byte(data[0]));
   if cstr = nil then
      encodeBinary := ''
   else
   begin
      pstr := string(cstr);
      url_encoding_free(cstr);
      encodeBinary := pstr;
   end;
end;

function decode(const data: string): string;
var
   arr	: array of char;
   cstr	: pchar;
   pstr	: string;
   i	: integer;
   stri	: integer = 1;
begin
   setlength(arr,byte(data[0]) + 1);
   for i := 0 to byte(data[0]) do
   begin
      arr[i] := data[stri];
      stri := stri + 1;
   end;
   arr[byte(data[0])] := #0;
   cstr := url_encoding_decode(pchar(arr));
   if cstr = nil then
      decode := ''
   else
   begin
      pstr := string(cstr);
      url_encoding_free(cstr);
      decode := pstr;
   end;
end;

function decodeBinary(const data: string): string;
var
   arr	: array of char;
   cstr	: pchar;
   pstr	: string;
   i	: integer;
   stri	: integer = 1;
begin
   setlength(arr,byte(data[0]) + 1);
   for i := 0 to byte(data[0]) do
   begin
      arr[i] := data[stri];
      stri := stri + 1;
   end;
   arr[byte(data[0])] := #0;
   cstr := url_encoding_decode_binary(pchar(arr), byte(data[0]));
   if cstr = nil then
      decodeBinary := ''
   else
   begin
      pstr := string(cstr);
      url_encoding_free(cstr);
      decodeBinary := pstr;
   end;
end;

end.
