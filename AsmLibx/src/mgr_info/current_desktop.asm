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
;---------- current_desktop ------------------

  extern x_get_property
  extern lib_buf
  extern x_wait_reply
  extern root_win_id
  extern atom_NET_CURRENT_DESKTOP
;---------------------
;>1 mgr_info
;  current_desktop - get current desktop from window mgr
; INPUTS
;    none
; OUTPUT:
;    flag set (jns) if success
;    flag set (js) if err, eax=error code
;
;    if success eax -> number of desktops
;              
; NOTES
;   source file: current_desktop.asm
;   lib_buf is used as work buffer
;<
; * ----------------------------------------------

  global current_desktop
current_desktop:
  call	atom_NET_CURRENT_DESKTOP
  or	eax,eax
  js	wn_error
  mov	esi,eax
;get property net_wm_active_win
nwaw_40:
  mov	eax,[root_win_id]	;
  mov	ecx,lib_buf		;buffer
  mov	edx,700			;buffer length
  mov	edi,0			;atom type
  call	x_get_property
  js	wn_error
  mov	eax,[ecx+32]		;get mumber of desktops
wn_error:
  ret

  [section .text]


%ifdef DEBUG

extern x_send_request
extern env_stack
extern x_connect

global _start
_start:
  call	env_stack
  call	x_connect
  call	current_desktop

  mov	eax,01
  int	byte 80h

;-----------

%endif
