unit UCommonUtil;

interface

uses
  windows, inifiles,SysUtils,forms,Activex,Classes,Variants,Controls,ExtCtrls,
  suiEdit,ComCtrls,suiform,suiComboBox,suiMemo, StdCtrls, VCLUnZip, VCLZip, DB,
  ADODB, MConnect, SConnect, ComObj, Dialogs, xmldom, XMLIntf, msxmldom, XMLDoc;

type
  areaArray = array of string;

  procedure writeToIni(iniFileName:String;mainKey:String;leafKey:String;value:String); //写ini文件
  function  readFromIni(iniFileName:String;mainKey:String;leafKey:String;defaultValue:String):String; //读ini文件
  procedure EraseSection(iniFileName:String;mainKey:String);    //删除Ini文件小节名
  procedure DeleteKey(iniFileName:String;mainKey:String;leafKey:String); //删除Ini文件关键字

  function  GetAppPath(): String;//得到应用程序路径
  function  GetAppName(): string;
  function  GetGuid():string;  //取Guid的函数

  procedure UnpackStream(Input: OleVariant; Stream: TStream);    { 辅助方法UnpackStream，将OleVariant转换成Stream。 }
  function getData(FileName:string):OleVariant; //将文件转化成流的形式输出
  function PackageStream(Stream: TStream): OleVariant;

  function  downFile(SckConn: TSocketConnection; localFile,remoteFile:String):Integer;
  function  upFile(SckConn: TSocketConnection; localFile,remoteFile:String):Integer;
  function  deleteRemoteFile(SckConn: TSocketConnection; remoteFile:String):Integer;
  Function  SplitString(const source,ch:string):TStringList;
  Function  split(s:string;dot:char):areaArray;
  procedure deleteLocalFile(fileName:String);   //删除本地文件
  function  totalChar(s:String;sChar:char):Integer;   //统计字符串个数

  function  getSerialNumber(amount:integer;value:String):String; //得到编号

  procedure noImeToForm(frmName:Tsuiform); //去掉开发时默认的输入法
  procedure noImeToPanel(panelName:TPanel); //去掉开发时默认的输入法
  procedure noImeToGroupBox(panelName:TGroupBox); //去掉开发时默认的输入法
  function  pressPathZip(filePath:String; saveName:String): Boolean;
  function  pressFileZip(fileName, saveName:String): Boolean;
  function  UnpressFileZip(zipFile, UnZipPath: string): Boolean;
  function  DeletePath(mDirName: string): Boolean; { 返回删除指定目录是否成功 }
  Function  Encrypt(S:String;key:Word):String;  //加密
  Function  Decrypt(S:String;key:Word):String;  //解密

  function ShowMsg(Text, Caption: string; Flags: Longint): Integer; //
  function OpenDataSet(qry: TADOQuery; sSQL: string; bShowPromot: Boolean=True): Boolean; //执行select语句
  function ExcuteDataSet(qry: TADOQuery; sSQL: string; bShowPromot: Boolean=True): Boolean;  //执行非select语句。

  function WriteErrorLog(sError: string): boolean; //写错误日志
  function GetNameFromValue(ls: TStrings; Value: string): string;

  //xls
  function ExcelInit(var ExcelApp:Variant;ExcelFile:String;visible:boolean):Boolean;   //Excel初始化
  function ExcelSetActivate(var ExcelApp:Variant;value:Integer):Boolean;  //设置Excel操作那个sheet页(从1开始的)
  function ExcelSetValue(var ExcelApp:Variant;x,y:Integer;value:String):Boolean;  //给Excel格子附值
  function ExcelGetValue(var ExcelApp:Variant;x,y:Integer): string; //取Excel格子的值

  function ExcelSaveAsAndQuit(var ExcelApp:Variant;ExcelFile:String):Boolean;  //保存Excel文件并且退出
  function ExcelSaveAndQuit(var ExcelApp:Variant):Boolean;  //保存Excel文件并且退出
  function ExcelSheetInsertRows(var ExcelApp:Variant; x: Integer): Boolean; //在当前页插入行
  function ExcelSheetInsertColumns(var ExcelApp:Variant; y: Integer): Boolean; //在当前页插入列
  function ExcelSheetDeleteRows(var ExcelApp:Variant; x: Integer): Boolean; //删除行
  function ExcelSheetDeleteColumns(var ExcelApp:Variant; y: Integer): Boolean; //删除列
  function ExcelMergeCells(var ExcelApp:Variant; x1, y1, x2, y2: Integer): Boolean; //在当前页合并单元格

  //
  function DateExitx(edt: TSUIEdit): boolean;
  function MoneyToCn(ANumberic: Double): string;

  //XML
  function XMLInit(XMLDoc: TXMLDocument; XmlFn: string): Boolean;   //XML初始化，XmlFn为空则打开一个空的xml
  function XMLSetRootNode(XMLDoc: TXMLDocument; RootName: string): Boolean;
  function XMLAddNode(Parent: IXMLNode; Name, Text: string): IXMLNode;
  function XMLGetText(Parent: IXMLNode; SubName: string): string;
  function XMLAddNodeEx(Parent: IXMLNode; Name: string; AttrName: string=''; AttrText: string=''): IXMLNode;
  function XMLFindNodeEx(Parent: IXMLNode; Name: string; AttrName: string=''; AttrText: string=''): IXMLNode;
  function XMLSaveAsAndQuit(XMLDoc: TXMLDocument; XmlFn: string): Boolean;
  function XMLSaveAndOuit(XMLDoc: TXMLDocument): Boolean;
  function XMLToComBoBox(XmlFn,nodeName:string;comboBox:TsuiComboBox;bool:Boolean):Boolean;
  function XMLToComBo(XmlFn,nodeName:string;comboBox:TsuiComboBox;bool:Boolean):Boolean;
  function ComBoBoxToSave(XmlFn,nodeName,comboboxValue:string):String;
  function SaveToComBoBox(XmlFn,nodeName,saveValue:string):String;
  function XMLFindToComBoBox(XmlFn,nodeName,nodeValue:string;comboBox:TsuiComboBox;bool:Boolean):Boolean;
  function IndustryToComBoBox(XmlFn:string;comboBox:TsuiComboBox):Boolean;
  function ComBoBoxToValue(XmlFn:string;nameValue:String):String;
  function ValueToComboBox(XmlFn:string;nameValue:String):String;
  function ComBoBoxToChildValue(XmlFn:string;childName:String):String;
  function ChildValueToComBoBox(XmlFn:string;childvalue:String):String;
  function inputTag(value,index:Integer):String;  //第一位表示数据类型，第二位表示是否必输入项目

implementation

function XMLFindToComBoBox(XmlFn,nodeName,nodeValue:string;comboBox:TsuiComboBox;bool:Boolean):Boolean;
var
 ParentNode,childNode:IXMLNode;
 i:Integer;
 xmlDocx:TXMLDocument;
begin
 result:=false;
 xmlDocx:=TXMLDocument.Create(Application);
 XMLInit(XMLDocx,XmlFn);
 comboBox.Style:=csDropDownList;
 comboBox.Items.Clear ;
 ParentNode:=XMLDocx.DocumentElement.ChildNodes.First;
 while ParentNode <> nil do
 begin
  if(ParentNode.Attributes[nodeName]=nodeValue) then break;
  ParentNode := ParentNode.NextSibling;
 end;
 //showmessage(ParentNode.Attributes['name']);
 if(bool) then
    comboBox.Items.Add('');
 for i:=0 to ParentNode.ChildNodes.Count-1 do
 begin
   childNode:=ParentNode.ChildNodes.Get(i);
   if(childNode.Attributes['name']='') then
     comboBox.Items.Add('')
   else
     comboBox.Items.Add(childNode.Attributes['name']);
 end;
 XMLDocx.Active := False;
 result:=true;
end;

function IndustryToComBoBox(XmlFn:string;comboBox:TsuiComboBox):Boolean;
var
 ParentNode,childNode:IXMLNode;
 i:Integer;
 xmlDocx:TXMLDocument;
begin
 result:=false;
 xmlDocx:=TXMLDocument.Create(Application);
 XMLInit(XMLDocx,XmlFn);
 comboBox.Style:=csDropDownList;
 comboBox.Items.Clear ;
 childNode:=XMLDocx.DocumentElement.ChildNodes.First;
 while ChildNode <> nil do
 begin
  comboBox.Items.Add(childNode.Attributes['name']);
  ChildNode := ChildNode.NextSibling;
 end;
 XMLDocx.Active := False;
 result:=true;
end;

function ComBoBoxToValue(XmlFn:string;nameValue:String):String;
var
 ParentNode,childNode,grandsonNode:IXMLNode;
 i:Integer;
 xmlDocx:TXMLDocument;
 Rev:String;
 bool:Boolean;
begin
 Rev:='';
 xmlDocx:=TXMLDocument.Create(Application);
 XMLInit(XMLDocx,XmlFn);
 childNode:=XMLDocx.DocumentElement.ChildNodes.First;
 while ChildNode <> nil do
 begin
  if(childNode.Attributes['name']=nameValue) then
  begin
   Rev:=childNode.Attributes['value'];
   break;
  end;
  ChildNode := ChildNode.NextSibling;
 end;
 XMLDocx.Active := False;
 result:=Rev;
end;

function ValueToComboBox(XmlFn:string;nameValue:String):String;
var
 ParentNode,childNode,grandsonNode:IXMLNode;
 i:Integer;
 xmlDocx:TXMLDocument;
 Rev:String;
 bool:Boolean;
begin
 Rev:='';
 xmlDocx:=TXMLDocument.Create(Application);
 XMLInit(XMLDocx,XmlFn);
 childNode:=XMLDocx.DocumentElement.ChildNodes.First;
 while ChildNode <> nil do
 begin
  if(childNode.Attributes['value']=nameValue) then
  begin
   Rev:=childNode.Attributes['name'];
   break;
  end;
  ChildNode := ChildNode.NextSibling;
 end;
 XMLDocx.Active := False;
 result:=Rev;
end;

function ComBoBoxToChildValue(XmlFn:string;childName:String):String;
var
 ParentNode,childNode,grandsonNode:IXMLNode;
 i:Integer;
 xmlDocx:TXMLDocument;
 Rev:String;
 bool:Boolean;
begin
 Rev:='';
 xmlDocx:=TXMLDocument.Create(Application);
 XMLInit(XMLDocx,XmlFn);
 childNode:=XMLDocx.DocumentElement.ChildNodes.First;
 bool:=false;
 while ChildNode <> nil do
 begin
   for i:=0 to ChildNode.ChildNodes.Count-1 do
   begin
    grandsonNode:=ChildNode.ChildNodes.Get(i);
    if(grandsonNode.Attributes['name']=childName) then
    begin
     bool:=true;
     Rev:=grandsonNode.Attributes['value'];
     break;
    end;
   end;
  if bool then break;
  ChildNode := ChildNode.NextSibling;
 end;
 XMLDocx.Active := False;
 result:=Rev;
end;

function ChildValueToComBoBox(XmlFn:string;childvalue:String):String;
var
 ParentNode,childNode,grandsonNode:IXMLNode;
 i:Integer;
 xmlDocx:TXMLDocument;
 Rev:String;
 bool:Boolean;
begin
 Rev:='';
 xmlDocx:=TXMLDocument.Create(Application);
 XMLInit(XMLDocx,XmlFn);
 childNode:=XMLDocx.DocumentElement.ChildNodes.First;
 bool:=false;
 while ChildNode <> nil do
 begin
   for i:=0 to ChildNode.ChildNodes.Count-1 do
   begin
    grandsonNode:=ChildNode.ChildNodes.Get(i);
    if(grandsonNode.Attributes['value']=childvalue) then
    begin
     bool:=true;
     Rev:=grandsonNode.Attributes['name'];
     break;
    end;
   end;
  if bool then break;
  ChildNode := ChildNode.NextSibling;
 end;
 XMLDocx.Active := False;
 result:=Rev;
end;

function XMLToComBoBox(XmlFn,nodeName:string;comboBox:TsuiComboBox;bool:Boolean):Boolean;
var
 ParentNode,childNode:IXMLNode;
 i:Integer;
 xmlDocx:TXMLDocument;
begin
 result:=false;
 xmlDocx:=TXMLDocument.Create(Application);
 XMLInit(XMLDocx,XmlFn);
 ParentNode:=XMLDocx.DocumentElement.ChildNodes.FindNode(nodeName);
 comboBox.Style:=csDropDownList;
 comboBox.Items.Clear ;
 if(bool) then
    comboBox.Items.Add('');
 for i:=0 to ParentNode.ChildNodes.Count-1 do
 begin
   childNode:=ParentNode.ChildNodes.Get(i);
   if(childNode.NodeValue=null) then
     comboBox.Items.Add('')
   else
     comboBox.Items.Add(childNode.NodeValue);
 end;
 XMLDocx.Active := False;
 result:=true;
end;

function XMLToComBo(XmlFn,nodeName:string;comboBox:TsuiComboBox;bool:Boolean):Boolean;
var
 ParentNode,childNode:IXMLNode;
 i:Integer;
 xmlDocx:TXMLDocument;
begin
 result:=false;
 xmlDocx:=TXMLDocument.Create(Application);
 XMLInit(XMLDocx,XmlFn);
 ParentNode:=XMLDocx.DocumentElement.ChildNodes.FindNode(nodeName);
 comboBox.Style:=csDropDownList;
 comboBox.Items.Clear ;
 if(bool) then
    comboBox.Items.Add('');
 for i:=0 to ParentNode.ChildNodes.Count-1 do
 begin
   childNode:=ParentNode.ChildNodes.Get(i);
   comboBox.Items.Add(childNode.Attributes['name']);
 end;
 XMLDocx.Active := False;
 result:=true;
end;

function ComBoBoxToSave(XmlFn,nodeName,comboboxValue:string):String;
var
 ParentNode,childNode:IXMLNode;
 i:Integer;
 xmlDocx:TXMLDocument;
 Ret:String;
begin
 Ret:='';
 xmlDocx:=TXMLDocument.Create(Application);
 XMLInit(XMLDocx,XmlFn);
 ParentNode:=XMLDocx.DocumentElement.ChildNodes.FindNode(nodeName);
 for i:=0 to ParentNode.ChildNodes.Count-1 do
 begin
  childNode:=ParentNode.ChildNodes.Get(i);
  if(childNode.Attributes['name']=comboboxValue) then
  begin
   Ret:=childNode.Attributes['value'];
   break;
  end;
 end;
 XMLDocx.Active := False;
 result:=Ret;
end;

function SaveToComBoBox(XmlFn,nodeName,saveValue:string):String;
var
 ParentNode,childNode:IXMLNode;
 i:Integer;
 xmlDocx:TXMLDocument;
 Ret:String;
begin
 Ret:='';
 xmlDocx:=TXMLDocument.Create(Application);
 XMLInit(XMLDocx,XmlFn);
 ParentNode:=XMLDocx.DocumentElement.ChildNodes.FindNode(nodeName);
 for i:=0 to ParentNode.ChildNodes.Count-1 do
 begin
  childNode:=ParentNode.ChildNodes.Get(i);
  if(childNode.Attributes['value']=saveValue) then
  begin
   Ret:=childNode.Attributes['name'];
   break;
  end;
 end;
 XMLDocx.Active := False;
 result:=Ret;
end;

function inputTag(value,index:Integer):String;
var
 s:String;
begin
 if(value=0) then
 begin
  result:='1';
  exit;
 end
 else
 begin
  s:=IntToStr(value);
  result:=s[index];
 end;
end;

Function Encrypt(S:String;key:Word):String;
var
  i:integer;
  j:integer;
begin
  Result:=S;
  for i:=1 to Length(S) do
  begin
    Result[i]:=char(byte(S[i]) xor (key shr 8));
    key:=(byte(Result[i])+key)*52845+22719;
  end;
  S:=Result;
  Result:='';
  for i:=1 to length(s) do
  begin
    j:=Integer(S[i]);
    Result:=Result+char(65+(j div 26))+char(65+(j mod 26));
  end;
end;

Function Decrypt(S:String;key:Word):String;
var
  i:integer;
  j:integer;
begin
  Result:='';
  for i:=1 to (length(s) div 2) do
  begin
    j:=(Integer(s[2*i-1])-65)*26;
    j:=j+(Integer(S[2*i])-65);
    Result:=Result+char(j);
  end;
  S:=Result;
  for i:=1 to Length(S) do
  begin
    Result[i]:=char(byte(S[I]) xor (key shr 8));
    key:=(byte(S[I])+Key)*52845+22719;
  end;
end;

{
Lmd: 修改成仅删除知底功能目录下的文件，不删除下一级目录
}
function DeletePath(mDirName: string): Boolean; { 返回删除指定目录是否成功 }
var
  vSearchRec: TSearchRec;
  vPathName, vFn: string;
  K: Integer;
begin
  Result := False;
  if Trim(mDirName) = '' then Exit;

  vPathName := mDirName + '\*.*';
  K := FindFirst(vPathName, faAnyFile, vSearchRec);
  while K = 0 do
  begin
    vFn := vSearchRec.Name;
    if (vFn<>'.') and (vFn<>'..') and (vSearchRec.Attr<>faDirectory) then
    begin
      if not DeleteFile(mDirName + '\' + vFn) then Exit;
    end;
    K := FindNext(vSearchRec);
  end;
  FindClose(vSearchRec);
  result := true;
end;

function pressFileZip(fileName,saveName:String): boolean;
var
  sCYVCLZip: TVCLZip;
begin
  Result := False;
  sCYVCLZip:=TVCLZip.Create(nil);
  try
    try
      sCYVCLZip.ZipName := saveName;
      sCYVCLZip.FilesList.Add(fileName);
      sCYVCLZip.Recurse := True;
      sCYVCLZip.Zip;
      Result := True;      
    except
    end;
  finally
    sCYVCLZip.Free;
  end;
end;

function pressPathZip(filePath:String;saveName:String): Boolean;
var
  sCYVCLZip: TVCLZip;
begin
  Result := False;
  sCYVCLZip:=TVCLZip.Create(nil);
  try
    try
      sCYVCLZip.ZipName := saveName;
      sCYVCLZip.FilesList.Add(filePath+'\*.*');
      sCYVCLZip.Recurse := True;
      sCYVCLZip.Zip;
      Result := True;
    except
    end;
  finally
    sCYVCLZip.Free;
  end;
end;

function UnpressFileZip(zipFile, UnZipPath: string): Boolean;
var
  CLUnZip: TVCLUnZip;
begin
  Result := False;
  CLUnZip := TVCLUnZip.Create(nil);
  try
    try
      //解压上传的zip文件（注意：解压后的文件仍为zip文件，需要继续处理！）
      CLUnZip.DoAll := True;
      CLUnZip.DoProcessMessages := False;
      CLUnZip.OverwriteMode := Always;
      CLUnZip.ReplaceReadOnly := True;
      CLUnZip.ZipName := zipFile;
      CLUnZip.DestDir := UnZipPath;
      //此属性设置不按之前的压缩目录结构来解压，即所有的解压文件都释放到DestDir目录下
      CLUnZip.RecreateDirs := True;
      CLUnZip.UnZip;
      Result := True;
    except
    end;
  finally
    CLUnZip.Free;
  end;
end;


procedure noImeToPanel(panelName:TPanel); //去掉开发时默认的输入法
var
 index:Integer;
begin
 with panelName do
 begin
  for index:=0 to panelName.ControlCount-1 do
  begin
    if(panelName.Controls[index] is TsuiEdit) then
    begin
     (panelName.Controls[index] As TsuiEdit).ImeName:='';
     (panelName.Controls[index] As TsuiEdit).ImeMode:=imDontCare;
    end
    else if(panelName.Controls[index] is TsuiComboBox) then
    begin
     (panelName.Controls[index] As TsuiComboBox).ImeName :='';
     (panelName.Controls[index] As TsuiComboBox).ImeMode:=imDontCare;
    end
    else if(panelName.Controls[index] is TsuiMemo) then
    begin
     (panelName.Controls[index] As TsuiMemo).ImeName :='';
     (panelName.Controls[index] As TsuiMemo).ImeMode:=imDontCare;
    end
    else if(panelName.Controls[index] is TDateTimePicker) then
    begin
     (panelName.Controls[index] As TDateTimePicker).ImeName :='';
     (panelName.Controls[index] As TDateTimePicker).ImeMode:=imDontCare;
    end;
  end;
 end;
end;

procedure noImeToGroupBox(panelName:TGroupBox);
var
 index:Integer;
begin
 with panelName do
 begin
  for index:=0 to panelName.ControlCount-1 do
  begin
    if(panelName.Controls[index] is TsuiEdit) then
    begin
     (panelName.Controls[index] As TsuiEdit).ImeName:='';
     (panelName.Controls[index] As TsuiEdit).ImeMode:=imDontCare;
    end
    else if(panelName.Controls[index] is TsuiComboBox) then
    begin
     (panelName.Controls[index] As TsuiComboBox).ImeName :='';
     (panelName.Controls[index] As TsuiComboBox).ImeMode:=imDontCare;
    end
    else if(panelName.Controls[index] is TsuiMemo) then
    begin
     (panelName.Controls[index] As TsuiMemo).ImeName :='';
     (panelName.Controls[index] As TsuiMemo).ImeMode:=imDontCare;
    end
    else if(panelName.Controls[index] is TDateTimePicker) then
    begin
     (panelName.Controls[index] As TDateTimePicker).ImeName :='';
     (panelName.Controls[index] As TDateTimePicker).ImeMode:=imDontCare;
    end;
  end;
 end;
end;

procedure noImeToForm(frmName:Tsuiform); //去掉开发时默认的输入法
var
 index:Integer;
begin
 with frmName do
 begin
  for index:=0 to frmName.ControlCount-1 do
  begin
    if(frmName.Controls[index] is TsuiEdit) then
    begin
     (frmName.Controls[index] As TsuiEdit).ImeName:='';
     (frmName.Controls[index] As TsuiEdit).ImeMode:=imDontCare;
    end
    else if(frmName.Controls[index] is TsuiComboBox) then
    begin
     (frmName.Controls[index] As TsuiComboBox).ImeName :='';
     (frmName.Controls[index] As TsuiComboBox).ImeMode:=imDontCare;
    end
    else if(frmName.Controls[index] is TsuiMemo) then
    begin
     (frmName.Controls[index] As TsuiMemo).ImeName :='';
     (frmName.Controls[index] As TsuiMemo).ImeMode:=imDontCare;
    end
    else if(frmName.Controls[index] is TDateTimePicker) then
    begin
     (frmName.Controls[index] As TDateTimePicker).ImeName :='';
     (frmName.Controls[index] As TDateTimePicker).ImeMode:=imDontCare;
    end;
  end;
 end;
end;

procedure writeToIni(iniFileName:String;mainKey:String;leafKey:String;value:String);
var
  ctrlIniFile:TIniFile;
begin
  ctrlIniFile:=TIniFile.Create(iniFileName);
  try
    ctrlIniFile.WriteString(mainKey,leafKey,value);
  finally
    ctrlIniFile.Free;
 end;
end;

procedure EraseSection(iniFileName:String;mainKey:String);    //删除Ini文件小节名
var
  ctrlIniFile:TIniFile;
begin
  ctrlIniFile:=TIniFile.Create(iniFileName);
  try
    ctrlIniFile.EraseSection(mainKey);
  finally
    ctrlIniFile.Free;
  end;
end;

procedure DeleteKey(iniFileName:String;mainKey:String;leafKey:String); //删除Ini文件关键字
var
  ctrlIniFile:TIniFile;
begin
  ctrlIniFile:=TIniFile.Create(iniFileName);
  try
    ctrlIniFile.DeleteKey(mainKey,leafKey);
  finally
    ctrlIniFile.Free;
  end;
end;

function readFromIni(iniFileName:String;mainKey:String;leafKey:String;defaultValue:String):String;
var
  ctrlIniFile:TIniFile;
  value:String;
begin
  ctrlIniFile:=TIniFile.Create(iniFileName);
  try
    value:=ctrlIniFile.ReadString(mainKey,leafKey,defaultValue);
    result:=value;
  finally
    ctrlIniFile.Free;
   end;
end;

function  GetAppPath():String;
begin
  result := ExtractFilePath(application.ExeName);
end;

function GetAppName():String;
var
  FileName: String;
begin
  FileName := application.ExeName;
  Result := StringReplace(ExtractFileName(FileName),ExtractFileExt(FileName),'',[]);
end;

function getGuid():string;
var
  guid:TGUID;
  sGuid:String;
begin
  CoCreateGUID(guid);
  sGuid := GuidToString(guid);
  sGuid := copy(sGuid,2,36);
  result:= sGuid;
end;

procedure UnpackStream(Input: OleVariant; Stream: TStream);
var
  PData: PByteArray;
begin
  try
    //if VarIsNull(Input) or not VarIsArray(Input) then
    //   Error('无法从变量中解开流。');
    pData := VarArrayLock(Input);
    try
      Stream.Position := 0;
      Stream.Write(pData^, VarArrayHighBound(Input, 1) + 1);
    finally
      VarArrayUnlock(Input);
    end;
  except
    on E: Exception do
    begin
      WriteErrorLog(E.Message);
      ShowMsg('执行UnpackStream时出错。'#13 + E.Message, '提示', MB_OK);
    end;
  end;
end;

//将文件转化成流的形式输出
//Input:服务器端文件的全路径
function getData(FileName:string):OleVariant;
var
  sFileName:string;
  sm:TMemoryStream;
  data:OleVariant;
begin
  sFileName:=fileName;
  sm:=TMemoryStream.Create;
  try
    sm.LoadFromFile(sFileName);
    data := PackageStream(sm);
    result:=data;
  finally
    sm.Free;
  end;
end;

function PackageStream(Stream: TStream): OleVariant;
var
  PData: PByteArray;
  Temp: OleVariant;
begin
  Result := Null;
  try
    if Stream.Size = 0 then Exit;

    Temp := VarArrayCreate([0, Stream.Size - 1], varByte);
    pData := VarArrayLock(Temp);
    try
      Stream.Position := 0;
      Stream.Read(PData^, VarArrayHighBound(Temp, 1) + 1);
    finally
      VarArrayUnlock(Temp);
    end;
    Result := Temp;
  except
    on E: Exception do
    begin
      WriteErrorLog(E.Message);
      ShowMsg('执行PackageStream时出错。'#13 + E.Message, '提示', MB_OK);
    end;
  end;
end;

function downFile(SckConn: TSocketConnection; localFile,remoteFile:String):Integer;
var
  data:OleVariant;
  sm:TmemoryStream;
begin
  data := null;
  try
    //data := frmscandm.SocketConn.AppServer.loadFile(remoteFile);
    data := SckConn.AppServer.loadFile(remoteFile);
    if data=null then
    begin
      result:=0;
      exit;
    end;

  except
    on E: Exception do
    begin
      WriteErrorLog(E.Message);
      result:=0;
      exit;
    end;
  end;

  sm := TMemoryStream.Create;
  try
    try
      if not varisnull(data)  then
        begin
          UnpackStream(data, sm);

          ForceDirectories(ExtractFilePath(localFile));

          sm.SaveToFile(localFile);
          FileSetAttr(localFile,0);
        end;

    except
      if sm<>nil then sm.Free;
      raise;
      result:=0;
      exit;
    end;
  finally
    if sm<>nil then sm.Free;
  end;
  result:=1;
end;

function upFile(SckConn: TSocketConnection; localFile,remoteFile:String):Integer;
begin
  result:=1;
  try
    //frmscandm.SocketConn.AppServer.upFile(remoteFile,getData(localFile));
    SckConn.AppServer.upFile(remoteFile,getData(localFile));
  except
    on E: Exception do
    begin
      WriteErrorLog(E.Message);
      result:=0;
      exit;
    end;
  end;
end;

function deleteRemoteFile(SckConn: TSocketConnection; remoteFile:String):Integer;
var
  sRes: string;
begin
  result := 0;
  try
    //sRes := frmscandm.SocketConn.AppServer.delServerFile(remoteFile);
    sRes := SckConn.AppServer.delFile(remoteFile);
    Result := StrToInt(sRes);
  except
    on E: Exception do
    begin
      WriteErrorLog(E.Message);
      result:=0;
      exit;
    end;
  end;
end;

{
 st := SplitString('xxx@hoho.com', '@');
 则
 st[0] = 'xxx';
 st[1] = 'hoho.com';
}
Function SplitString(const source,ch:string):TStringList;
var
  temp, t2 : string;
  i : integer;
begin 
  result := TStringList.Create;
  temp := source;
  i := pos(ch,source);
  while i<>0 do begin
    t2 := copy(temp,0,i-1);
    if (t2<>'') then result.Add(t2);
    delete(temp,1,i-1+Length(ch));
    i:=pos(ch,temp);
  end;
  result.Add(temp);
end;

function split(s:string;dot:char):areaArray;
var
  str:areaArray;
  i,j:integer;
begin
  i:=1;
  j:=0;
  SetLength(str, 255);
  while Pos(dot, s) > 0 do
  begin
    str[j]:=copy(s,i,pos(dot,s)-i);
    i:=pos(dot,s)+1;
    s[i-1] := chr(ord(dot)+1);
    j:=j+1;
  end;
  str[j]:=copy(s,i,strlen(pchar(s))-i+1);
  result:=str;
end;

procedure  deleteLocalFile(fileName:String);   //删除本地文件
begin
  deleteFile(fileName);
end;

function  totalChar(s:String;sChar:char):Integer;   //统计字符串个数
var
  i:Integer;
  acount:Integer;
begin
  acount:=0;
  for i:=1 to length(s) do
  begin
    if (ord(s[i])=ord(sChar)) then  //当文本为英文字符时
    begin
      inc(acount);    //英文字符个数求和
    end
  end;
  totalChar:=acount;
end;

//得到编号
function getSerialNumber(amount:integer;value:String):String;
var
  leng,i:Integer;
  str:String;
begin
  leng:=Length(value);
  for i:=1 to amount-leng do
  begin
    str:=str+'0';
  end;
  getSerialNumber:=str+value;
end;

function OpenDataSet(qry: TADOQuery; sSQL: string; bShowPromot: Boolean): Boolean;
begin
  Result := False;
  try
    with qry do
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add(sSQL);
      qry.Open;
    end;
    Result := True;
  except
    on E: Exception do
    begin
      if bShowPromot then
      begin
        WriteErrorLog('SQL='+sSQL+',Error='+E.Message);
        ShowMsg('数据库操作失败！', '失败', MB_OK+MB_ICONWARNING);
        abort;
      end;
    end;  
  end;
end;

function ExcuteDataSet(qry: TADOQuery; sSQL: string; bShowPromot: Boolean): Boolean;
begin
  Result := False;
  try
    with qry do
    begin
      qry.Close;
      qry.SQL.Clear;
      qry.SQL.Add(sSQL);
      qry.ExecSQL;
    end;
    Result := True;
  except
    on E: Exception do
    begin
      WriteErrorLog('SQL='+sSQL+',Error='+E.Message);
      if bShowPromot then
      begin
        ShowMsg('数据库操作失败！', '失败', MB_OK+MB_ICONWARNING);
        abort;
      end;  
    end;
  end;
end;

function ShowMsg(Text, Caption: string; Flags: Longint): Integer;
begin
  result := Application.MessageBox(PChar(Text), PChar(Caption), Flags);
end;

//写错误文件，一个月一个ErrorLog
function WriteErrorLog(sError: string): boolean;
const
  ErrorPath='\Log';

var
  sFn: string;
  Logfile: TextFile;
begin
  Result := False;
  sError := '子模块'+ExtractFileName(application.ExeName) + '==>' +
    FormatDateTime('yyyy-mm-dd hh:nn:ss', Now) + ': ' + sError;
  sFn := GetAppPath()+ErrorPath+'\'+FormatDateTime('yyyy_mm', Now)+'.log';

  if FileExists(sFn) then
  begin
    AssignFile(Logfile, sFn);
    try
      Append(Logfile);
      Writeln(logfile, sError);
      Result := true;
    finally
      CloseFile(logfile);
    end;
  end
  else begin
    if not ForceDirectories(ExtractFilePath(sFn)) then exit;

    AssignFile(Logfile, sFn);
    try
      ReWrite(Logfile);
      Writeln(logfile, sError);
      Result := true;
    finally
      CloseFile(logfile);
    end;
  end;
end;

function GetNameFromValue(ls: TStrings; Value: string): string;
var
  k: Integer;
begin
  Result := '';
  for k := 0 to ls.Count - 1 do
  begin
    if ls.ValueFromIndex[k] = Value then
    begin
      Result := ls.Names[k];
      Exit;
    end;
  end;
end;

function ExcelInit(var ExcelApp:Variant;ExcelFile:String;visible:boolean):Boolean;
begin
  try
    ExcelApp := CreateOleObject('Excel.Application');
    ExcelApp.Visible := visible;
    ExcelApp.WorkBooks.Open(ExcelFile);     //打开excel文件
    result:=true;
  except
    result:=false;
  end;
end;

//设置Excel操作那个sheet页(从1开始的)
function ExcelSetActivate(var ExcelApp:Variant;value:Integer):Boolean;
begin
  try
    ExcelApp.WorkSheets[value].Activate;
    result:=true;
  except
    result:=false;
  end;
end;

//给Excel格子附值
function ExcelSetValue(var ExcelApp:Variant;x,y:Integer;value:String):Boolean;
begin
  try
    ExcelApp.Cells[x,y].Value := value;
    result:=true;
  except
    result:=false;
  end;
end;

//取Excel格子的值
function ExcelGetValue(var ExcelApp:Variant;x,y:Integer): string;
begin
  try
    result := Trim(ExcelApp.Cells[x,y].Value);
  except
    result:='';
  end;
end;

//保存Excel文件并且退出
function ExcelSaveAsAndQuit(var ExcelApp:Variant;ExcelFile:String):Boolean;
begin
  try
    ExcelApp.SaveAs(ExcelFile);
    ExcelApp.WorkBooks.Close;
    ExcelApp.Quit;
    result:=true;
  except
    result:=false;
  end;
end;

//保存Excel文件并且退出
function ExcelSaveAndQuit(var ExcelApp:Variant):Boolean;
begin
  try
    ExcelApp.ActiveWorkBook.save;
    ExcelApp.WorkBooks.Close;
    ExcelApp.Quit;
    result:=true;
  except
    result:=false;
  end;
end;

function ExcelSheetInsertRows(var ExcelApp:Variant; x: Integer): Boolean; //插入行
begin
  try
    ExcelApp.ActiveSheet.Rows[x].Insert;
    result:=true;
  except
    showmessage('Excel文件插入行出错！');
    result:=false;
  end;
end;

function ExcelSheetInsertColumns(var ExcelApp:Variant; y: Integer): Boolean; //在当前页插入列
begin
  try
    ExcelApp.ActiveSheet.Columns[y].Insert;
    result:=true;
  except
    showmessage('Excel文件插入列出错！');
    result:=false;
  end;
end;

function ExcelSheetDeleteRows(var ExcelApp:Variant; x: Integer): Boolean; //删除行
begin
  try
    ExcelApp.ActiveSheet.Rows[x].Delete;
    result:=true;
  except
    showmessage('Excel文件删除行出错！');
    result:=false;
  end;
end;

function ExcelSheetDeleteColumns(var ExcelApp:Variant; y: Integer): Boolean; //删除列
begin
  try
    ExcelApp.ActiveSheet.Columns[y].Delete;
    result:=true;
  except
    showmessage('Excel文件删除列出错！');
    result:=false;
  end;
end;

function ExcelMergeCells(var ExcelApp:Variant; x1, y1, x2, y2: Integer): Boolean; //合并单元格
begin
  try
    //ExcelApp.Range[ExcelApp.ActiveSheet.cells[x1,y1], ExcelApp.ActiveSheet.cells[x2,y2]].select;
    //ExcelApp.selection.MergeCells := true;
    ExcelApp.ActiveSheet.Range[ExcelApp.ActiveSheet.cells[x1,y1], ExcelApp.ActiveSheet.cells[x2,y2]].Merge;
    result:=true;
  except
    showmessage('Excel文件合并单元格出错！');
    result:=false;
  end;
end;

function DateExitx(edt: TSUIEdit): boolean;
var
  S: String;
begin
  Result := False;
  S := trim(edt.Text);
  if(s<>'') then
  begin
   try
     S := DateToStr(StrToDate(S)) ;
   except
     edt.Text := '';
     ShowMsg('日期错误！正确的输入格式为('+DateToStr(date)+')','错误',MB_OK+MB_ICONWarning);
     abort;
   end;
  end;
  Result := True;
end;

function MoneyToCn(ANumberic: Double): string;
const
  s1: string = '零壹贰叁肆伍陆柒捌玖';
  s2: string = '分角元拾佰仟万拾佰仟亿拾佰仟万';

  function StrTran(const S, s1, s2: string): string;
  begin
    Result := StringReplace(S, s1, s2, [rfReplaceAll]);
  end;

var
  S, dx: string;
  i, Len: Integer;

begin
  if ANumberic < 0 then
  begin
    dx := '负';
    ANumberic := -ANumberic;
  end;

  S := Format('%.0f', [ANumberic * 100]);
  Len := Length(S);
  for i := 1 to Len do
  begin
    dx := dx + Copy(s1, (Ord(S[i]) - Ord('0')) * 2 + 1, 2) + Copy(s2, (Len - i)* 2 + 1, 2);
  end;

  //dx := StrTran(StrTran(StrTran(StrTran(StrTran(dx, '零仟', '零'), '零佰','零'),'零拾', '零'), '零角', '零'), '零分', '整');
  //dx := StrTran(StrTran(StrTran(StrTran(StrTran(dx, '零零', '零'), '零零','零'),'零亿', '亿'), '零万', '万'), '零元', '元');

  dx := StrTran(dx, '零仟', '零');
  dx := StrTran(dx, '零佰', '零');
  dx := StrTran(dx, '零拾', '零');
  dx := StrTran(dx, '零角', '零');
  dx := StrTran(dx, '零分', '整');
  dx := StrTran(dx, '零零', '零');
  dx := StrTran(dx, '零零', '零');
  dx := StrTran(dx, '零亿', '亿');
  dx := StrTran(dx, '零万', '万');
  dx := StrTran(dx, '零元', '元');
  if dx = '整' then dx := '零元整'
  else begin
    dx := StrTran(dx, '亿万', '亿零');
    dx := StrTran(dx, '零整', '整');
  end;

  Result := dx;
end;

///////////////////////////////////////
function XMLInit(XMLDoc: TXMLDocument; XmlFn: string): Boolean;   //XML初始化，XmlFn为空则打开一个空的xml
begin
  Result := False;
  try
    if XmlFn <> '' then
    begin
      XMLDoc.LoadFromFile(XmlFn);
    end
    else begin
      XMLDoc.Options := XMLDoc.Options + [doNodeAutoIndent];
      XMLDoc.NodeIndentStr := '    ';  // 2个tab键
      XMLDoc.Active := True;
      XMLDoc.Encoding := 'GB2312';     //设置字符集
    end;

    Result := True;
  except
  end;
end;

function XMLSetRootNode(XMLDoc: TXMLDocument; RootName: string): Boolean;
var
  Root: IXMLNode;
begin
  Root := XMLDoc.CreateNode(RootName);
  XMLDoc.DocumentElement := Root;
  Result := True;
end;

function XMLAddNode(Parent: IXMLNode; Name, Text: string): IXMLNode;
begin
  Result := Parent.AddChild(Name);
  Result.Text := Text;
end;

function XMLGetText(Parent: IXMLNode; SubName: string): string;
var
  ChildNode: IXMLNode;
begin
  Result := '';
  ChildNode := XMLFindNodeEx(Parent, SubName);
  if ChildNode <> nil then Result := ChildNode.Text;
end;

function XMLAddNodeEx(Parent: IXMLNode; Name, AttrName, AttrText: string): IXMLNode;
begin
  Result := Parent.AddChild(Name);
  if AttrName <> '' then Result.Attributes[AttrName] := AttrText;
end;

function XMLFindNodeEx(Parent: IXMLNode; Name, AttrName, AttrText: string): IXMLNode;
var
  ChildNode: IXMLNode;
begin
  Result := nil;

  if AttrName = '' then Result := Parent.ChildNodes.FindNode(Name)
  else begin
    ChildNode := Parent.ChildNodes.First;
    while ChildNode <> nil do
    begin
      if (ChildNode.NodeName=Name) and (ChildNode.Attributes[AttrName]=AttrText) then
      begin
        Result := ChildNode;
        break;
      end;
      ChildNode := ChildNode.NextSibling;
    end;
  end;
end;


function XMLSaveAsAndQuit(XMLDoc: TXMLDocument; XmlFn: string): Boolean;
begin
  Result := False;
  try
    XMLDoc.SaveToFile(XmlFn);
    XMLDoc.Active := False;
    Result := True;
  except
  end;
end;

function XMLSaveAndOuit(XMLDoc: TXMLDocument): Boolean;
begin
  Result := False;
  try
    XMLDoc.Active := False;
    Result := True;
  except
  end;
end;

end.
