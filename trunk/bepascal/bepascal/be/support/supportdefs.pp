{  BePascal - A pascal wrapper around the BeOS API
    Copyright (C) 2002 Olivier Coursiere

    This library is free software; you can redistribute it and/or
    modify it under the terms of the GNU Library General Public
    License as published by the Free Software Foundation; either
    version 2 of the License, or (at your option) any later version.

    This library is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
    Library General Public License for more details.

    You should have received a copy of the GNU Library General Public
    License along with this library; if not, write to the Free
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
}

unit SupportDefs;

interface

type
    // Descriptive formats
  TStatus_t = Longint;
  TBigtime_t = int64;
  TType_code = Cardinal;
  TPerform_code = Cardinal;
  
  	// pointer types for FreePascal : to make life easier
  PStatus_t = ^TStatus_t;
  
  // TODO : import other functions !

implementation


end.