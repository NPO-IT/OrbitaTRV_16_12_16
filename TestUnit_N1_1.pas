unit TestUnit_N1_1;

interface
uses
  Dialogs,CommInt,SysUtils,IdSocketHandle,Visa_h,Messages,Forms,IniFiles,CommObjs;
var
  IniPeriphery: TIniFile;
  comm1:TComm;
  IP_POWER_SUPPLY_1,HostISD,RigolDg1022,V7_78,Transmille,ISDip:string;
  AkipV7_78_1,RigolDg1022_1,COMnum :string;
  //���� �������������� ����
  AkipOffOnState:Boolean;
  //�������� �OM �����
  ComPortTransmille:string;
  // ���� ��������������� ����� ������ ����� �� ��������� �������
  PowerRequest: Boolean;

  iResist:Integer=1;
  nResist:Integer=1;
  dResist:Integer=7;

  function Test_1_1_10_2():Boolean;
  function testOnAllTestDevices:Boolean;
  procedure changeResistance(Value:real);
  function iniRead():Boolean;
  function TestConnect(Name:string; var m_defaultRM_usbtmc_loc,
    m_instr_usbtmc_loc:Longword; vAtr:Longword; m_Timeout: integer):integer;
  function PowerTestConnect():Boolean ;
  function SetVoltageOnPowerSupply(NumberPowerSupply:integer;V:string):byte;
  function SetOnPowerSupply(NumberPowerSupply:integer):byte;
  procedure Delay_S(S:Integer);
implementation
  uses OrbitaAll;

//������� �������� ����������� Comm1
function ComTestConect():Boolean;
var
  falseFlag:Boolean;      // ���� ����������� ��� �������������
begin
  falseFlag:=True;        // ����������� ��� ��������
  try
      comm1.Open();       // ���������� ������������
  except
      on ECommError do    // ���� ���������� ������ �����������
      begin
          falseFlag:=False; // ���� � �����
          ShowMessage(ComPortTransmille+' ����������');
      end;
  end;
  if(falseFlag=True)  then // ���� ���� ������� �� ������� ���
  begin
      comm1.Close();
  end;
  Result:=falseFlag;
end;

//��������� ��������� �������������
//value- �������� � ��
procedure changeResistance(Value:real);
var
  buf:array[0..255] of char;
  i:integer;
  str:string;
begin
  str:=FloatToStr(Value);
  comm1.Open();
  for i:=0 to length(str)-1 do buf[i]:=str[i+1];
  buf[i]:=#13;
  buf[i+1]:=#10;
  comm1.Write(buf,i+2);
  comm1.Close;
end;

//�������� ������� ��������
function testOnAllTestDevices:Boolean;
var
  flagTestDev:Boolean;
  str:string;
begin
  flagTestDev:=True;

  //�������� ����������� �������� �������������
  if (not ComTestConect) then
  begin
    flagTestDev:=False;
    form1.Memo1.Lines.Add('������� ������������� �� ���������');
  end
  else
  begin
    form1.Memo1.Lines.Add('������� ������������� ���������');
  end;

  //�������� ����������� ����������
  if (TestConnect(AkipV7_78_1,m_defaultRM_usbtmc[0],m_instr_usbtmc[0],viAttr,Timeout)=-1) then
  begin
      form1.Memo1.Lines.Add('��������� �� ���������');
      flagTestDev:=False;
  end
  else
  begin
      form1.Memo1.Lines.Add('��������� ���������');
  end;


  //�������� ����������� ��������� �������
  if (PowerTestConnect) then
  begin
    form1.Memo1.Lines.Add('�������� ������� ����-1105 ���������');
    SetOnPowerSupply(1);
    SetVoltageOnPowerSupply(1,'0000');
    Delay_S(5);
    //�������� 27 �
    SetVoltageOnPowerSupply(1,'2700');
  end
  else
  begin
    form1.Memo1.Lines.Add('�������� ������� ����-1105 �� ���������');
    flagTestDev:=False;
  end;

  // �������� ��� --------------------------------------------------------------------------------------------------
  try
      //������ ������������ ������. ���� ����� ���� �� ��� ���� 
      str:=Form1.IdHTTP1.Get('http://'+ISDip);
  except
   Form1.Memo1.Lines.Add('��� �� ��������. ��������� �����������');
   flagTestDev:=False;
   //Exit;
  end;


  Form1.idpsrvr1.Active:=False;

  //�������� ����������� ����������
  {if (TestConnect(RigolDg1022_1,m_defaultRM_usbtmc[1],m_instr_usbtmc[1],viAttr,Timeout)=-1) then
  begin
      form1.Memo1.Lines.Add('��������� �� ���������'+#13#10);
      flag:=False;
  end
  else
  begin
      form1.Memo1.Lines.Add('��������� ���������'+#13#10);
  end;}

  

  Result:=flagTestDev;
end;


// -----------------------------------------------------------
// ��������� ������ � ���
// -----------------------------------------------------------
function GetDatStr(m_instr_usbtmc_loc:Longword; var dat:string):integer;
var
  i:integer;
  len:integer;
  status:integer;
  pStrin:vichar;
  nRead: integer;
  stbuffer:string;
begin
  dat:='';
  setlength(pStrin,64);
  sleep(45);//100
  len:= 64;
  status := viRead(m_instr_usbtmc_loc, pStrin, len, @nRead);
  if (nRead > 0) then
  begin
      stbuffer:='';
      for i:=0 to (nRead-1) do stbuffer:=stbuffer+pStrin[i];
  end;
  if(stbuffer='') then
  begin
      //form1.Memo1.Lines.Add('������ ���')
  end
  else
  begin
      dat:=floattostrf(strtofloat(stbuffer), fffixed, 5, 4);
  end;
end;
// ----------------------------------------------------------------


// -------------------------------------------------
// �������� � �������������
// -------------------------------------------------
procedure Delay_ms(ms:Integer);
begin
    sleep(ms);
    Application.ProcessMessages();
end;
// --------------------------------------------------
// �������� � ��������
// --------------------------------------------------
procedure Delay_S(S:Integer);
var
    i:Integer;
begin
    for i:=0 to (s*4) do                // ��������� ������� �� 250 ����������� ����� ��������� �� ���������
    begin
        sleep(250);
        Application.ProcessMessages();  // ����� �� ���������
    end;
end;
// ----------------------------------------------------
// ������� �������� ������� �� �������� �������
// ----------------------------------------------------
function SendCommandToPowerSupply(NumberPowerSupply:integer;Command:string):byte;
var
  pStrout:string;
begin
  pStrout:=Command+#13;
  if (NumberPowerSupply=1) then
  begin
    form1.idpsrvr1.Send(IP_POWER_SUPPLY_1,4001,pStrout);
  end;

end;
// -----------------------------------------------------
// ����� ��������� �� �������� �������
// -----------------------------------------------------
function ResetVoltageOnPowerSupply(NumberPowerSupply:integer):byte;
begin
  SendCommandToPowerSupply(NumberPowerSupply,'SOUT 0');
  sleep(100);
  SendCommandToPowerSupply(NumberPowerSupply,'VOLT 0'+'0000');
  sleep(100);
  SendCommandToPowerSupply(NumberPowerSupply,'CURR 0'+'0000');
  sleep(100);
end;
// ------------------------------------------------------
// �-�� ��������� ���������� �� �������� �������
// ------------------------------------------------------
function SetVoltageOnPowerSupply(NumberPowerSupply:integer;V:string):byte;
begin
    SendCommandToPowerSupply(NumberPowerSupply,'VOLT 0'+V);
    sleep(100);
end;
// -------------------------------------------------------
// �-�� ��������� ���� �� �������� �������
// -------------------------------------------------------
function SetCurrentOnPowerSupply(NumberPowerSupply:integer;A:string):byte;
begin
    SendCommandToPowerSupply(NumberPowerSupply,'CURR 0'+A);
    sleep(100);
end;
// --------------------------------------------------------
// �-�� ��������� ������ ON ��������� �������
// --------------------------------------------------------
function SetOnPowerSupply(NumberPowerSupply:integer):byte;
begin
    SendCommandToPowerSupply(NumberPowerSupply,'SOUT 1');
end;
// --------------------------------------------------------
// �-�� ��������� ������ ON ��������� �������
// --------------------------------------------------------
function TurnOFFPowerSupply(NumberPowerSupply:integer):byte;
begin
    SendCommandToPowerSupply(NumberPowerSupply,'SOUT 0');
    sleep(100);
end;
// ---------------------------------------------------------
// ������� �������� ����������� ��������� �������
// ---------------------------------------------------------
function PowerTestConnect():Boolean ;
begin
  AkipOffOnState:=false;
  //SetOnPowerSupply(1);
  SendCommandToPowerSupply(1, 'GETD'); // ������� ��� �����������
  Delay_S(5);
  if(AkipOffOnState=false) then
  begin
      Result:=False;
  end
  else
  begin
      Result:=True;
  end;
end;

function TestConnect(Name:string; var m_defaultRM_usbtmc_loc, m_instr_usbtmc_loc:Longword; vAtr:Longword; m_Timeout: integer):integer;
var
  status:integer;
  viAttr:Longword;

  m_findList_usbtmc: LongWord;
  m_nCount: LongWord;
  instrDescriptor:vichar;
begin
  setlength(instrDescriptor,255);

  result:=0;
  status:= viOpenDefaultRM(@m_defaultRM_usbtmc_loc);
  if (status < 0) then
  begin
    viClose(m_defaultRM_usbtmc_loc);
    m_defaultRM_usbtmc_loc:= 0;
        result:=-1;
        //  showmessage('       ��������� �������� �� ������!');
  end
  else
  begin
    status:= viFindRsrc(m_defaultRM_usbtmc_loc, name, @m_findList_usbtmc, @m_nCount, instrDescriptor);
    if (status < 0) then
    begin
      status:= viFindRsrc (m_defaultRM_usbtmc_loc, 'USB[0-9]*::5710::3501::?*INSTR', @m_findList_usbtmc, @m_nCount, instrDescriptor);
      if (status < 0) then
      begin
        viClose(m_defaultRM_usbtmc_loc);
        result:=-1;
            //    showmessage('       ��������� �������� �� ������!');
        m_defaultRM_usbtmc_loc:= 0;
        exit;
      end
      else
      begin
        viOpen(m_defaultRM_usbtmc_loc, instrDescriptor, 0, 0, @m_instr_usbtmc_loc);
        status:= viSetAttribute(m_instr_usbtmc_loc, vatr, m_Timeout);
      end
    end
    else
    begin
      status:= viOpen(m_defaultRM_usbtmc_loc, instrDescriptor, 0, 0, @m_instr_usbtmc_loc);
      status:= viSetAttribute(m_instr_usbtmc_loc, viAttr, m_Timeout);
    end
  end;

  result:=status;
end;

{function GetDatStr(m_instr_usbtmc_loc:Longword; var dat:string):integer;
var
  i:integer;
  len:integer;
  status:integer;
  pStrin:vichar;
  nRead: integer;
  stbuffer:string;
begin
  dat:='';
  setlength(pStrin,64);
  sleep(25);//100
  len:= 64;
  status := viRead(m_instr_usbtmc_loc, pStrin, len, @nRead);
  if (nRead > 0) then
  begin
    stbuffer:='';
    for i:=0 to (nRead-1) do stbuffer:=stbuffer+pStrin[i];
  end;
   if(stbuffer='') then form4.Memo1.Lines.Add('������ � ���������� ���')
   else   dat:=floattostrf(strtofloat(stbuffer), fffixed, 5, 4);
end;}

function SetConf(m_instr_usbtmc_loc:Longword; command:string):integer;
var
  pStrout:vichar;
  i:integer;
  nWritten:LongWord;
begin
  setlength(pStrout,64);
  for i:=0 to length(command) do  pStrout[i]:=command[i+1];
  result:= viWrite(m_instr_usbtmc_loc, pStrout, length(command), @nWritten);
  Sleep(30);
end;

procedure SendCommandToISD(str:string);
var
  st:string;
begin
  st:=form1.IdHTTP1.Get(str);
  if (st<>'������� ������� ���������!') then showmessage('�������� �������� �������� �� ��������!');
end;

// -------------------------------------------------------------
// ������� ��������� ������ �� ��� ���� ���
// -------------------------------------------------------------
procedure IsdConnectChanel(chanel:integer);
var
    num:string;
begin
    num:=IntToStr(chanel);
    SendCommandToISD('http://'+form1.IdHTTP1.Host+'/type=2num='+num+'val=1');
end;

// -------------------------------------------------------------
// ������� ���������� ������ �� ��� ���� ���
// -------------------------------------------------------------
procedure IsdDisconnectChanel(chanel:integer);
var
    num:string;
begin
    num:=IntToStr(chanel);
    SendCommandToISD('http://'+form1.idhttp1.Host+'/type=2num='+num+'val=0');
end;

function iniRead():Boolean;
var
  flag:Boolean;
  //str:string;
begin
  comm1:=Tcomm.Create({self}nil);
  flag:=True;
  //str:=ExtractFileDir(ParamStr(0))+'Periphery.ini';
  IniPeriphery:= TIniFile.Create(ExtractFileDir(ParamStr(0))+'\Periphery.ini');
  IP_POWER_SUPPLY_1:=IniPeriphery.ReadString('Device','IP_POWER_SUPPLY_1','-111');
  form1.idpsrvr1.DefaultPort:=StrToInt(IniPeriphery.ReadString('Device','port_POWER_SUPPLY_1','6008'));
  ISDip:=IniPeriphery.ReadString('Device','ISDip','-111');
  RigolDg1022_1:=IniPeriphery.ReadString('Device','RigolDg1022_1','-111');
  COMnum:=IniPeriphery.ReadString('Device','COM','-111');
  AkipV7_78_1:=IniPeriphery.ReadString('Device','AkipV7_78_1','USB[0-9]*::0x164E::0x0DAD::?*INSTR');
  Form1.idpsrvr1.Active:=True;
  if ((IP_POWER_SUPPLY_1='-111') or (ISDip='-111') or (RigolDg1022_1='-111') or (COMnum='-111')) then
  begin
    ShowMessage('����������� ��� ������������ ���� ������������ Periphery.ini');
    flag:=False;
  end
  else
  begin
    {form1.}comm1.DeviceName:=COMnum;
    form1.IdHTTP1.Host:=ISDip;
    Result:=flag;
  end;
end;


//�������� ����� N1-1
//����� 1.1.10.2
function Test_1_1_10_2():Boolean;
begin
  //��������� ������ ��������
  //�������� � ������ ��

  //�������� � ������ ��

  //��������� ������ ��������
  //�������� � ������ ��

  //�������� � ������ ��

  //changeResistance(2.0);
  //changeResistance(10.0);
  Result:=True;
end;
end.
