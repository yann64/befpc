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

unit Application;

interface

uses
  beobj, looper, appdefs, supportdefs, message, os, roster;

type
  BApplication = class(BLooper)
  private
  public
    constructor Create; override;
    constructor Create(Signature : PChar); virtual;
	constructor Create(Signature : PChar; error : PStatus_t); virtual;
    destructor Destroy; override;
    procedure ShowCursor;
    procedure HideCursor;
    function Run : Thread_id;
    procedure Quit;
    function  GeAppInfo(var info : AppInfo ): Status_t;
      // Hook functions
    procedure AppActivated(Active : boolean); virtual;
    procedure ReadyToRun; virtual;
  end;

function BApplication_Create(AObject : TObject) : TCPlusObject; cdecl; external BePascalLibName name 'BApplication_Create_1';
function BApplication_Create(AObject : TObject; Signature : PChar) : TCPlusObject; cdecl; external BePascalLibName name 'BApplication_Create_2';
function BApplication_Create(AObject : TObject; Signature : PChar; error : PStatus_t) : TCPlusObject; cdecl; external BePascalLibName name 'BApplication_Create_3';
procedure BApplication_Free(Application : TCPlusObject); cdecl; external BePascalLibName;
procedure BApplication_HideCursor(Application : TCPlusObject); cdecl; external BePascalLibName;
procedure BApplication_ShowCursor(Application : TCPlusObject); cdecl; external BePascalLibName;
function BApplication_Run(Application : TCPlusObject) : Thread_id; cdecl; external BePascalLibName;
procedure BApplication_Quit(Application : TCPlusObject); cdecl; external BePascalLibName;
function BApplication_GeAppInfo(Application : TCPlusObject; var info : AppInfo ) : Status_t; cdecl; external BePascalLibName name 'BApplication_GetAppInfo';
function get_be_app_messenger : TCPlusObject; cdecl; external BePascalLibName name 'get_be_app_messenger';

var
  be_app : BApplication;

implementation

uses
  Messenger;

var
  Application_AppActivated_hook : Pointer; cvar; external;
  Application_ReadyToRun_hook : Pointer; cvar; external;

  // start BApplication
constructor BApplication.Create;
begin
  inherited;
  CPlusObject := BApplication_Create(Self, PChar('application/x-vnd.BePascal'));  
  be_app := Self;
  be_app_BMessenger := BMessenger.Wrap(be_app_messengerCPlus);
end;

constructor BApplication.Create(Signature : PChar);
begin
  inherited Create;	
  CPlusObject := BApplication_Create(Self, Signature);  
  be_app := Self;
  be_app_BMessenger := BMessenger.Wrap(be_app_messengerCPlus);
end;

constructor BApplication.Create(Signature : PChar; error : PStatus_t);
begin
  inherited Create;	
  CPlusObject := BApplication_Create(Self, Signature, error);  
  be_app := Self;
  be_app_BMessenger := BMessenger.Wrap(be_app_messengerCPlus);
end;

destructor BApplication.Destroy;
begin
  if CPlusObject <> nil then
    BApplication_Free(CPlusObject);
  if Assigned(be_app_BMessenger) then
    be_app_BMessenger.UnWrap;
  inherited;
end;

// Hook functions

procedure Application_AppActivated_hook_func(Application : BApplication; Active : boolean); cdecl;
begin
  if Application <> nil then
    Application.AppActivated(Active);
end;

procedure BApplication.AppActivated(Active : boolean);
begin
{$IFDEF DEBUG}
  SendText(Active);
  if Active then
	SendText('Application activée !')
  else
    SendText('Application désactivée !');
{$ENDIF}
end;

procedure Application_ReadyToRun_hook_func(Application : BApplication); cdecl;
begin
{$IFDEF DEBUG}
  SendText('Hook ReadyToRun !');
{$ENDIF}
  if Application <> nil then
    Application.ReadyToRun;
end;

procedure Application_MessageReceived_hook_func(Application : BApplication; aMessage : TCPlusObject); cdecl;
var
  Message : BMessage;
begin
{$IFDEF DEBUG}
  SendText('Hook MessageReceived !');
{$ENDIF}
  Message := BMessage.Wrap(aMessage);
  try
    if Application <> nil then
      Application.MessageReceived(Message);
  finally
    Message.UnWrap;
  end;
end;

procedure BApplication.ReadyToRun;
begin
{$IFDEF DEBUG}
  SendText('Prêt à démarer !');
{$ENDIF}
end;

procedure BApplication.ShowCursor;
begin
  BApplication_ShowCursor(CPlusObject);
end;

procedure BApplication.HideCursor;
begin
  BApplication_HideCursor(CPlusObject);
end;

function BApplication.Run : Thread_id;
begin
  Result := BApplication_Run(CPlusObject);
end;

procedure BApplication.Quit;
begin
	BApplication_Quit(CPlusObject);
end;

function BApplication.GeAppInfo(var info : AppInfo ): Status_t;
begin
  Result:=BApplication_GeAppInfo(CPlusObject,info) ;
end;


  // end BApplication
  
initialization
  be_app := nil;
  Application_AppActivated_hook := @Application_AppActivated_hook_func;
  Application_ReadyToRun_hook := @Application_ReadyToRun_hook_func;
  
finalization
  Application_AppActivated_hook := nil;
  Application_ReadyToRun_hook := nil;
  be_app := nil;
  
end.
