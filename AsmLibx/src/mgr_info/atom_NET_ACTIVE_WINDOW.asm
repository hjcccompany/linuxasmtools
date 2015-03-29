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
;---------- atom_NET_ACTIVE_WINDOW ------------------

  extern x_interatom
;---------------------
;>1 mgr_info
;  atom_NET_ACTIVE_WINDOW - get atom NET_ACTIVE_WINDOW
; INPUTS
;    none
; OUTPUT:
;    flag set (jns) if success
;    flag set (js) if err, eax=error code
;
;    if success eax -> atom
;              
; NOTES
;   source file: atom_NET_ACTIVE_WINDOW.asm
;   lib_buf is used as work buffer
;<
; * ----------------------------------------------

  global atom_NET_ACTIVE_WINDOW
atom_NET_ACTIVE_WINDOW:
  mov	eax,[saved_atom]
  or	eax,eax
  jnz	wn_exit		;jmp if atom known
  mov	esi,atom_name
  call	x_interatom
  js	wn_exit
  mov	[saved_atom],eax
wn_exit:
  ret

  [section .data]

saved_atom	dd 0
atom_name:	db '_NET_ACTIVE_WINDOW',0

  [section .text]


%ifdef DEBUG

extern x_send_request
extern env_stack
extern x_connect

global _start
_start:
  call	env_stack
  call	x_connect
  call	atom_NET_ACTIVE_WINDOW

  mov	eax,01
  int	byte 80h

;-----------

%endif
