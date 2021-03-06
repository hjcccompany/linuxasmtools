
;   Copyright (C) 2007 Jeff Owens
;
;   This program is free software: you can redistribute it and/or modify
;   it under the terms of the GNU General Public License as published by
;   the Free Software Foundation, either version 3 of the License, or
;   (at your option) any later version.
;
;   This program is distributed in the hope that it will be useful,
;   but WITHOUT ANY WARRANTY; without even the implied warranty of
;   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;   GNU General Public License for more details.
;
;   You should have received a copy of the GNU General Public License
;   along with this program.  If not, see <http://www.gnu.org/licenses/>.


  [section .text align=1]
;------------------------------
;****f* widget/show_box *
; NAME
;>1 widget
;   show_box - display boxed message with optional boarder
; INPUTS
;    esi = pointer to structure below
;      dd window color (see notes)
;      dd data pointer.
;      dd end of data ptr, beyond last display char
;      dd initial scroll left/right position
;      db columns inside box
;      db rows inside box
;      db starting row
;      db starting column
;      dd outline box color (see notes)
;         (set to zero to disable outline)
;    lib_buf is used to build display lines
; OUTPUT
;   eax = negative system error# or positive if success
; NOTES
;    source file show_box.asm
;    The current window width is not checked, show_box
;    will attempth display even if window size too small.
;      
;    color = aaxxffbb aa-attr ff-foreground  bb-background
;    30-blk 31-red 32-grn 33-brn 34-blu 35-purple 36-cyan 37-gry
;    attributes 30-normal 31-bold 34-underscore 37-inverse
;<
;  * ---------------------------------------------------
;*******
  extern crt_window
  extern make_box
  global show_box
show_box:
  cmp	dword [esi + 20],0	;outline color provided
  jz	sb_skip			;jmp if no outline needed
  push	esi
  add	esi,16
  call	make_box
  pop	esi
sb_skip:
  call	crt_window
  ret

