/*  BePascal - A pascal wrapper around the BeOS API
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
*/

#ifndef _POINT_H_
#define _POINT_H_

#include <Point.h>

#include <beobj.h>

class BPPoint : public BPoint, public BPasObject
{
	public:
		BPPoint(TPasObject PasObject, float x, float y);
		BPPoint(TPasObject PasObject, const BPoint& point);
		BPPoint(TPasObject PasObject);
};

#endif _POINT_H_ /* _POINT_H_ */
