unit OrbitaAll;

interface

uses
  SysUtils,Windows, Messages,Variants, Classes, Graphics, Controls, Forms,
  Dialogs, IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient,
  IdHTTP, StdCtrls, Series, TeEngine, TeeProcs, Chart, ExtCtrls,
  Lusbapi,  Math, Buttons, ComCtrls, xpman, DateUtils,
  MPlayer,iniFiles,StrUtils,syncobjs,ExitForm, Gauges,TLMUnit,LibUnit,ACPUnit,UnitM16,
  OutUnit,UnitMoth,IdUDPBase, IdUDPServer,IdSocketHandle;
  //Lusbapi-���������� ��� ������ � ��� �20-10
  //Visa_h-���������� ��� ������ � ����������� � �����������


type
 TForm1 = class(TForm)
    GroupBox2: TGroupBox;
    GroupBox4: TGroupBox;
    OrbitaAddresMemo: TMemo;
    TimerOutToDia: TTimer;
    Memo1: TMemo;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel1: TPanel;
    diaSlowAnl: TChart;
    Series1: TBarSeries;
    diaSlowCont: TChart;
    Series3: TBarSeries;
    gistSlowAnl: TChart;
    upGistSlowSize: TButton;
    downGistSlowSize: TButton;
    Series2: TLineSeries;
    fastDia: TChart;
    Series4: TBarSeries;
    fastGist: TChart;
    Series11: TFastLineSeries;
    upGistFastSize: TButton;
    downGistFastSize: TButton;
    tlmWriteB: TButton;
    Label2: TLabel;
    Panel2: TPanel;
    TrackBar1: TTrackBar;
    LabelHeadF: TLabel;
    fileNameLabel: TLabel;
    OpenDialog1: TOpenDialog;
    PanelPlayer: TPanel;
    play: TSpeedButton;
    pause: TSpeedButton;
    stop: TSpeedButton;
    TimerPlayTlm: TTimer;
    startReadACP: TButton;
    startReadTlmB: TButton;
    tlmPSpeed: TTrackBar;
    Label2x: TLabel;
    Labelx: TLabel;
    Labelx2: TLabel;
    timeHeadLabel: TLabel;
    orbTimeLabel: TLabel;
    OpenDialog2: TOpenDialog;
    propB: TButton;
    saveAdrB: TButton;
    TabSheet3: TTabSheet;
    busDia: TChart;
    busGist: TChart;
    Series5: TBarSeries;
    Series6: TLineSeries;
    TimerOutToDiaBus: TTimer;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Timer1: TTimer;
    tmrForTestOrbSignal: TTimer;
    gProgress1: TGauge;
    gProgress2: TGauge;
    procentFalseMF1: TLabel;
    procentFalseMG: TLabel;
    ts3: TTabSheet;
    tempDia: TChart;
    Series7: TBarSeries;
    tempGist: TChart;
    lnsrsSeries8: TLineSeries;
    upGistTempSize: TButton;
    downGistTempSize: TButton;
    rb1: TRadioButton;
    rb2: TRadioButton;
    lbl1: TLabel;
    Button1: TButton;
    tmrCont: TTimer;
    procedure startReadACPClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure upGistSlowSizeClick(Sender: TObject);
    procedure downGistSlowSizeClick(Sender: TObject);
    procedure Series1Click(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TimerOutToDiaTimer(Sender: TObject);
    procedure upGistFastSizeClick(Sender: TObject);
    procedure downGistFastSizeClick(Sender: TObject);
    procedure tlmWriteBClick(Sender: TObject);
    procedure startReadTlmBClick(Sender: TObject);
    procedure Series4Click(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TimerPlayTlmTimer(Sender: TObject);
    procedure playClick(Sender: TObject);
    procedure pauseClick(Sender: TObject);
    procedure TrackBar1Change(Sender: TObject);
    procedure stopClick(Sender: TObject);
    procedure tlmPSpeedChange(Sender: TObject);
    procedure propBClick(Sender: TObject);
    procedure saveAdrBClick(Sender: TObject);
    procedure Series5Click(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure TimerOutToDiaBusTimer(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure tmrForTestOrbSignalTimer(Sender: TObject);
    procedure Series7Click(Sender: TChartSeries; ValueIndex: Integer;
      Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure upGistTempSizeClick(Sender: TObject);
    procedure downGistTempSizeClick(Sender: TObject);
    procedure tmrContTimer(Sender: TObject);
    procedure btnAutoTestClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;



  Tdata = class(TObject)
    //���� ��� ���������� ������ 1 ���
    //modC: boolean;
    //������� ��� ���������� ���������� ���������� ���
    masAnlBusChCount: integer;
    //������ ��� �������� �������� ���� ������.11 ������� �����
    {masGroup:array[1..SIZEMASGROUP] of word;}

    //������ ��� �������� �������� ���� ������.12 �����
    {masGroupAll:array[1..SIZEMASGROUP] of word;}
    //bool:boolean;
    //----------------------------------- M08,04,02,01
    //������� ����
    //fraseCount: integer;
    //������� �����
    //groupCount: integer;

    //7 ��������� �������� � 0 �� 127 ������ ������
    bufNumGroup:byte;
    //������� ����������� ���� ���
    iBusArray:integer;
    //���� ��� ������ ������� ��� ���. ������� ���
    flagWtoBusArray:boolean;
    procedure OutMG(errMG:Integer);
    //��������������� ��������� ��� ������ ������ �������� �����
    procedure TestSMFOutDate(numPointDown:Integer;numCurPoint:integer;numPointUp:integer);
    //���������� ��������� � ������ ��� ������ ������
    procedure ReInitialisation;
    //���������� ������
    //procedure SaveReport;
    //��� ������ � ��������� ������(������� �������� ���� �����(system))
    procedure WriteSystemInfo(value: string);
    //������� �������� �������� � ������� ������
    function AvrValue(firstOutPoint: integer; nextPointStep: integer;
      masGroupS: integer): integer;

    constructor CreateData;

    //m08,04,02,01
    //�������� ������ ����������� ������� (����� �����),
    function TestMarker(begNumPoint: integer; const pointCounter: integer): boolean;
    function BuildBusValue(highVal:word;lowerVal:word):word;
    function CollectBusArray(var iBusArray:integer):boolean;
  end;




var
  Form1: TForm1;

  //===================================
  //���������� ��� ������ � ���
  //===================================

  //=============================
  //��������� ��������.
  //=============================
  //RS485
  //���������� ��� �������� ip-������ �������� RS485 (ini-����)
  HostAdapterRS485: string;
  //���������� ��� �������� ������ ����� ��� ��������
  PortAdapterRS485: integer;
  //���1
  //���������� ��� �������� ip-������ ������� ��� (ini-����)
  HostISD1: string;
  //���2
  //���������� ��� �������� ip-������ ������� ��� (ini-����)
  HostISD2: string;
  //���������
  //���������� ��� �������� �������������� ����������
  RigolDg1022: string;
  //���������
  m_defaultRM_usbtmc, m_instr_usbtmc: array[0..3] of LongWord;
  viAttr: Longword = $3FFF001A;
  Timeout: integer = 1000; //7000
  //==============================

  //==============================
  //������ � �������
  //==============================
  //�������� ���������� ��� ������ � ��������� ������
  systemFile: Text;
  //�������� ���������� ��� ������������ ������ �������� � ����
  reportFile: Text;
  //���� ������ � ���
  LogFile: text;
  //==============================

  //����� ��� ������ � �������� ������
  //data: Tdata;

  dataM16:TDataM16;
  dataMoth:TDataMoth;

  //����� ��� ������ � TLM
  tlm: Ttlm;
  //����� ��� ������ � ���
  acp: Tacp;

  //����. ������ ��� ���������� �������
  masElemParam: array of channelOutParam;

  arrAddrOk:array of string;

  //������� ������ ������. ����� ������� ������
  iCountMax: integer;
  //���. ���������� �������
  acumAnalog: integer;
  //�����. ������������� �������
  acumTemp:Integer;
  //������� ���������� ����. ����������
  outTempAdr:Integer;
  //���. ����������
  acumContact: integer;
  //���. �������
  acumFast: integer;
  //���. ��� �������
  acumBus:integer;
  //���������� ����������� ���� � ������� ������ �� ���������������
  masGroupSize: integer;

  masGroup: array[1..SIZEMASGROUP] of word;
  masGroupAll: array[1..SIZEMASGROUP] of word;


  //������ � ���������������� ������
  infStr: string;



  //������� ��� �������� ������ ������
  countC: integer;

  //���������� ��� ini ����� ��� ����������� ���� ���������� ����� ��������
  propIniFile:TiniFile;
  propStrPath:string;


  flagEnd:boolean;

  //���� ��� 32-����. ����
  //swtFile:text;

  cOut:integer;
  csk:TCriticalSection;

  boolFlg:boolean;

  testOutFalg:boolean;

  //textTestFile:Text;
  //���� ��� ������ ������ �����
  orbOk:Boolean;
  orbOkCounter:integer;

  flagTrue:boolean;

  //������������ � ����������� �������� ������ � ���
  maxValue, minValue: integer;
implementation


//uses Unit1;

{$R *.dfm}

//==============================================================================
//��������� ���������� �� ����� � ����
//==============================================================================
//������������ ����� �����

{procedure SaveBitToLog(str: string);
begin
  Writeln(LogFile,str);
  exit
end;}
//==============================================================================

//==============================================================================
//
//==============================================================================
function AditTestAdrCorrect: boolean;
var
  i: integer;
  str: string;
  bool: boolean;
begin
  bool := true;
  //�������� �� ������������ �������
  for i := 0 to form1.OrbitaAddresMemo.Lines.Count - 1 do
  begin
    str := '';
    str := form1.OrbitaAddresMemo.Lines.Strings[i][1] +
    form1.OrbitaAddresMemo.Lines.Strings[i][2] +
    form1.OrbitaAddresMemo.Lines.Strings[i][3];
    if str = infStr then
    begin
    end
    else
    begin
      if  str<>'---' then
      begin
        bool := false;
        ShowMessage('����������� ������ �� �����. ��������� ���������������');
        break;
      end;
    end;
  end;
  result := bool;
end;
//==============================================================================


//==============================================================================
//
//==============================================================================
function GenTestAdrCorrect:boolean;
var
  i: integer;
  //������ � ������.
  str: string;
  masEcount: integer;
  rez:boolean;
begin
  rez:=false;
  //�������� �� ������������ ���� �������
  for i := 0 to form1.OrbitaAddresMemo.Lines.Count - 1 do
  begin
    str := '';
    str := form1.OrbitaAddresMemo.Lines.Strings[i][1] +
      form1.OrbitaAddresMemo.Lines.Strings[i][2]+form1.OrbitaAddresMemo.Lines.Strings[i][3];
    //�������� � �� ���������� �� ��� �����������
    if str = '---' then
    begin
      //�������� �� ��������� �������� �����
      Continue;
    end;

    if ((str = 'M16')or(str = 'M08')or(str = 'M04')or(str = 'M02')or(str = 'M01')) then
    begin
      //�������� ����������� ������� ������ �� ��������� ���������������
      case strToInt(str[2] + str[3]) of
        //M16
        16:
        begin
          infNum := 0;
          infStr := 'M16';
        end;
        //M08
        8:
        begin
          infNum := 1;
          infStr := 'M08';
        end;
        //M04
        4:
        begin
          infNum := 2;
          infStr := 'M04';
        end;
        //M02
        2:
        begin
          infNum := 3;
          infStr := 'M02';
        end;
        //M01
        1:
        begin
          infNum := 4;
          infStr := 'M01';
         end;
      end;
    end
    else
    begin
      //ShowMessage('��������� ������������ �������');
      //form1.OrbitaAddresMemo.Clear;
      rez:=false;
      break;
    end;

    if i = form1.OrbitaAddresMemo.Lines.Count - 1 then
    begin
      if {data.}AditTestAdrCorrect then
      begin
        form1.startReadACP.Enabled := true;
        form1.startReadTlmB.Enabled := true;
        //�������� ����������� ������� ������ �� ��������� ���������������
        //����� �������� ����. ��� ������ ������� ����� ��� �08,04,02,01
        case infNum of
          //M16
          0:
          begin
            masGroupSize := 2048;
          end;
          //M08
          1:
          begin
            masGroupSize := 1024;
            markKoef:=6.357828776;
            widthPartOfMF:=3;
            minSizeBetweenMrFrToMrFr:=1220;
          end;
          //M04
          2:
          begin
            masGroupSize := 512;
            markKoef:=12.715657552;
            widthPartOfMF:=6;
            minSizeBetweenMrFrToMrFr:=1220;//!!!
          end;
          //M02
          3:
          begin
            masGroupSize := 256;
            markKoef:=25.431315104;
            widthPartOfMF:=12;
            minSizeBetweenMrFrToMrFr:=1220;//!!!
          end;
          //M01
          4:
          begin
            masGroupSize := 128;
            markKoef:=50.862630020;
            widthPartOfMF:=25;
            minSizeBetweenMrFrToMrFr:=1220;//!!!
          end;
        end;

        //���������� ��������� � ������� ����� �� ���������������
        masCircleSize:=masGroupSize*32;


        //���. ����. �����. ������� ����� ������
        for masEcount := 1 to FIFOSIZE do
        begin
          fifoMas[masEcount] := 9;
        end;

        //�������� ������ ��� ������ ������ 11 ���. �� �������
        //SetLength(masGroup, masGroupSize);
        //�������� ������ ��� ������ ������ 12 ���. ��� ����� �������
        //SetLength(masGroupAll, masGroupSize);
        for masEcount := 1 to masGroupSize do
        begin
          masGroup[masEcount] := 9;
          masGroupAll[masEcount] := 9;
        end;


        //���. ��������� ����� ������. �������� ������ ������� �����
        //0 �����
        {data.}reqArrayOfCircle := 0;
        //SetLength(masCircle[data.reqArrayOfCircle], masGroupSize * 32);
        //form1.Memo1.Lines.Add(intToStr(length(masCircle[reqArrayOfCircle])));
        //����. ������� �����
        for masEcount := 1 to masGroupSize * 32 do
        begin
          masCircle[{data.}reqArrayOfCircle][masEcount] := 9;
        end;

        rez:=true;
      end;
    end;
  end;
  result:=rez;
end;
//==============================================================================

//==============================================================================
//��������� ��� �������� ������� ����� ������� � ������� ����
//==============================================================================

procedure CountAddres;
var
  //������� �������� ���� ���������� �������
  adrCount: integer;
  masElemParamLen:integer;
begin
  adrCount := 0;
  masElemParamLen:=length(masElemParam);
  while adrCount <=masElemParamLen  - 1 do
  begin
    case masElemParam[adrCount].adressType of
      0,8:
      begin
        //����������  T01,T01-01(9 ����.)
        inc(acumAnalog);
      end;
      1:
      begin
        //����������
        inc(acumContact);
      end;
      2, 3, 4, 5:
      begin
        //�������
        inc(acumFast);
      end;
      6:
      begin
        //���
        inc(acumBus);
      end;
      7:
      begin
        //�������������
        inc(acumTemp);
      end;
    end;
    inc(adrCount);
  end;


  //�������� ������ ��� ������ ��������� ���������� �������
  SetLength(slowArr,acumAnalog);
  //�������� ������ ��� ������ ���������� ����������
  SetLength(contArr,acumContact);
  //�������� ������ ��� ������ ������������� ����������, ��� ��� ��� ��������� ��������
  SetLength(tempArr,acumTemp);
end;
//==============================================================================

//==============================================================================
//���������� ������� ������� �����
//==============================================================================
procedure FillGroupArr(iArrElemPar:Integer;var fNum:Integer;var stepNum:Integer);
const
  MAXGROUPNUM=32;
var
  i:Integer;
  iG:Integer;
  fElemGr:Integer;
  sElemGr:Integer;
  fNumGr:Integer;
  sNumGr:Integer;
begin
  masElemParam[iArrElemPar].flagGroup:=True;
  i:=0;
  fElemGr:=fNum;
  //������ ����� ������ ������
  fNumGr:=Trunc(fElemGr/masGroupSize)+1;
  //���� ������ ������� ��������� �� � ������ ������,
  //�� ��������� ����� ������ � ������ ������������� �� �� ������
  if fElemGr>masGroupSize then
  begin
    fNum:=fElemGr-((fNumGr-1)*masGroupSize);
  end;

  sElemGr:=stepNum;
  //�������� �� ���� ������
  sNumGr:=Trunc(sElemGr/masGroupSize);
  iG:=fNumGr;
  SetLength(masElemParam[iArrElemPar].arrNumGroup,i+1);
  masElemParam[iArrElemPar].arrNumGroup[i]:=iG;
  Inc(i);
  iG:=iG+sNumGr;
  //��������� ������ �� ������� ��� ������������ ����� ����� 4
  while iG<=MAXGROUPNUM do
  begin
    SetLength(masElemParam[iArrElemPar].arrNumGroup,i+1);
    masElemParam[iArrElemPar].arrNumGroup[i]:=iG;
    iG:=iG+sNumGr;
    Inc(i);
  end;
end;
//==============================================================================

//==============================================================================
//��������� ��� ��������� ��������� ������� ��� �������� �� ������ ���������� ������
//==============================================================================
procedure slowAdrCorrection;
var
  i:Integer;
  j:Integer;
  masElemParamLen:integer;

  arrNumbersCikl:array[1..200] of integer;
  iCikl:Integer;
  //flagCikl:Boolean;
  iMinCiklNumber:Integer;
  minCiklNumber:Integer;
  arrCikl:array of Integer;
  maxAdrStepCikl:Integer;

  arrNumbersGr:array[1..200] of integer;
  iGr:Integer;
  //flagGr:Boolean;
  iMinGrNumber:Integer;
  minGrNumber:Integer;
  arrGr:array of Integer;
  maxAdrStepGr:Integer;
begin
  masElemParamLen:=length(masElemParam);
  iGr:=1;
  iCikl:=1;

  if ((vSlowFlagGr)and(vSlowFlagCikl)) then
  begin
    // ������� �� ���� ������� ��������� ������ ����������� �� ���������� ������
    // ���������� �����
    //������������ � ���� ������ ��� ������ ������� � �������� �� ���������� �����
    //� ������
    for i:=0 to masElemParamLen-1 do
    begin
      if ((masElemParam[i].adressType=0)or(masElemParam[i].adressType=8)) then
      begin
        if masElemParam[i].flagCikl then
        begin
          arrNumbersCikl[iCikl]:=i;
          inc(iCikl);
        end;

        if masElemParam[i].flagGroup then
        begin
          arrNumbersGr[iGr]:=i;
          inc(iGr);
        end;
      end;
    end;

    //����
    //���� ��� ��������� ����������� ����������� ������ � �������
    minCiklNumber:=Length(masElemParam[arrNumbersCikl[1]].arrNumCikl);
    //� ������� ������������ �������� � �������
    maxAdrStepCikl:=masElemParam[arrNumbersCikl[1]].stepOutG;

    iMinCiklNumber:=arrNumbersCikl[1];

    //�������� �� ���� ������� � ������ ����������� ���������� �����
    for i:=2 to iCikl-1 do
    begin
      if  minCiklNumber>Length(masElemParam[arrNumbersCikl[i]].arrNumCikl) then
      begin
        minCiklNumber:=Length(masElemParam[arrNumbersCikl[i]].arrNumCikl);
        iMinCiklNumber:=arrNumbersCikl[i];
      end;

      if maxAdrStepCikl<masElemParam[arrNumbersCikl[i]].stepOutG then
      begin
        //����������� �������� ������������� �������� ��� ������� ����� �� ������ ������
        maxAdrStepCikl:=masElemParam[arrNumbersCikl[i]].stepOutG;
      end;
    end;




    {if  iCikl-1<2 then
    begin
      iMinCiklNumber:=arrNumbersCikl[1];
    end;}

    //������
    //���� ��� ��������� ����������� ����������� ����� � �������
    minGrNumber:=Length(masElemParam[arrNumbersGr[1]].arrNumGroup);
    //� ������� ������������ �������� � �������
    maxAdrStepGr:=masElemParam[arrNumbersGr[1]].stepOutG;

    iMinGrNumber:=arrNumbersGr[1];
    
    //�������� �� ���� ������� � ������ ����������� ���������� �����
    for i:=2 to iGr-1 do
    begin
      if  minGrNumber>Length(masElemParam[arrNumbersGr[i]].arrNumGroup) then
      begin
        minGrNumber:=Length(masElemParam[arrNumbersGr[i]].arrNumGroup);
        iMinGrNumber:=arrNumbersGr[i];
      end;

      if maxAdrStepGr<masElemParam[arrNumbersGr[i]].stepOutG then
      begin
        //����������� �������� ������������� �������� ��� ������� ����� �� ������ ������
        maxAdrStepGr:=masElemParam[arrNumbersGr[i]].stepOutG;
      end;
    end;

    {if  iGr-1<2 then
    begin
      iMinGrNumber:=arrNumbersGr[1];
    end;}

    //����� ����������� ���������� ������ ��� ������� ������ ���������
    //��������� ���� �� ���� ��������� � �������� �� ��� � ������ ����������
    for i:=0 to masElemParamLen-1 do
    begin
      if ((masElemParam[i].adressType=0)or(masElemParam[i].adressType=8)) then
      begin
        //������� �� �����. ������ ����������
        masElemParam[i].flagCikl:=true;
        //������� �� �����. ����� �� ����������
        masElemParam[i].flagGroup:=true;
        //������������ ��� �������� ��� ���� ������� ��������� ������������
        if  maxAdrStepCikl>maxAdrStepGr then
        begin
          masElemParam[i].stepOutG:=maxAdrStepCikl;
        end
        else
        begin
          masElemParam[i].stepOutG:=maxAdrStepGr;
        end;


        //����
        //��������� ���� �� � ������� ������� ������ ��������
        if (masElemParam[i].arrNumCikl<>nil) then
        begin
          //���������� �� ��������� ������ ����������� ����� �����(�����) ��� ������ ������
          for j:=0 to minCiklNumber-1 do
          begin
            SetLength(arrCikl,j+1);
            arrCikl[j]:=masElemParam[i].arrNumCikl[j];
          end;
          //�������� ������ ��� ��� ���������� � ����
          masElemParam[i].arrNumCikl:=nil;
          //�������������� ������ ����� ��� ������� �� ����� ������� ���������� �� ������ ����
          for j:=0 to minCiklNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumCikl,j+1);
            masElemParam[i].arrNumCikl[j]:=arrCikl[j];
          end;
          arrCikl:=nil;
        end
        else
        begin
          //��� ���������.
          for j:=0 to minCiklNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumCikl,j+1);
            masElemParam[i].arrNumCikl[j]:= masElemParam[iMinCiklNumber].arrNumCikl[j];
          end;
        end;

        //������
        //��������� ���� �� � ������� ������� ����� ��������
        if (masElemParam[i].arrNumGroup<>nil) then
        begin
          //���� ��������. ��������� �� ����������� ����������
          //���������� �� ��������� ������ ����������� ����� �����(�����) ��� ������� ������
          for j:=0 to minGrNumber-1 do
          begin
            SetLength(arrGr,j+1);
            arrGr[j]:=masElemParam[i].arrNumGroup[j];
          end;

          //�������� ������ ��� ��� ���������� � ����
          masElemParam[i].arrNumGroup:=nil;
          //�������������� ������ ����� ��� ������� �� ����� ������� ���������� �� ������ ����
          for j:=0 to minGrNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumGroup,j+1);
            masElemParam[i].arrNumGroup[j]:=arrGr[j];
          end;
          arrGr:=nil;
        end
        else
        begin
          //��� ���������.
          for j:=0 to minGrNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumGroup,j+1);
            masElemParam[i].arrNumGroup[j]:= masElemParam[iMinGrNumber].arrNumGroup[j];
          end;
        end;

      end;
    end;

  end
  else if ((not vSlowFlagGr)and(vSlowFlagCikl)) then
  begin
    //������� ���������� �� ���������� ������, ���� �����
    //������������ � ���� ������ ��� ������ ������� � �������� �� ���������� �����
    for i:=0 to masElemParamLen-1 do
    begin
      if ((masElemParam[i].adressType=0)or(masElemParam[i].adressType=8)) then
      begin
        if masElemParam[i].flagCikl then
        begin
          arrNumbersCikl[iCikl]:=i;
          inc(iCikl);
        end;
      end;
    end;

    //���� ��� ��������� ����������� ����������� ����� � �������
    minCiklNumber:=Length(masElemParam[arrNumbersCikl[1]].arrNumCikl);
    //� ������� ������������ �������� � �������
    maxAdrStepCikl:=masElemParam[arrNumbersCikl[1]].stepOutG;
    iMinCiklNumber:=arrNumbersCikl[1];
    //�������� �� ���� ������� � ������ ����������� ���������� �����
    for i:=2 to iCikl-1 do
    begin
      if  minCiklNumber>Length(masElemParam[arrNumbersCikl[i]].arrNumCikl) then
      begin
        minCiklNumber:=Length(masElemParam[arrNumbersCikl[i]].arrNumCikl);
        iMinCiklNumber:=arrNumbersCikl[i];
      end;

      if maxAdrStepCikl<masElemParam[arrNumbersCikl[i]].stepOutG then
      begin
        //����������� �������� ������������� �������� ��� ������� ����� �� ������ ������
        maxAdrStepCikl:=masElemParam[arrNumbersCikl[i]].stepOutG;
      end;
    end;

    {if  iCikl-1<2 then
    begin
      iMinCiklNumber:=arrNumbersCikl[1];
    end;}

    //����� ����������� ���������� ������ ��� ������� ������ ���������
    //��������� ���� �� ���� ��������� � �������� �� ��� � ������ ����������
    for i:=0 to masElemParamLen-1 do
    begin
      if ((masElemParam[i].adressType=0)or(masElemParam[i].adressType=8)) then
      begin
        //������� �� �����. ������ ����������
        masElemParam[i].flagCikl:=true;
        //������� �� �����. ����� �� ����������
        masElemParam[i].flagGroup:=false;
        //������������ ��� �������� ��� ���� ������� ��������� ������������
        masElemParam[i].stepOutG:=maxAdrStepCikl;


        //��������� ���� �� � ������� ������� ������ ��������
        if (masElemParam[i].arrNumCikl<>nil) then
        begin
          //���������� �� ��������� ������ ����������� ����� �����(�����) ��� ������ ������
          for j:=0 to minCiklNumber-1 do
          begin
            SetLength(arrCikl,j+1);
            arrCikl[j]:=masElemParam[i].arrNumCikl[j];
          end;
          //�������� ������ ��� ��� ���������� � ����
          masElemParam[i].arrNumCikl:=nil;
          //�������������� ������ ����� ��� ������� �� ����� ������� ���������� �� ������ ����
          for j:=0 to minCiklNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumCikl,j+1);
            masElemParam[i].arrNumCikl[j]:=arrCikl[j];
          end;
          arrCikl:=nil;
        end
        else
        begin
          //��� ���������.
          for j:=0 to minCiklNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumCikl,j+1);
            masElemParam[i].arrNumCikl[j]:= masElemParam[iMinCiklNumber].arrNumCikl[j];
          end;
        end;
      end;
    end;
  end
  else
  begin
    //������� ���������� �� ���������� ����� ���� ������
    //������������ � ���� ������ ��� ������ ������� � �������� �� ���������� �����
    for i:=0 to masElemParamLen-1 do
    begin
      if ((masElemParam[i].adressType=0)or(masElemParam[i].adressType=8)) then
      begin
        if masElemParam[i].flagGroup then
        begin
          arrNumbersGr[iGr]:=i;
          inc(iGr);
        end;
      end;
    end;

    //���� ��� ��������� ����������� ����������� ����� � �������
    minGrNumber:=Length(masElemParam[arrNumbersGr[1]].arrNumGroup);
    //� ������� ������������ �������� � �������
    maxAdrStepGr:=masElemParam[arrNumbersGr[1]].stepOutG;

    iMinGrNumber:=arrNumbersGr[1];

    //�������� �� ���� ������� � ������ ����������� ���������� �����
    for i:=2 to iGr-1 do
    begin
      if  minGrNumber>Length(masElemParam[arrNumbersGr[i]].arrNumGroup) then
      begin
        minGrNumber:=Length(masElemParam[arrNumbersGr[i]].arrNumGroup);
        iMinGrNumber:=arrNumbersGr[i];
      end;

      if maxAdrStepGr<masElemParam[arrNumbersGr[i]].stepOutG then
      begin
        //����������� �������� ������������� �������� ��� ������� ����� �� ������ ������
        maxAdrStepGr:=masElemParam[arrNumbersGr[i]].stepOutG;
      end;
    end;

   { if  iGr-1<2 then
    begin
      iMinGrNumber:=arrNumbersGr[1];
    end;}

    //����� ����������� ���������� ����� ��� ������� ������ ���������
    //��������� ���� �� ���� ��������� � �������� �� ��� � ������ ����������
    for i:=0 to masElemParamLen-1 do
    begin
      if ((masElemParam[i].adressType=0)or(masElemParam[i].adressType=8)) then
      begin
        //������� �� �����. ������ �� ����������
        masElemParam[i].flagCikl:=false;
        //������� �� �����. ����� ����������
        masElemParam[i].flagGroup:=true;
        //������������ ��� �������� ��� ���� ������� ��������� ������������
        masElemParam[i].stepOutG:=maxAdrStepGr;

        //��������� ���� �� � ������� ������� ����� ��������
        if (masElemParam[i].arrNumGroup<>nil) then
        begin
          //���� ��������. ��������� �� ����������� ����������
          //���������� �� ��������� ������ ����������� ����� �����(�����) ��� ������� ������
          for j:=0 to minGrNumber-1 do
          begin
            SetLength(arrGr,j+1);
            arrGr[j]:=masElemParam[i].arrNumGroup[j];
          end;

          //�������� ������ ��� ��� ���������� � ����
          masElemParam[i].arrNumGroup:=nil;
          //�������������� ������ ����� ��� ������� �� ����� ������� ���������� �� ������ ����
          for j:=0 to minGrNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumGroup,j+1);
            masElemParam[i].arrNumGroup[j]:=arrGr[j];
          end;
          arrGr:=nil;
        end
        else
        begin
          //��� ���������.
          for j:=0 to minGrNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumGroup,j+1);
            masElemParam[i].arrNumGroup[j]:= masElemParam[iMinGrNumber].arrNumGroup[j];
          end;
        end;
      end;
    end;
  end;
end;
//==============================================================================


//==============================================================================
//��������� ��� ��������� ���������� ������� ��� �������� �� ������ ���������� ������
//==============================================================================
procedure contAdrCorrection;
var
  i:Integer;
  j:Integer;
  masElemParamLen:integer;

  arrNumbersCikl:array[1..200] of integer;
  iCikl:Integer;
  //flagCikl:Boolean;
  iMinCiklNumber:Integer;
  minCiklNumber:Integer;
  arrCikl:array of Integer;
  maxAdrStepCikl:Integer;

  arrNumbersGr:array[1..200] of integer;
  iGr:Integer;
  //flagGr:Boolean;
  iMinGrNumber:Integer;
  minGrNumber:Integer;
  arrGr:array of Integer;
  maxAdrStepGr:Integer;
begin
  masElemParamLen:=length(masElemParam);
  iGr:=1;
  iCikl:=1;

  if ((vSlowFlagGr)and(vSlowFlagCikl)) then
  begin
    // ������� �� ���� ������� ��������� ������ ����������� �� ���������� ������
    // ���������� �����
    //������������ � ���� ������ ��� ������ ������� � �������� �� ���������� �����
    //� ������
    for i:=0 to masElemParamLen-1 do
    begin
      if masElemParam[i].adressType=1 then
      begin
        if masElemParam[i].flagCikl then
        begin
          arrNumbersCikl[iCikl]:=i;
          inc(iCikl);
        end;

        if masElemParam[i].flagGroup then
        begin
          arrNumbersGr[iGr]:=i;
          inc(iGr);
        end;
      end;
    end;

    //����
    //���� ��� ��������� ����������� ����������� ������ � �������
    minCiklNumber:=Length(masElemParam[arrNumbersCikl[1]].arrNumCikl);
    //� ������� ������������ �������� � �������
    maxAdrStepCikl:=masElemParam[arrNumbersCikl[1]].stepOutG;

    iMinCiklNumber:=arrNumbersCikl[1];

    //�������� �� ���� ������� � ������ ����������� ���������� �����
    for i:=2 to iCikl-1 do
    begin
      if  minCiklNumber>Length(masElemParam[arrNumbersCikl[i]].arrNumCikl) then
      begin
        minCiklNumber:=Length(masElemParam[arrNumbersCikl[i]].arrNumCikl);
        iMinCiklNumber:=arrNumbersCikl[i];
      end;

      if maxAdrStepCikl<masElemParam[arrNumbersCikl[i]].stepOutG then
      begin
        //����������� �������� ������������� �������� ��� ������� ����� �� ������ ������
        maxAdrStepCikl:=masElemParam[arrNumbersCikl[i]].stepOutG;
      end;
    end;

    {if  iCikl-1<2 then
    begin
      iMinCiklNumber:=arrNumbersCikl[1];
    end;}

    //������
    //���� ��� ��������� ����������� ����������� ����� � �������
    minGrNumber:=Length(masElemParam[arrNumbersGr[1]].arrNumGroup);
    //� ������� ������������ �������� � �������
    maxAdrStepGr:=masElemParam[arrNumbersGr[1]].stepOutG;

    iMinGrNumber:=arrNumbersGr[1];

    //�������� �� ���� ������� � ������ ����������� ���������� �����
    for i:=2 to iGr-1 do
    begin
      if  minGrNumber>Length(masElemParam[arrNumbersGr[i]].arrNumGroup) then
      begin
        minGrNumber:=Length(masElemParam[arrNumbersGr[i]].arrNumGroup);
        iMinGrNumber:=arrNumbersGr[i];
      end;

      if maxAdrStepGr<masElemParam[arrNumbersGr[i]].stepOutG then
      begin
        //����������� �������� ������������� �������� ��� ������� ����� �� ������ ������
        maxAdrStepGr:=masElemParam[arrNumbersGr[i]].stepOutG;
      end;
    end;

    {if  iGr-1<2 then
    begin
      iMinGrNumber:=arrNumbersGr[1];
    end;}

    //����� ����������� ���������� ������ ��� ������� ������ ���������
    //��������� ���� �� ���� ��������� � �������� �� ��� � ������ ����������
    for i:=0 to masElemParamLen-1 do
    begin
      if masElemParam[i].adressType=1 then
      begin
        //������� �� �����. ������ ����������
        masElemParam[i].flagCikl:=true;
        //������� �� �����. ����� �� ����������
        masElemParam[i].flagGroup:=true;
        //������������ ��� �������� ��� ���� ������� ��������� ������������
        if  maxAdrStepCikl>maxAdrStepGr then
        begin
          masElemParam[i].stepOutG:=maxAdrStepCikl;
        end
        else
        begin
          masElemParam[i].stepOutG:=maxAdrStepGr;
        end;


        //����
        //��������� ���� �� � ������� ������� ������ ��������
        if (masElemParam[i].arrNumCikl<>nil) then
        begin
          //���������� �� ��������� ������ ����������� ����� �����(�����) ��� ������ ������
          for j:=0 to minCiklNumber-1 do
          begin
            SetLength(arrCikl,j+1);
            arrCikl[j]:=masElemParam[i].arrNumCikl[j];
          end;
          //�������� ������ ��� ��� ���������� � ����
          masElemParam[i].arrNumCikl:=nil;
          //�������������� ������ ����� ��� ������� �� ����� ������� ���������� �� ������ ����
          for j:=0 to minCiklNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumCikl,j+1);
            masElemParam[i].arrNumCikl[j]:=arrCikl[j];
          end;
          arrCikl:=nil;
        end
        else
        begin
          //��� ���������.
          for j:=0 to minCiklNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumCikl,j+1);
            masElemParam[i].arrNumCikl[j]:= masElemParam[iMinCiklNumber].arrNumCikl[j];
          end;
        end;

        //������
        //��������� ���� �� � ������� ������� ����� ��������
        if (masElemParam[i].arrNumGroup<>nil) then
        begin
          //���� ��������. ��������� �� ����������� ����������
          //���������� �� ��������� ������ ����������� ����� �����(�����) ��� ������� ������
          for j:=0 to minGrNumber-1 do
          begin
            SetLength(arrGr,j+1);
            arrGr[j]:=masElemParam[i].arrNumGroup[j];
          end;

          //�������� ������ ��� ��� ���������� � ����
          masElemParam[i].arrNumGroup:=nil;
          //�������������� ������ ����� ��� ������� �� ����� ������� ���������� �� ������ ����
          for j:=0 to minGrNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumGroup,j+1);
            masElemParam[i].arrNumGroup[j]:=arrGr[j];
          end;
          arrGr:=nil;
        end
        else
        begin
          //��� ���������.
          for j:=0 to minGrNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumGroup,j+1);
            masElemParam[i].arrNumGroup[j]:= masElemParam[iMinGrNumber].arrNumGroup[j];
          end;
        end;

      end;
    end;

  end
  else if ((not vSlowFlagGr)and(vSlowFlagCikl)) then
  begin
    //������� ���������� �� ���������� ������, ���� �����
    //������������ � ���� ������ ��� ������ ������� � �������� �� ���������� �����
    for i:=0 to masElemParamLen-1 do
    begin
      if masElemParam[i].adressType=1 then
      begin
        if masElemParam[i].flagCikl then
        begin
          arrNumbersCikl[iCikl]:=i;
          inc(iCikl);
        end;
      end;
    end;

    //���� ��� ��������� ����������� ����������� ����� � �������
    minCiklNumber:=Length(masElemParam[arrNumbersCikl[1]].arrNumCikl);
    //� ������� ������������ �������� � �������
    maxAdrStepCikl:=masElemParam[arrNumbersCikl[1]].stepOutG;

    iMinCiklNumber:=arrNumbersCikl[1];

    //�������� �� ���� ������� � ������ ����������� ���������� �����
    for i:=2 to iCikl-1 do
    begin
      if  minCiklNumber>Length(masElemParam[arrNumbersCikl[i]].arrNumCikl) then
      begin
        minCiklNumber:=Length(masElemParam[arrNumbersCikl[i]].arrNumCikl);
        iMinCiklNumber:=arrNumbersCikl[i];
      end;

      if maxAdrStepCikl<masElemParam[arrNumbersCikl[i]].stepOutG then
      begin
        //����������� �������� ������������� �������� ��� ������� ����� �� ������ ������
        maxAdrStepCikl:=masElemParam[arrNumbersCikl[i]].stepOutG;
      end;
    end;

    {if  iCikl-1<2 then
    begin
      iMinCiklNumber:=arrNumbersCikl[1];
    end;}

    //����� ����������� ���������� ������ ��� ������� ������ ���������
    //��������� ���� �� ���� ��������� � �������� �� ��� � ������ ����������
    for i:=0 to masElemParamLen-1 do
    begin
      if masElemParam[i].adressType=1 then
      begin
        //������� �� �����. ������ ����������
        masElemParam[i].flagCikl:=true;
        //������� �� �����. ����� �� ����������
        masElemParam[i].flagGroup:=false;
        //������������ ��� �������� ��� ���� ������� ��������� ������������
        masElemParam[i].stepOutG:=maxAdrStepCikl;


        //��������� ���� �� � ������� ������� ������ ��������
        if (masElemParam[i].arrNumCikl<>nil) then
        begin
          //���������� �� ��������� ������ ����������� ����� �����(�����) ��� ������ ������
          for j:=0 to minCiklNumber-1 do
          begin
            SetLength(arrCikl,j+1);
            arrCikl[j]:=masElemParam[i].arrNumCikl[j];
          end;
          //�������� ������ ��� ��� ���������� � ����
          masElemParam[i].arrNumCikl:=nil;
          //�������������� ������ ����� ��� ������� �� ����� ������� ���������� �� ������ ����
          for j:=0 to minCiklNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumCikl,j+1);
            masElemParam[i].arrNumCikl[j]:=arrCikl[j];
          end;
          arrCikl:=nil;
        end
        else
        begin
          //��� ���������.
          for j:=0 to minCiklNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumCikl,j+1);
            masElemParam[i].arrNumCikl[j]:= masElemParam[iMinCiklNumber].arrNumCikl[j];
          end;
        end;
      end;
    end;
  end
  else
  begin
    //������� ���������� �� ���������� ����� ���� ������
    //������������ � ���� ������ ��� ������ ������� � �������� �� ���������� �����
    for i:=0 to masElemParamLen-1 do
    begin
      if masElemParam[i].adressType=1 then
      begin
        if masElemParam[i].flagGroup then
        begin
          arrNumbersGr[iGr]:=i;
          inc(iGr);
        end;
      end;
    end;

    //���� ��� ��������� ����������� ����������� ����� � �������
    minGrNumber:=Length(masElemParam[arrNumbersGr[1]].arrNumGroup);
    //� ������� ������������ �������� � �������
    maxAdrStepGr:=masElemParam[arrNumbersGr[1]].stepOutG;

    iMinGrNumber:=arrNumbersGr[1];

    //�������� �� ���� ������� � ������ ����������� ���������� �����
    for i:=2 to iGr-1 do
    begin
      if  minGrNumber>Length(masElemParam[arrNumbersGr[i]].arrNumGroup) then
      begin
        minGrNumber:=Length(masElemParam[arrNumbersGr[i]].arrNumGroup);
        iMinGrNumber:=arrNumbersGr[i];
      end;

      if maxAdrStepGr<masElemParam[arrNumbersGr[i]].stepOutG then
      begin
        //����������� �������� ������������� �������� ��� ������� ����� �� ������ ������
        maxAdrStepGr:=masElemParam[arrNumbersGr[i]].stepOutG;
      end;
    end;

    {if  iGr-1<2 then
    begin
      iMinGrNumber:=arrNumbersGr[1];
    end;}

    //����� ����������� ���������� ����� ��� ������� ������ ���������
    //��������� ���� �� ���� ��������� � �������� �� ��� � ������ ����������
    for i:=0 to masElemParamLen-1 do
    begin
      if masElemParam[i].adressType=1 then
      begin
        //������� �� �����. ������ �� ����������
        masElemParam[i].flagCikl:=false;
        //������� �� �����. ����� ����������
        masElemParam[i].flagGroup:=true;
        //������������ ��� �������� ��� ���� ������� ��������� ������������
        masElemParam[i].stepOutG:=maxAdrStepGr;

        //��������� ���� �� � ������� ������� ����� ��������
        if (masElemParam[i].arrNumGroup<>nil) then
        begin
          //���� ��������. ��������� �� ����������� ����������
          //���������� �� ��������� ������ ����������� ����� �����(�����) ��� ������� ������
          for j:=0 to minGrNumber-1 do
          begin
            SetLength(arrGr,j+1);
            arrGr[j]:=masElemParam[i].arrNumGroup[j];
          end;

          //�������� ������ ��� ��� ���������� � ����
          masElemParam[i].arrNumGroup:=nil;
          //�������������� ������ ����� ��� ������� �� ����� ������� ���������� �� ������ ����
          for j:=0 to minGrNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumGroup,j+1);
            masElemParam[i].arrNumGroup[j]:=arrGr[j];
          end;
          arrGr:=nil;
        end
        else
        begin
          //��� ���������.
          for j:=0 to minGrNumber-1 do
          begin
            SetLength(masElemParam[i].arrNumGroup,j+1);
            masElemParam[i].arrNumGroup[j]:= masElemParam[iMinGrNumber].arrNumGroup[j];
          end;
        end;
      end;
    end;
  end;
end;
//==============================================================================

//==============================================================================
//
//==============================================================================
function FillContFlagCikl:Boolean;
var
  i:Integer;
  bool:Boolean;
  masElemParamLen:integer;
begin
  bool:=false;
  masElemParamLen:=length(masElemParam);
  for i:=0 to masElemParamLen-1 do
  begin
    if masElemParam[i].adressType=1 then
    begin
      if (masElemParam[i].flagCikl) then
      begin
        bool:=true;
        break;
      end;
    end;
  end;
  result:=bool;
end;
//==============================================================================

//==============================================================================
//
//==============================================================================
function FillContFlagGr:Boolean;
var
  i:Integer;
  bool:Boolean;
  masElemParamLen:integer;
begin
  bool:=false;
  masElemParamLen:=length(masElemParam);
  for i:=0 to masElemParamLen-1 do
  begin
    if masElemParam[i].adressType=1 then
    begin
      if (masElemParam[i].flagGroup) then
      begin
        bool:=true;
        break;
      end;
    end;
  end;
  result:=bool;
end;
//==============================================================================

//==============================================================================
//
//==============================================================================
function FillSlowFlagCikl:Boolean;
var
  i:Integer;
  bool:Boolean;
  masElemParamLen:integer;
begin
  bool:=false;
  masElemParamLen:=length(masElemParam);

  for i:=0 to masElemParamLen-1 do
  begin
    if ((masElemParam[i].adressType=0)or(masElemParam[i].adressType=8)) then
    begin
      if (masElemParam[i].flagCikl) then
      begin
        bool:=true;
        break;
      end;
    end;
  end;
  result:=bool;
end;
//==============================================================================

//==============================================================================
//
//==============================================================================
function FillSlowFlagGr:Boolean;
var
  i:Integer;
  bool:Boolean;
  masElemParamLen:integer;
begin
  bool:=false;
  masElemParamLen:=length(masElemParam);

  for i:=0 to masElemParamLen-1 do
  begin
    if ((masElemParam[i].adressType=0)or(masElemParam[i].adressType=8))then
    begin
      if (masElemParam[i].flagGroup) then
      begin
        bool:=true;
        break;
      end;
    end;
  end;


  result:=bool;
end;
//==============================================================================

//==============================================================================
//���������� ������� ������� ������
//==============================================================================
procedure FillCiklArr(iArrElemPar:Integer;var fNum:Integer;var stepNum:Integer);
const
  MAXCIKLNUM=4;
var
  fNumCikl:Integer;
  sNumCikl:Integer;
  fElemC:Integer;
  sElemC:Integer;
  i:Integer;
  iC:Integer;
  fElemGr:Integer;
  sElemGr:Integer;
begin
  masElemParam[iArrElemPar].flagCikl:=True;
  i:=0;
  fElemC:=fNum;
  //������ ����� ������� �����
  fNumCikl:=Trunc(fElemC/(masGroupSize*32))+1;
  //���� ������ ������� ��������� �� � ������ �����,
  //�� ��������� ����� ����� � ������ ������������� �� ��� ������
  if fElemC>masGroupSize*32 then
  begin
    fNum:=fElemC-((fNumCikl-1)*masGroupSize*32);
  end;


  sElemC:=stepNum;
  //�������� �� ���� �����
  sNumCikl:=Trunc(sElemC/(masGroupSize*32));
  iC:=fNumCikl;
  SetLength(masElemParam[iArrElemPar].arrNumCikl,i+1);
  masElemParam[iArrElemPar].arrNumCikl[i]:=iC;
  Inc(i);
  iC:=iC+sNumCikl;
  //��������� ������ �� ������� ��� ������������ ����� ����� 4
  while iC<=MAXCIKLNUM do
  begin
    SetLength(masElemParam[iArrElemPar].arrNumCikl,i+1);
    masElemParam[iArrElemPar].arrNumCikl[i]:=iC;
    iC:=iC+sNumCikl;
    Inc(i);
  end;

  fElemGr:=fElemC-((fNumCikl-1)*masGroupSize*32);
  //sElemGr:=sElemC-((sNumCikl-1)*masGroupSize*32);

  //��������� ���� �� ��������� ������ ������
  if sElemGr>masGroupSize then
  begin
    //���������� ������� ������ ����� ���������� ������� �����
    FillGroupArr(iArrElemPar,fElemGr,sElemGr);
  end;

end;
//==============================================================================


//==============================================================================
//������ ������� ������M16
//==============================================================================
function AdressAnalyser(adressString: string; var imasElemParam: integer):Boolean;
var
  //���������� ��� ��������
  iGraph: integer;
  flagM: boolean;
  //���������� ��� �������� ASCII-���� �������
  codAsciiGraph: integer;
  stepKoef: integer;
  //��������� ��� ���������� ���������
  Ma, Mb, Mc, Md, Me, Mx: integer; //Ma=N1-1;Mb=N2-1;Mc=N3-1; � �.�
  //���� ��� ���������� ������
  //Fa=8, ���� K=0; Fa=4, ���� K=1; Fa=2, ���� K=2; ���������� ��� ������
  Fa, Fb, Fc, Fd, Fe, Fx: integer;
  //�������� ����. � �������, ������� �� �1 ��� �2
  pBeginOffset: integer;
  flagBegin: boolean;
  stepOutGins: integer;
  offset: integer;

  //��������������� ������ � ���� ������ �����
  infStrInt: integer;

  adrLength:Integer;

  //���� ��� �������� ���������� ������� ������
  isOkAdr:Boolean;
begin
  isOkAdr:=True;
  stepOutGins := 1;
  offset := 0;
  pBeginOffset := 0;
  Fa := 0;
  Fb := 0;
  Fc := 0;
  Fd := 0;
  Fe := 0;
  Fx := 0;
  flagM := false;
  iGraph := 1;
  flagBegin := false;
  adrLength:=length(adressString);
  while iGraph <= adrLength do
  begin
    //������ ������ ������ ���� ����������� �
    if adressString[iGraph] = 'M' then
    begin
      //� ����.
      flagM := true;
    end;

    if (flagM) then
    begin
      //M16
      if (adressString[iGraph + 1] = '1') and (adressString[iGraph + 2] = '6') then
      begin
        if ((adressString[iGraph + 3] = '�') or (adressString[iGraph + 3] = '�')) then
        begin
          if (adressString[iGraph + 4] = '1') then
          begin
            //������ ���. �������� ��� ������� �� �������
            pBeginOffset := 1;
          end;
          if (adressString[iGraph + 4] = '2') then
          begin
            //������ ���. �������� ��� ������� �� �������
            pBeginOffset := 2;
          end;
          flagBegin := true;
          iGraph := iGraph + 5;
          break;
        end
        else
        begin
          showMessage('������! �������� ����������� ������,'
            + '��������� ��������������� �� �� �������������!');
          //Application.Terminate;
          halt;
        end;
      end
      //���������
      else
      begin
        //��� ��������
        pBeginOffset := 1;
        flagBegin := true;
        iGraph := iGraph + 3;
        break;
      end;
    end;
  end;

  if (flagBegin) then
  begin
    //������������ ����� ���������
    while {(adressString[iGraph]<>' ')} iGraph <= adrLength do
    begin
      codAsciiGraph := ord(adressString[iGraph]);
      // ��������� ������������ ���� � ����� ��������� ����� � ���.
      case codAsciiGraph of
        //����� �(�)
        65, 97:
        begin
          Ma := strToInt(adressString[iGraph + 1]);
          case infNum of
            0:
            begin
              //M16
              if ((Ma<1)or(Ma>8)) then
              begin
                //������ ������� ������. �������� �����
                isOkAdr:=False;
                Break;
              end;
            end;
            1:
            begin
              //M08
              if ((Ma<1)or(Ma>8)) then
              begin
                //������ ������� ������. �������� �����
                isOkAdr:=False;
                Break;
              end;
            end;
            2:
            begin
              //M04
              if ((Ma<1)or(Ma>4)) then
              begin
                //������ ������� ������. �������� �����
                isOkAdr:=False;
                Break;
              end;
            end;
            3:
            begin
              //M02
              if ((Ma<1)or(Ma>2)) then
              begin
                //������ ������� ������. �������� �����
                isOkAdr:=False;
                Break;
              end;
            end;
            4:
            begin
              //M01
              if (Ma<>1) then
              begin
                //������ ������� ������. �������� �����
                isOkAdr:=False;
                Break;
              end;
            end;
          end;

          Ma :=Ma-1;
          //Ma := strToInt(adressString[iGraph + 1]) - 1;

          stepKoef := strToInt(adressString[iGraph + 2]);
          case stepKoef of
            0:
            begin
              case infNum of
                0:
                begin
                  //M16
                  Fa := 8;
                end;
                1:
                begin
                  //M08
                  Fa := 8;
                end;
                2:
                begin
                  //M04
                  Fa := 4;
                end;
                3:
                begin
                  //M02
                  Fa := 2;
                end;
                4:
                begin
                  //M01
                  Fa := 1;
                end;
              end;
            end;
            1:
            begin
              case infNum of
                0:
                begin
                  //M16
                  Fa := 4;
                end;
                1:
                begin
                  //M08
                  Fa := 4;
                end;
                2:
                begin
                  //M04
                  Fa := 2;
                end;
                3:
                begin
                  //M02
                  Fa := 1;
                end;
                4:
                begin
                  //M01
                  //Fa := 0;
                  //���� Fa < 1 �� ������ ������ ���� �� �����
                  isOkAdr:=False;
                  Break;
                end;
              end;
            end;
            2:
            begin
              case infNum of
                0:
                begin
                  //M16
                  Fa := 2;
                end;
                1:
                begin
                  //M08
                  Fa := 2;
                end;
                2:
                begin
                  //M04
                  Fa := 1;
                end;
                3:
                begin
                  //M02
                  //Fa := 0;
                  //���� Fa < 1 �� ������ ������ ���� �� �����
                  //!! ������
                  isOkAdr:=False;
                  Break;
                end;
                4:
                begin
                  //M01
                  //Fa := 0;
                  //���� Fa < 1 �� ������ ������ ���� �� �����
                  //!! ������
                  isOkAdr:=False;
                  Break;
                end;
              end;
            end;
          end;
          stepOutGins := Fa;
          offset := offset + Ma;
        end;
        //����� B(b)
        66, 98:
        begin
          Mb := strToInt(adressString[iGraph + 1]);
          if ((Mb<1)or(Mb>8)) then
          begin
            //������ ������� ������. �������� �����
            isOkAdr:=False;
            Break;
          end;

          Mb :=Mb-1;
          stepKoef := strToInt(adressString[iGraph + 2]);
          case stepKoef of
            0:
            begin
              Fb := 8;
            end;
            1:
            begin
              Fb := 4;
            end;
            2:
            begin
              Fb := 2;
            end;
          end;
          offset := offset + Mb * stepOutGins;
          stepOutGins := stepOutGins * Fb;
        end;
        //����� C(c)
        67, 99:
        begin
          Mc := strToInt(adressString[iGraph + 1]);
          if ((Mc<1)or(Mc>8)) then
          begin
            //������ ������� ������. �������� �����
            isOkAdr:=False;
            Break;
          end;

          Mc :=Mc-1;

          stepKoef := strToInt(adressString[iGraph + 2]);
          case stepKoef of
            0:
            begin
              Fc := 8;
            end;
            1:
            begin
              Fc := 4;
            end;
            2:
            begin
              Fc := 2;
            end;
          end;
          offset := offset + Mc * stepOutGins;
          stepOutGins := stepOutGins * Fc;
        end;
        //����� D(d)
        68, 100:
        begin
          Md := strToInt(adressString[iGraph + 1]);
          if ((Md<1)or(Md>8)) then
          begin
            //������ ������� ������. �������� �����
            isOkAdr:=False;
            Break;
          end;

          Md :=Md-1;
          stepKoef := strToInt(adressString[iGraph + 2]);
          case stepKoef of
            0:
            begin
              Fd := 8;
            end;
            1:
            begin
              Fd := 4;
            end;
            2:
            begin
              Fd := 2;
            end;
          end;
          offset := offset + Md * stepOutGins;
          stepOutGins := stepOutGins * Fd;
        end;
        //����� E(e)
        69, 101:
        begin
          Me := strToInt(adressString[iGraph + 1]);
          if ((Me<1)or(Me>8)) then
          begin
            //������ ������� ������. �������� �����
            isOkAdr:=False;
            Break;
          end;

          Me :=Me-1;


          stepKoef := strToInt(adressString[iGraph + 2]);
          case stepKoef of
            0:
            begin
              Fe := 8;
            end;
            1:
            begin
              Fe := 4;
            end;
            2:
            begin
              Fe := 2;
            end;
          end;
          offset := offset + Me * stepOutGins;
          stepOutGins := stepOutGins * Fe;
        end;
        //����� X(x)
        88, 120:
        begin
          Mx := strToInt(adressString[iGraph + 1]);
          if ((Mx<1)or(Mx>8)) then
          begin
            //������ ������� ������. �������� �����
            isOkAdr:=False;
            Break;
          end;
          Mx:=Mx-1;

          stepKoef := strToInt(adressString[iGraph + 2]);
          case stepKoef of
            0:
            begin
              Fx := 8;
            end;
            1:
            begin
              Fx := 4;
            end;
            2:
            begin
              Fx := 2;
            end;
          end;
          offset := offset + Mx * stepOutGins;
          stepOutGins := stepOutGins * Fx;
        end;
        //����� T(t)
        84, 116:
        begin
          if ((adressString[iGraph + 1] = '0')and(adressString[iGraph + 2] = '1')and
                       (adressString[iGraph + 3] = '-')and(adressString[iGraph + 4] = '0')and
                       (adressString[iGraph + 5] = '1')
                  ) then

          begin

            //T01-01. ��������� ���������� ������ 9 ��������
            masElemParam[imasElemParam].adressType := 8;

          end
          else if ((adressString[iGraph + 1] = '0')and(adressString[iGraph + 2] = '5')) then
          begin
            //T05. ���������� 1.
            masElemParam[imasElemParam].adressType := 1;
          end
          else if ((adressString[iGraph + 1] = '2')and(adressString[iGraph + 2] = '1')) then
          begin
            //T21 ������� 1.
            masElemParam[imasElemParam].adressType := 3;
          end
          else if ((adressString[iGraph + 1] = '2')and(adressString[iGraph + 2] = '2')) then
          begin
            //T22. ������� 2.
            masElemParam[imasElemParam].adressType := 2;
          end
          else if ((adressString[iGraph + 1] = '2')and(adressString[iGraph + 2] = '3')) then
          begin
            //T23. ������� 3.
            masElemParam[imasElemParam].adressType := 4;
          end else if ((adressString[iGraph + 1] = '2')and(adressString[iGraph + 2] = '4')) then
          begin
            //T24 ������� 4.
            //���� ��� ��� ��� �������
            masElemParam[imasElemParam].adressType := 5;
          end
          else if ((adressString[iGraph + 1] = '2')and(adressString[iGraph + 2] = '5')) then
          begin
            //T25. ���. ��� ��������
            masElemParam[imasElemParam].adressType := 6;
          end
          else if ((adressString[iGraph + 1] = '1')and(adressString[iGraph + 2] = '1')) then
          begin
            //T11. �������������
            masElemParam[imasElemParam].adressType := 7;
          end
          else if ((adressString[iGraph + 1] = '0')and(adressString[iGraph + 2] = '1')) then
          begin
             //T01. ���������� 0.
            masElemParam[imasElemParam].adressType := 0;
            //��������� ����� ����.
            //������������ ������ ��� ����������.
            masElemParam[imasElemParam].bitNumber := 0;

          end
          else
          begin
            //���� �� ���� �� ����� �� ������
            isOkAdr:=False;
            Break;
          end;
        end;
        //����� P(p)
        80, 112:
        begin
          //����������� � ���������� ���� �����.
          //� ��������� ��������� ���������� ��� ����� ����������
          //��������� ����� ����. ������������ ������
          //��� ����������. ������������ ��� �������.
          masElemParam[imasElemParam].bitNumber :=
            strToInt(adressString[iGraph + 1] + adressString[iGraph + 2]);
          if ((masElemParam[imasElemParam].bitNumber<1)or
              (masElemParam[imasElemParam].bitNumber>10)) then
          begin
            isOkAdr:=False;
          end;
          break;
        end;
      end;
      iGraph := iGraph + 3;
    end;

    if (isOkAdr) then
    begin
      infStrInt := StrToInt(adressString[2] + adressString[3]);
      //N1={Ma+Mb*Fa+Mc*Fa*Fb+Md*Fa*Fb*Fc+Me*Fa*Fb*Fc*Fd+Mx*Fa*Fb*Fc*Fd*Fe}
      //�������� ���������� ������ ������� � ����������� �� ��� ����. ������
      //M16
      if infStrInt = 16 then
      begin
        {if  ((pBeginOffset + 2 * offset)>(masGroupSize*32)) then
        begin
          //� �����
          fElemC:=pBeginOffset + 2 * offset;
          //������ ����� ������� �����
          iCikl:=Trunc(fElemC/(masGroupSize*32));
          //�������� � ����� ������
          if (fElemC-(iCikl*(masGroupSize*32)))>masGroupSize then
          begin
            fElemGr:=fElemC-(iCikl*(masGroupSize*32));
            iGr:=Trunc(fElemGr/masGroupSize);
            //������ ����� �������� � ������ ������
            masElemParam[imasElemParam].numOutElemG:=fElemGr-(iGr*masGroupSize);
          end
          else
          begin
            //������ ����� �������� � ������ ������
            masElemParam[imasElemParam].numOutElemG:=fElemC-(iCikl*(masGroupSize*32));
          end;
        end
        else if  ((pBeginOffset + 2 * offset)>masGroupSize) then
        begin
          //� ������
          fElemGr:=pBeginOffset + 2 * offset;
          //������ ����� ������ ������
          iGr:=Trunc(fElem/masGroupSize);
          //������ ����� �������� � ������ ������
          masElemParam[imasElemParam].numOutElemG:=fElemGr-(iGr*masGroupSize);
        end
        else
        begin
          //� ������ ������ ������� �����
          masElemParam[imasElemParam].numOutElemG := pBeginOffset + 2 * offset;
        end; }
        masElemParam[imasElemParam].numOutElemG := pBeginOffset + 2 * offset;
      end
      //���������
      else
      begin
        {if  ((pBeginOffset + offset)>(masGroupSize*32)) then
        begin
          //� �����
          fElemC:=pBeginOffset + offset;
          //������ ����� ������� �����
          iCikl:=Trunc(fElemC/(masGroupSize*32));
          //�������� � ����� ������
          if (fElemC-(iCikl*(masGroupSize*32)))>masGroupSize then
          begin
            fElemGr:=fElemC-(iCikl*(masGroupSize*32));
            iGr:=Trunc(fElemGr/masGroupSize);
            //������ ����� �������� � ������ ������
            masElemParam[imasElemParam].numOutElemG:=fElemGr-(iGr*masGroupSize);
          end
          else
          begin
            //������ ����� �������� � ������ ������
            masElemParam[imasElemParam].numOutElemG:=fElemC-(iCikl*(masGroupSize*32));
          end;
        end
        else if  ((pBeginOffset + offset)>masGroupSize) then
        begin
          //� ������
          fElemGr:=pBeginOffset + offset;
          //������ ����� ������ ������
          iGr:=Trunc(fElem/masGroupSize);
          //������ ����� �������� � ������ ������
          masElemParam[imasElemParam].numOutElemG:=fElemGr-(iGr*masGroupSize);
        end
        else
        begin
          //� ������ ������ ������� �����
          masElemParam[imasElemParam].numOutElemG := pBeginOffset + offset;
        end;}
        masElemParam[imasElemParam].numOutElemG := pBeginOffset + offset;
      end;

      //���������� ��� ��� ������� ����. ����� � �����. �� ��������������� ������
      case infStrInt of
        16:
        begin
          masElemParam[imasElemParam].stepOutG := 2 * stepOutGins; //T=Fa*Fb*Fc*Fd*Fe*Fx
        end;
        8:
        begin
          masElemParam[imasElemParam].stepOutG := stepOutGins;
        end;
        4:
        begin
          masElemParam[imasElemParam].stepOutG := stepOutGins;
          //masElemParam[imasElemParam].stepOutG := round(stepOutGins / 2);
        end;
        2:
        begin
          masElemParam[imasElemParam].stepOutG := stepOutGins;
          //masElemParam[imasElemParam].stepOutG := round(stepOutGins / 4);
        end;
        1:
        begin
          masElemParam[imasElemParam].stepOutG := stepOutGins;
          //masElemParam[imasElemParam].stepOutG := round(stepOutGins / 8);
        end;
      end;

      if  (masElemParam[imasElemParam].stepOutG>(masGroupSize*32)) then
      begin
        //�������� ������ ������ �����
        //��������� ������ ������ � �������� ������ �� ������� ���� ����� �����
        FillCiklArr(imasElemParam,masElemParam[imasElemParam].numOutElemG,
          masElemParam[imasElemParam].stepOutG );
      end
      else if (masElemParam[imasElemParam].stepOutG>masGroupSize) then
      begin
        FillGroupArr(imasElemParam,masElemParam[imasElemParam].numOutElemG,
          masElemParam[imasElemParam].stepOutG );
      end;

      //��������� �� ��������� �������� �������
      //��������� ����� � 1 ��� ���� �������
      masElemParam[imasElemParam].numOutPoint := 1;
      //masElemParam[imasElemParam].numOutElemG:=
        //masElemParam[imasElemParam].numOutElemG+numPoint*
          //masElemParam[imasElemParam].stepOutG; //N=N1+nT
    end;
  end
  else
  begin
    isOkAdr:=False;
  end;
  //������� ��������� ������� ������
  Result:=isOkAdr;
end;
//==============================================================================



//==============================================================================
//���������� ������� ���������� ������������� ������� �������16
//==============================================================================
function FillAdressParam:boolean;
var
  //���������� ������� ��� ������� ������ ������ �������
  adrCount: integer;
  //���� ���. �������
  iAdr: integer;
  maxAdrNum:Integer;
  //���� ���������� ������� �������
  isOk:Boolean;
begin
  isOk:=True;
  //��������� ������������� �������
  masElemParam := nil;
  iAdr := 0;
  maxAdrNum:=form1.OrbitaAddresMemo.Lines.Count - 1;
  for adrCount := 0 to maxAdrNum  do
  begin
    //��� ������� �� ������� ��������� ����� ��� ��� ���������� �����������
    if  form1.OrbitaAddresMemo.Lines.Strings[adrCount]<>'---' then
    begin
      //�����
      //������� ������ �� ������� ������� ����������
      setlength(masElemParam, iAdr  + 1);
      //���� ����� �������� ������� �� ������ true
      isOk:=AdressAnalyser(form1.OrbitaAddresMemo.Lines.Strings[adrCount], iAdr);
      if (not isOk) then
      begin
        //��������� ����� �������� � �������
        //������ ������ �� ���������
        Break;
      end;
      inc(iAdr);
    end;
  end;

  //���� ������� ��� ������� ������� �� ���� �� �������� ������
  if (isOk) then
  begin
    //��������� ������������ ���������� �������
    iCountMax := iAdr;
    //���������� ������� ����� ������� ���� � ������
    CountAddres;
    //masElemParam:=nil;

    //�������� ���� �� ����� ��������� ���������� ����� ��������� ������� �� �� ���� �����
    //T01 � T01-01
    vSlowFlagGr:=FillSlowFlagGr;
    //�������� ���� �� ����� ��������� ���������� ����� ��������� ������� �� �� ���� ������
    vSlowFlagCikl:=FillSlowFlagCikl;
    //���������� ��� ��������� ���������� ���������
    //��� ����������� ���� ������� � ����������� �� ����� ���������
    if ((vSlowFlagCikl)or(vSlowFlagGr)) then
    begin
      slowAdrCorrection;
    end;

    //�������� ���� �� ����� ���������� ���������� ����� ��������� ������� �� �� ���� �����
    vContFlagGr:=FillContFlagGr;
    //�������� ���� �� ����� ���������� ���������� ����� ��������� ������� �� �� ���� ������
    vContFlagCikl:=FillContFlagCikl;

    if ((vContFlagCikl)or(vContFlagGr)) then
    begin
      contAdrCorrection;
    end;

    vSlowFlag:=(vSlowFlagGr){and}or(vSlowFlagCikl);
    vContFlag:=(vContFlagGr){and}or(vContFlagCikl);

    //masElemParam:=nil;
  end;

  Result:=isOk;

end;
//==============================================================================

//==============================================================================
//������� ��������
//==============================================================================

procedure Wait(value: integer);
var
  i: integer;
begin
  for i := 1 to value do
  begin
    sleep(3);
    application.ProcessMessages;
  end;
end;
//==============================================================================


//==============================================================================
//
//==============================================================================
procedure GetAddrList;
var
  maxAdrNum:Integer;
  iAdr:integer;
  adrCount:integer;
begin
  arrAddrOk:=nil;
  iAdr := 0;
  maxAdrNum:=form1.OrbitaAddresMemo.Lines.Count - 1;
  for adrCount := 0 to maxAdrNum  do
  begin
    if form1.OrbitaAddresMemo.Lines.Strings[adrCount]<>'' then
    begin
      //��������� ������ ������
      //������� ������ �� ������� ������� ����������
      setlength(arrAddrOk, iAdr  + 1);
      arrAddrOk[iAdr]:=form1.OrbitaAddresMemo.Lines.Strings[adrCount];
      inc(iAdr);
    end;
  end;
end;
//==============================================================================

//==============================================================================
//
//==============================================================================
procedure SetOrbAddr;
var
  iAdr:Integer;
  maxAdrNum:integer;
begin
  //������� ������ �������
  form1.OrbitaAddresMemo.Clear;
  maxAdrNum:=Length(arrAddrOk)-1;
  for iAdr:=0 to maxAdrNum do
  begin
    form1.OrbitaAddresMemo.Lines.Add(arrAddrOk[iAdr]);
  end;
end;
//==============================================================================

procedure TForm1.startReadACPClick(Sender: TObject);
var
  intPointNum:integer;
begin


  testOutFalg:=true;

  //setlength(data.masFastVal, trunc(form1.fastGist.BottomAxis.Maximum)-2);
  //data.masFastVal:=nil;
  //intPointNum:=trunc(form1.fastGist.BottomAxis.Maximum);
  setlength(masFastVal, intPointNum);
  //�������. �������� ��� �����. �����. ������� ���� �������
  //��
  acumAnalog := 0;
  //����
  acumTemp:=0;
  //��
  acumContact := 0;
  //�
  acumFast := 0;
  //���
  acumBus := 0;
  //������������ ���. ������.
  form1.OrbitaAddresMemo.Lines.LoadFromFile(propStrPath);
  //��������� ����������� ������ �������
  GetAddrList;
  //��������� ������ ���������� �������
  SetOrbAddr;
  //���������� ���������������
  form1.gistSlowAnl.AllowZoom:=false;
  form1.gistSlowAnl.AllowPanning:=pmNone;

  form1.fastGist.AllowZoom:=false;
  form1.fastGist.AllowPanning:=pmNone;

  form1.tempGist.AllowZoom:=False;
  form1.tempGist.AllowPanning:=pmNone;
  //�������� ������������ �������
  if (GenTestAdrCorrect) then
  begin
    //������ ��� ������ � ��������
    if infNum=0 then
    begin
      dataM16 := TdataM16.CreateData;
    end
    else
    begin
      dataMoth := TdataMoth.CreateData;
    end;
    //������ ��� ������ � ���
    tlm := Ttlm.CreateTLM;
    //��������� �������� ��������
    form1.tlmPSpeed.Position := 3;
    form1.tlmPSpeed.Enabled:=true;
    if form1.startReadACP.Caption = '�����' then
    //�����
    begin
      //AssignFile(textTestFile,'TextTestFile.txt');
      //Rewrite(textTestFile);
      //AssignFile(swtFile,ExtractFileDir(ParamStr(0)) + '/Report/' + '777.txt');
      //ReWrite(swtFile);
      //�������. ���� ������ �� ���� ������
      flagEnd:=false;
      //���������� ������� ����������.
      if (FillAdressParam) then
      begin
        form1.startReadACP.Caption := '����';
        //����� ������ ������
        form1.tlmWriteB.Enabled := true;
        form1.startReadTlmB.Enabled:=false;
        form1.propB.Enabled:=false;

        //���������� ��� � ������
        if  (not boolFlg) then
        begin
          acp := Tacp.InitApc;
          //������������ � ������ � ���
          acp.CreateApc;
          //�������� ���� ������ � ���
          pModule.START_ADC();
          //boolFlg:=true;
        end
        else
        begin
          //acp := Tacp.InitApc;
          //
          //pModule.START_ADC();
        end;
      end
      else
      begin
        tlm := nil;
        //��������� �������� ��������
        form1.tlmPSpeed.Position := 3;
        form1.tlmPSpeed.Enabled:=false;
        ShowMessage('� ������ ������� ������������ ������!');
      end;
    end
    else
    //����
    begin

      //closeFile(swtFile);
      {form1.startReadACP.Caption := '�����';
      form1.startReadACP.Enabled:=false;
      form1.tlmWriteB.Enabled := false;
      form1.propB.Enabled:=true;
      //flagEnd:=true;
      // wait(50);
      //���������� � ������ � 0
      //data.Free;
      //data := Tdata.CreateData;
      pModule.STOP_ADC();
      //flagEnd:=true;
      //wait(50);
      WaitForSingleObject(hReadThread,1500);
      //���� ����� ������ , �� ���������� ������
      if hReadThread <> THANDLE(nil) then
      begin
        CloseHandle(hReadThread);
        hReadThread:=THANDLE(nil);
      end;
      flagEnd:=true;
      //acp.Free;
      //pModule.ReleaseLInstance();
      //pModule:=nil;
      wait(50);}

      //form1.Visible:=false;


      //CloseFile(textTestFile);
      graphFlagFastP := false;

      //wait(50);

      if ((form1.tlmWriteB.Enabled)and
          (not form1.startReadTlmB.Enabled)and
          (not form1.propB.Enabled))  then
      begin
        //��������� ������ � ���
        pModule.STOP_ADC();
      end;
      //�������� ��� ���������� �����
      flagEnd:=true;
      //wait(50);
      //while (True) do Application.ProcessMessages; //!!!!
      //WinExec(PChar('OrbitaMAll.exe'), SW_ShowNormal);
      //wait(20);
      //�������� ���������� �� �����������.
      Application.Terminate;
      WinExec(PChar('OrbitaMAll.exe'), SW_ShowNormal);
      //halt;
    end;
  end
  else
  begin
    ShowMessage('��������� ������������ �������!');
  end;
end;

//�������� ��������� � ������������� ������ �����������
//��� �������� ������ ���� ��� � ������.

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //���� �������� ���������� ��� ������ �� ��������� ������ � ���. ����� ���������.
  if ((form1.tlmWriteB.Enabled)and(not form1.startReadTlmB.Enabled)and
      (not form1.propB.Enabled))  then
  begin
    //��������� ������ � ���
    pModule.STOP_ADC();
  end;

  //�������� ��� ���������� �����
  flagEnd:=true;
  wait(20);
  //�������� ���������� �� �����������.
  Application.Terminate;
  //halt
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  path:string;

begin
  flagTrue:=false;

  orbOk:=False;
  orbOkCounter:=0;
  boolFlg:=false;
  csk:=TCriticalSection.Create;
  //��������� ��������
  form1.diaSlowAnl.LeftAxis.Maximum := 1025.0;
  form1.gistSlowAnl.BottomAxis.Maximum := 300;
  form1.gistSlowAnl.BottomAxis.Minimum := 0;
  form1.gistSlowAnl.LeftAxis.Maximum := 1025;
  form1.gistSlowAnl.LeftAxis.Minimum := 0;
  path:=ExtractFileDir(ParamStr(0))+'\ConfigDir\property.ini';
  propIniFile:=TIniFile.Create(path);
  //������ �� ����� ���������� ������ ��������� path.
  propStrPath:=propIniFile.ReadString('lastPropFile','path','');
  //��������� ���� �� ����� ���� �������� �� ��.
  if FileExists(propStrPath) then
  begin
    //����, �� ��� ������ ������ ��
    if propStrPath='' then
    begin
      //����������� ��������� ������������
      //���. ���.
      form1.propB.Enabled := true;
      //�����
      form1.startReadACP.Enabled := false;
      //������
      form1.startReadTlmB.Enabled := false;
      //������ � tlm
      form1.tlmWriteB.Enabled := false;
      //������ ������
      form1.PanelPlayer.Enabled := false;
      //�������� ��������� � �����
      form1.TrackBar1.Enabled := false;
      //�������� ��������
      form1.tlmPSpeed.Enabled:=false;
      //���������� � ���� �������
      form1.saveAdrB.Enabled:=false;
    end
    else
    //����.
    begin
      form1.propB.Enabled := true;
      form1.startReadACP.Enabled := true;
      form1.startReadTlmB.Enabled := true;
      form1.tlmWriteB.Enabled := false;
      form1.PanelPlayer.Enabled := false;
      form1.TrackBar1.Enabled := false;
      form1.tlmPSpeed.Enabled:=false;
      form1.saveAdrB.Enabled:=true;
      //�������� ����� ������� � ������� ������ �������
      form1.OrbitaAddresMemo.Lines.LoadFromFile(propStrPath);
      //��������� ����������� ������ �������
      GetAddrList;
      //��������� ������ ���������� �������
      SetOrbAddr;
    end;
  end
  else
  //������ ����� ���. ����������� ���.
  begin
    form1.propB.Enabled := true;
    form1.startReadACP.Enabled := false;
    form1.startReadTlmB.Enabled := false;
    form1.tlmWriteB.Enabled := false;
    form1.PanelPlayer.Enabled := false;
    form1.TrackBar1.Enabled := false;
    form1.tlmPSpeed.Enabled:=false;
    form1.saveAdrB.Enabled:=false;
  end;
  //�������� ���� ��������
  propIniFile.Free;
end;

procedure TForm1.upGistSlowSizeClick(Sender: TObject);
begin
  form1.downGistSlowSize.Enabled := true;
  if form1.gistSlowAnl.BottomAxis.Maximum <=form1.gistSlowAnl.BottomAxis.Minimum + 20 then
  begin
    form1.upGistSlowSize.Enabled := false
  end
  else
  begin
    form1.gistSlowAnl.BottomAxis.Maximum := form1.gistSlowAnl.BottomAxis.Maximum - 10;
  end;
end;

procedure TForm1.downGistSlowSizeClick(Sender: TObject);
begin
  form1.upGistSlowSize.Enabled := true;
  form1.gistSlowAnl.BottomAxis.Maximum := form1.gistSlowAnl.BottomAxis.Maximum + 10;
  if form1.gistSlowAnl.BottomAxis.Maximum >= 700 then
  begin
    form1.downGistSlowSize.Enabled := false;
  end;
end;

procedure TForm1.Series1Click(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //�������� ������� � ����. � � ������ �����������
  //���� ������ ��� ����������� � ��������
  //form1.OrbitaAddresMemo.Enabled:= not form1.OrbitaAddresMemo.Enabled;
  //form1.Memo1.Enabled:= not form1.Memo1.Enabled;
  if ({data.}graphFlagSlowP) then
  begin
    form1.gistSlowAnl.Series[0].Clear;
    {data.}graphFlagSlowP := false;
  end
  else
  begin
    {data.}graphFlagSlowP := true;
    //form1.dia.Canvas.MoveTo(form1.dia.Width-1051,form1.dia.Height-33);
    {data.}chanelIndexSlow := ValueIndex;
  end;
end;

procedure TForm1.TimerOutToDiaTimer(Sender: TObject);
var
  orbAdrCount: integer;
begin

  //form1.Memo1.Lines.Add('������!:');
  //������������� ������� ��������� ������ ������.
  orbAdrCount := 0;
  //������� ��� �������� ���������� ���������� �������
  {data.}analogAdrCount := 0;
  //������� ��� �������� ���������� ���������� �������
  {data.}contactAdrCount := 0;
  //�������� ����� ��� ���������� ������
  //form1.diaSlowAnl.Series[0].Clear;
  form1.diaSlowCont.Series[0].Clear;
  form1.fastDia.Series[0].Clear;


  //sleep(3);
  //��������������� ��������� ������ �� ������� ������
  //������, �������� ������ �������� � ������� �� ������
  while orbAdrCount <= iCountMax - 1 do // iCountMax-1
  begin
    outToDia(
      masElemParam[orbAdrCount].numOutElemG,
      masElemParam[orbAdrCount].stepOutG,
      masGroupSize,orbAdrCount,
      masElemParam[orbAdrCount].adressType,
      masElemParam[orbAdrCount].bitNumber,
      masElemParam[orbAdrCount].numBusThread,
      masElemParam[orbAdrCount].adrBus,
      masElemParam[orbAdrCount].numOutPoint,
      masElemParam[orbAdrCount].flagGroup,
      masElemParam[orbAdrCount].flagCikl);
    inc(orbAdrCount);
  end;
  form1.TimerOutToDia.Enabled := false;
end;




//==============================================================================
//��������� �������
//==============================================================================

//==============================================================================
//
//==============================================================================

constructor Tdata.CreateData;
begin
  iTempArr:=0;
  iSlowArr:=0;
  iContArr:=0;
  outTempAdr:=0;






  
  //���� ��� ������ ������� ��� ���. ������� ���
  flagWtoBusArray:=false;



  porog := 0;
  //���. ����. ����� �������� ������
  //modC := false;


  //������� ������ �� fifo �����
  fifoLevelRead := 1;
  //������� ��� ������ � ������ fifo �����
  fifoLevelWrite := 1;
  //������� ���������� ������������ �����
  fifoBufCount := 0;

  //�������� ��� �������� ���������� ����� ���� � ���� ������
  //numRetimePointUp := 0;
  //numRetimePointDown := 0;



  bufNumGroup:=0;



  //fraseCount := 1;
  //fraseNum:=1;
  //groupCount := 1;






  

  
  //������ ��� ����� �����.
  //codStr:='';
  


 
  






  //SetLength(busArray,NUM_BUS_ELEM);
  iBusArray:=0;
  //bool:=true;
end;
//==============================================================================



//==============================================================================
//
//==============================================================================
{procedure TData.AddValueInMasDiaValue(numFOut:integer;step:integer;
  masGSize:integer;var numP:integer );
var
  nPoint:integer;
  begin
  nPoint:=numFOut;
  while nPoint<=masGSize do
  begin
    //���������� ������ ��� 1 �������
    setlength(masDiaValue,numP+1);
    masDiaValue[numP]:=masGroup[nPoint];
    inc(numP);
    nPoint:=nPoint+step;
  end;
end;}
//==============================================================================

//==============================================================================
//���� 32-� ��������� ���� � ������� � ����
//==============================================================================
{procedure FillSwatWord;
var
  iOrbWord:integer;
  wordToFile:integer;
begin
  iOrbWord:=1;
  wordToFile:=0;
  //���� ���� ������� 2
  while iOrbWord<=masGroupSize do
  begin
     //��������� 11 ���, �������� ����� ��� ���
    if (masGroup[iOrbWord] and 1024)=1024 then
    begin
      //����� ������ �����
      //����� 10 ��. �����
      wordToFile:=masGroup[iOrbWord] and 1023; //�1�12
      //����. 11 ��. �����
      wordToFile:=(masGroup[iOrbWord+1] shl 10)+wordToFile;//�2�12
      //����. 11 ��. �����
      wordToFile:=(masGroup[iOrbWord+2] shl 11)+wordToFile;//�1�22
      //writeln(swtFile,intToStr(wordToFile));
    end;
    iOrbWord:=iOrbWord+4;
  end;
end;}
//==============================================================================

//==============================================================================
//���� �������� ���
//�� ���� �������� ��� 12 ��������� ��������
//==============================================================================
function Tdata.BuildBusValue(highVal:word;lowerVal:word):word;
var
  busValBuf:word;
  bufH,bufL:word;
begin
  busValBuf:=0;
  bufH:=highVal and 2040;
  bufH:=bufH shr 3;
  bufL:=lowerVal and 2040;
  bufL:=bufL shr 3;
  bufH:=bufH shl 8;
  //� ����� ���������� ������ ����������� 12,3,2 � 1 ���.
  busValBuf:=bufH+bufL;
  //form1.Memo1.Lines.Add(intToStr(busValBuf));
  result:=busValBuf;
end;
//==============================================================================

//==============================================================================
//
//==============================================================================
function TData.CollectBusArray(var iBusArray:integer):boolean;
var
  orbAdrCount:integer;
  maxPointInAdr:integer;
  nPoint:integer;
  offsetForYalkBus:short;
  highVal:word;
  lowerVal:word;
  iParity:integer;

  iCount:integer;

  lll:integer;

  busArrLen:integer;
begin
  //����� ��� ��� ����������
  if form1.PageControl1.ActivePageIndex = 2 then
  begin
    orbAdrCount:=0;
    while orbAdrCount <= iCountMax - 1 do // iCountMax-1
    begin
      if masElemParam[orbAdrCount].adressType = 6 then
      begin
        iParity:=0;
        //��������� ���������� ����� � ��������� ������
        maxPointInAdr := 0;
        nPoint := masElemParam[orbAdrCount].numOutElemG;
        while nPoint <= {length(masGroup)}masGroupSize do
        begin
          inc(maxPointInAdr);
          nPoint := nPoint + masElemParam[orbAdrCount].stepOutG;
        end;
        offsetForYalkBus := masElemParam[orbAdrCount].stepOutG *
        (masElemParam[orbAdrCount].numOutPoint - 1);
        nPoint := masElemParam[orbAdrCount].numOutElemG + offsetForYalkBus;
        nPoint := nPoint{ - 1};
        // lll:=length(masGroup);
        // form1.Memo1.Lines.Add(intToStr(lll));
        // lll:=length(masGroupAll);
        // form1.Memo1.Lines.Add(intToStr(lll));
        while nPoint<{length(masGroup)}masGroupSize-masElemParam[orbAdrCount].stepOutG do
        begin
          offsetForYalkBus := masElemParam[orbAdrCount].stepOutG *
          (masElemParam[orbAdrCount].numOutPoint - 1);
          nPoint := masElemParam[orbAdrCount].numOutElemG + offsetForYalkBus;
          nPoint := nPoint{ - 1};
          if nPoint=1024 then
          begin
            //form1.Memo1.Lines.Add(intToStr(masGroupAll[nPoint])
            // +' '+intToStr(nPoint));
          end;
          if iParity mod 2 =0 then
          begin
            //���������� �������� ����� ������ �� ������� ������ ����� ���
            highVal:=masGroupAll[nPoint];
            //form1.Memo1.Lines.Add(intToStr(masGroupAll[nPoint])
            // +' '+intToStr(nPoint));
          end
          else
          begin
            //���������� �������� ����� ������ � ������� ������ ����� ���
            lowerVal:=masGroupAll[nPoint];
            //form1.Memo1.Lines.Add(intToStr(masGroupAll[nPoint])
            //+' '+intToStr(nPoint));
            //���� ������ (������������������ �� 65535,65535,65535)
            if  ((BuildBusValue(highVal,lowerVal)=65535)and   //!!77
              (not flagWtoBusArray))  then
            begin
              busArray[iBusArray]:=BuildBusValue(highVal,lowerVal);
              inc(iBusArray);
              if iBusArray=3 then
              begin
                //��������� 3 ��������
                if ((busArray[iBusArray-1]=65535)and(busArray[iBusArray-2]=65535)and
                (busArray[iBusArray-3]=65535)) then
                begin
                  //����� ������, ����� ��������� ������
                  flagWtoBusArray:=true;
                end
                else
                begin
                  //�� �����, ���� � ���������� ��� ������
                  iBusArray:=0;
                  flagWtoBusArray:=false;
                end;
              end;
            end
            else
            begin
              busArray[iBusArray]:=BuildBusValue(highVal,lowerVal);
              inc(iBusArray);
              if iBusArray=32{96} then
              begin
                busArrLen:=length(busArray);
                for iCount:=0 to busArrLen-1 do
                begin
                  //form1.Memo1.Lines.Add(intToStr(busArray[iCount])
                  //+' '+intToStr(iCount));
                end;
              // showMessage('!!!!');
              end;
            end;

            if (flagWtoBusArray) then
            begin
              //������ �� ����� �����. ��������� ������
              busArray[iBusArray]:=BuildBusValue(highVal,lowerVal);
              inc(iBusArray);
            end;
          end;

          inc(iParity);
          inc(masElemParam[orbAdrCount].numOutPoint);
        end;
        if masElemParam[orbAdrCount].numOutPoint > maxPointInAdr then
        begin
          masElemParam[orbAdrCount].numOutPoint := 1;
        end;
      end;
      inc(orbAdrCount);
    end;
  end;

  if iBusArray=96 then
  begin
    iBusArray:=0;
    flagWtoBusArray:=false;
    result:=true;
  end
  else
  begin
    result:=false;
  end;
end;
//==============================================================================



//==============================================================================
//��������� ������� ������ � ��������
//==============================================================================

{procedure Tdata.SaveReport;
var
  str: string;
  i: integer;
begin
  //���� � ��� �������������� ��������, ��
  if (ParamStr(1) = 'StartAutoTest') then
  begin
    //��������� ��� �� ������� ��������2.
    //���� ��� �� ���������� ������� ���������� �����
    if (ParamStr(2) = '') then
      //���
    begin
      str := '����_���_' + DateToStr(Date) + '_' + TimeToStr(Time) + '.txt';
      for i := 1 to length(str) do
        if (str[i] = ':') then
          str[i] := '.';
      form1.Memo1.Lines.SaveToFile(ExtractFileDir(ParamStr(0)) + '/Report/' + str);
    end
    else
      //��
    begin
      //��������� �.� � ���������� ������
      AssignFile(ReportFile, ParamStr(2));
      //��������� ���� �� ����� ����
      if (FileExists(ParamStr(2))) then
        //����, ��������� ���� �� ��������
      begin
        Append(ReportFile);
      end
      else
        //���
      begin
        //��������� �� ������
        ReWrite(ReportFile);
      end;
      writeln(ReportFile, form1.Memo1.Text);
      closefile(ReportFile);
    end
  end
  else
    //������ ��������. ���������� �����
  begin
    str := '����_���_' + DateToStr(Date) + '_' + TimeToStr(Time) + '.txt';
    for i := 1 to length(str) do
      if (str[i] = ':') then
        str[i] := '.';
    form1.Memo1.Lines.SaveToFile(ExtractFileDir(ParamStr(0)) + '/Report/' + str);
  end;
end;}
//==============================================================================



//==============================================================================
//��������� ��� ������ � ��������� ������ . � ���� ����� ������� ��������
//==============================================================================

procedure Tdata.WriteSystemInfo(value: string);
begin
  //����. ����� System � �������� ����������
  AssignFile(SystemFile, 'System');
  //�������� ���  �� ������
  ReWrite(SystemFile);
  //������ � ���� ����������� ��������
  writeln(SystemFile, value);
  //�������� �����
  closefile(SystemFile);
end;
//==============================================================================

//==============================================================================
//������� ���������� �������� ��������.
//���������� ������� �������� � ������������� �������
//==============================================================================

function Tdata.AvrValue(firstOutPoint: integer; nextPointStep: integer;
  masGroupS: integer): integer;
var
  sum: integer;
  pointCh: integer;
begin
  sum := 0;
  pointCh := 0;
  while firstOutPoint <= masGroupS do
  begin
    sum := sum + masGroup[firstOutPoint] shr 1;
    inc(pointCh);
    firstOutPoint := firstOutPoint + nextPointStep;
  end;
  result := round(sum / pointCh);
end;
//==============================================================================

//==============================================================================
//����� �� ��������� ����� ����� �� ��
//==============================================================================
procedure TData.OutMG(errMG:Integer);
var
  procentErr:Integer;
begin
  if errMG=0 then
  begin
    //����� ��� ��� clWhite
    form1.gProgress2.BackColor:=clWhite;
  end
  else
  begin
    //���� ���� ��� clRed
    form1.gProgress2.BackColor:=clRed;
  end;
  procentErr:=Trunc(errMG/0.32);
  Form1.gProgress2.Progress:=procentErr;
end;
//==============================================================================



//==============================================================================
//
//==============================================================================
procedure TData.ReInitialisation;
begin
//  ����� ������
  //form1.startReadACP.Enabled := true;
//  ������ � tlm
  //form1.tlmWriteB.Enabled := false;
//  ���������� ������ ������� ���
//  !!!
//  acp.Free;
end;
//==============================================================================

//M08,04,02,01

//==============================================================================
//��������� ��� ������������ ������ ������� �����. ������� �������� ������
//==============================================================================
procedure TData.TestSMFOutDate(numPointDown:Integer;numCurPoint:integer;numPointUp:integer);
var
  numP:Integer;
begin
  form1.Memo1.Lines.Add('��������� ��������!!! '+intTostr(porog));

  //�� �����
  for numP:=numCurPoint-numPointDown to  numCurPoint-1 do
  begin
    form1.Memo1.Lines.Add('����� ����� � ������� '+intTostr(numP)+' '+'�������� '+IntToStr(fifoMas[numP]));
  end;

  //����� �����
  for numP:=numCurPoint to  numCurPoint+numPointUp do
  begin
    if numP=numCurPoint then
    begin
      form1.Memo1.Lines.Add('����� ����� � �������!!! '+
        intTostr(numP)+' '+'�������� '+IntToStr(fifoMas[numP]));
    end
    else
    begin
      form1.Memo1.Lines.Add('����� ����� � ������� '+
        intTostr(numP)+' '+'�������� '+IntToStr(fifoMas[numP]));
    end;
  end;
  form1.Memo1.Lines.Add('====================');
end;
//==============================================================================

//==============================================================================
//
//==============================================================================

function TData.TestMarker(begNumPoint: integer; const pointCounter: integer): boolean;
var
  i: integer;
  j: integer;
  testFlag: boolean;
begin
  i := begNumPoint;
  if i < 1 then
  begin
    i := FIFOSIZE;
  end;
  testFlag := true;
  for j := 1 to pointCounter do
  begin
    //���� ���� ����� ������ ������. ������ ��� �� ������
    //��������� �� ������� �� �� ������� ����� ������ � ��� �����. �����. � ������
    if i > FIFOSIZE then
    begin
      i := 1;
    end;
    if fifoMas[i] >= porog then
    begin
      testFlag := false;
    end;
    inc(i);
    //!!!
    if (flagEnd) then
    begin
      testFlag := false;
      break;
    end;
  end;
  result := testFlag;
end;
//==============================================================================



procedure TForm1.upGistFastSizeClick(Sender: TObject);
begin
  form1.downGistFastSize.Enabled := true;
  //wait(1);
  testOutFalg:=false;
  //Application.ProcessMessages;
  sleep(50);
  //Application.ProcessMessages;
  if form1.fastGist.BottomAxis.Maximum <= form1.fastGist.BottomAxis.Minimum + {600}400 then
  begin
    form1.upGistFastSize.Enabled := false
  end
  else
  begin
    form1.fastGist.BottomAxis.Maximum := form1.fastGist.BottomAxis.Maximum - 20;
    //data.masFastVal:=nil;
    //setlength(data.masFastVal, trunc(form1.fastGist.BottomAxis.Maximum));
  end;
  testOutFalg:=true;
end;

procedure TForm1.downGistFastSizeClick(Sender: TObject);
begin
  testOutFalg:=false;
  form1.upGistFastSize.Enabled := true;
  sleep(50);
  //wait(1);
  //form1.Label5.Caption:=floatTostr(form1.fastGist.BottomAxis.Maximum);
  form1.fastGist.BottomAxis.Maximum := form1.fastGist.BottomAxis.Maximum + 20;
  if form1.fastGist.BottomAxis.Maximum >= {1800}2000 then
  begin
    form1.downGistFastSize.Enabled := false;
  end;
  testOutFalg:=true;
end;

procedure TForm1.tlmWriteBClick(Sender: TObject);
begin
  cOut:=0;
  if tlm.tlmBFlag then
  //������ ������ � ���
  begin
    form1.tlmWriteB.Caption := '0 Mb';
    //���� ����� � ��� �� �� ����� ��������� �����
    form1.startReadACP.Enabled:=false;
    //��� ����. �������� ��������� � 1 ��
    tlm.iOneGC := 4;
    tlm.StartWriteTLM;
    tlm.WriteTLMhead;
    //���� ������������� ��� ������ � ������ �����
    {data.}flSinxC := false;
    //��������� ������ ������ � ���� ���
    tlm.flagWriteTLM := true;
    //������������� ���� ������ ������ ����� � ����
    tlm.flagFirstWrite := true;
    tlm.flagEndWrite := false;
  end
  else
  //��������� ������ � ���
  begin
    //�������. ���� ��� �����. ������ � ������ �����
    flBeg := false;
    //���� ������������� ��� ������ � ������ �����
    {data.}flSinxC := false;
    tlm.flagWriteTLM := false;
    //form1.WriteTLMTimer.Enabled:=false;
    tlm.flagEndWrite := true;
    closeFile(tlm.PtlmFile);
    tlm.countWriteByteInFile := 0;
    tlm.precision := 0;
    form1.tlmWriteB.Caption := '������';
    //form1.Memo1.Lines.Add('���������� ���������� ������(������) '+
    //intToStr(tlm.blockNumInfile));
    ShowMessage('���� �������!');
    //���� tlm ��������, ����� ��������� �����
    form1.startReadACP.Enabled:=true;
  end;
  //�� ������� � �������� � ��������
  tlm.tlmBFlag := not tlm.tlmBFlag;
end;

procedure TForm1.startReadTlmBClick(Sender: TObject);
begin
  //������ ��� ������ � ��������
  if infNum=0 then
  begin
    dataM16 := TdataM16.CreateData;
  end
  else
  begin
    dataMoth := TdataMoth.CreateData;
  end;


  //���������� ��������������� ��������
  form1.fastGist.AllowZoom:=true;
  form1.fastGist.AllowPanning:=pmBoth;
  form1.gistSlowAnl.AllowZoom:=true;
  form1.gistSlowAnl.AllowPanning:=pmBoth;
  form1.tempGist.AllowZoom:=True;
  form1.tempGist.AllowPanning:=pmBoth;

  testOutFalg:=true;
  //�������. �������� ��� �����. �����. ������� ���� �������
  //��
  acumAnalog := 0;
  //����.
  acumTemp:=0;
  //��
  acumContact := 0;
  //�
  acumFast := 0;
  //����� ��������� � ��������� ���������
  //data.ReInitialisation;
  //data.Free;
  //data := Tdata.CreateData;
  //������������ ���. ������.
  form1.OrbitaAddresMemo.Lines.LoadFromFile(propStrPath);
  //��������� ����������� ������ �������
  GetAddrList;
  //��������� ������ ���������� �������
  SetOrbAddr;

  //��� ������ ������ � ������ � ������� �� ���� ��������� ���
  //��� ������ ���� ��� ������ ���� ������ ������ ������ ����� � �.�
  {data.}groupNum:=1;
  {data.}ciklNum:=1;


  //�������� ������������ ������� �������
  if {data.}GenTestAdrCorrect then
  begin
    //������ ��� ������ � ���
    tlm := Ttlm.CreateTLM;
    //��������� �������� ��������
    form1.tlmPSpeed.Position := 3;
    form1.tlmPSpeed.Enabled:=true;
    //���������� ������� ����������
    if ({data.}FillAdressParam) then
    begin
      ShowMessage('�������� ���� .tlm ��� ���������������!');
      form1.startReadACP.Enabled := false;
      //������� ��� ��������� �����
      tlm.OutFileName;
    end
    else
    begin
      tlm := nil;
      //��������� �������� ��������
      form1.tlmPSpeed.Position := 3;
      form1.tlmPSpeed.Enabled:=false;
      ShowMessage('� ������ ������� ������������ ������!');
    end;
  end
  else
  begin
    showMessage('��������� ������������ �������!');
  end;
end;

procedure TForm1.Series4Click(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ({data.}graphFlagFastP) then
  begin
    {data.}graphFlagFastP := false;
    form1.Timer1.Enabled:=false;
    form1.fastGist.Series[0].Clear;
  end
  else
  begin
    //data.masFastVal := nil; //!!!
    //wait(1);
    //��������� ���������� ���������� � ���������� ������� �� �����
    {data.}chanelIndexFast := ValueIndex + acumAnalog + acumContact+acumTemp;
    //���������� ������������ ��� � ����������� �� ����
    //T22
    if masElemParam[{data.}chanelIndexFast].adressType = 2 then
    begin
      form1.fastGist.LeftAxis.Maximum := 64;
      form1.fastGist.LeftAxis.Minimum := 0;
    end;
    //T21
    if masElemParam[{data.}chanelIndexFast].adressType = 3 then
    begin
      form1.fastGist.LeftAxis.Maximum := 256;
      form1.fastGist.LeftAxis.Minimum := 0;
    end;
    //T24
    if masElemParam[{data.}chanelIndexFast].adressType = 5 then
    begin
      form1.fastGist.LeftAxis.Maximum := 64;
      form1.fastGist.LeftAxis.Minimum := 0;
    end;
    //form1.Timer1.Enabled:=true;
    //����� ���������
    {data.}graphFlagFastP := true;
  end;
end;

procedure TForm1.TimerPlayTlmTimer(Sender: TObject);
begin
  if tlm.fFlag then
  begin
    tlm.ParseBlock(tlm.tlmPlaySpeed)
  end
  else
  begin
    form1.diaSlowAnl.Series[0].Clear;
    form1.diaSlowCont.Series[0].Clear;
    form1.fastDia.Series[0].Clear;
    form1.fastGist.Series[0].Clear;
    form1.gistSlowAnl.Series[0].Clear;
  end;
end;

procedure TForm1.playClick(Sender: TObject);
begin
  form1.TimerPlayTlm.Enabled := true;
end;

procedure TForm1.pauseClick(Sender: TObject);
begin
  form1.TimerPlayTlm.Enabled := false;
end;

procedure TForm1.TrackBar1Change(Sender: TObject);
begin
  if ((form1.TrackBar1.Position <= form1.TrackBar1.Max) and
      (form1.TrackBar1.Position >= form1.TrackBar1.Min)) then
  begin
    form1.TimerPlayTlm.Enabled := false;
    //tlm.stream.Seek(SIZEBLOCKPREF,soFromCurrent);
    //288 ����������������� �������� ��� ����������� ������ �� �����
    tlm.stream.Position := (form1.TrackBar1.Position - 1) * tlm.sizeBlock + MAXHEADSIZE;
    //form1.Memo1.Lines.Add(intToStr(tlm.stream.Position));
    form1.TimerPlayTlm.Enabled := true;
  end
end;

procedure TForm1.stopClick(Sender: TObject);
begin
  form1.propB.Enabled := true;
  //����. ������� ������ �����
  form1.TimerPlayTlm.Enabled := false;
  form1.TrackBar1.Enabled := false;
  //���� ������ ������
  form1.PanelPlayer.Enabled := false;
  //����� ������ ������
  form1.startReadACP.Enabled := true;
  form1.startReadTlmB.Enabled := true;
  //����� �������� � ������
  form1.TrackBar1.Position := 1;
  form1.fileNameLabel.Caption := '';
  form1.orbTimeLabel.Caption := '';
  //���������� ������������
  tlm.fFlag := false;
  form1.TimerPlayTlm.Enabled := false;
  //����� �����
  tlm.stream.Free;
  wait(10);
  form1.diaSlowAnl.Series[0].Clear;
  form1.diaSlowCont.Series[0].Clear;
  form1.fastDia.Series[0].Clear;
  form1.fastGist.Series[0].Clear;
  form1.gistSlowAnl.Series[0].Clear;
  form1.tempDia.Series[0].Clear;
  form1.tempGist.Series[0].Clear;
end;

procedure TForm1.tlmPSpeedChange(Sender: TObject);
begin
  if form1.TrackBar1.Enabled then
  begin
    form1.TimerPlayTlm.Enabled := false;
  end;
  case self.tlmPSpeed.Position of
    0:
    begin
      tlm.tlmPlaySpeed := 1;
    end;
    1:
    begin
      tlm.tlmPlaySpeed := 2;
    end;
    2:
    begin
      tlm.tlmPlaySpeed := 3;
    end;
    3:
    begin
      tlm.tlmPlaySpeed := 4;
    end;
    4:
    begin
      tlm.tlmPlaySpeed := 5;
    end;
    5:
    begin
      tlm.tlmPlaySpeed := 6;
    end;
    6:
    begin
      tlm.tlmPlaySpeed := 7;
    end;
    7:
    begin
      tlm.tlmPlaySpeed := 8;
    end;
  end;
  if form1.TrackBar1.Enabled then
  begin
    form1.TimerPlayTlm.Enabled := true;
  end;
end;

procedure TForm1.propBClick(Sender: TObject);
begin
  //��� ����� �������� ������� ������ ���. �������.
  form1.OrbitaAddresMemo.Clear;
  ShowMessage('�������� ���� ������� ������!');
  form1.OpenDialog2.InitialDir:=ExtractFileDir(ParamStr(0))+'\ConfigDir';;
  //�������� � �����. ���� ��������.
  if form1.OpenDialog2.Execute then
  begin
    propIniFile:=TIniFile.Create(ExtractFileDir(ParamStr(0))+'\ConfigDir\property.ini');
    //propStrPath:=propIniFile.ReadString('lastPropFile','path','');
    //������ ���� �� ����� ��������
    propIniFile.WriteString('lastPropFile','path',form1.OpenDialog2.FileName);
    //������� ��������� ����.
    propStrPath:=propIniFile.ReadString('lastPropFile','path','');
    propIniFile.Free;
    //�������� ������ ����������� ��������
    form1.OrbitaAddresMemo.Lines.LoadFromFile(propStrPath);
    //��������� ����������� ������ �������
    GetAddrList;
    //��������� ������ ���������� �������
    SetOrbAddr;

    form1.startReadACP.Enabled := true;
    form1.startReadTlmB.Enabled := true;
    form1.saveAdrB.Enabled:=true;
  end
  else
  //�� ������
  begin
    ShowMessage('���� ������� ������ �� ������!');
  end;
end;

procedure TForm1.saveAdrBClick(Sender: TObject);
var
  strOut:string;
begin
  strOut:=ExtractFileName(propStrPath){RightStr(propStrPath,7)};
  showMessage('���� ������� '+strOut+' �������!');
  form1.OrbitaAddresMemo.Lines.SaveToFile(propStrPath);
  wait(10);
end;

procedure TForm1.Series5Click(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  if ({data.}graphFlagBusP) then
  begin
    form1.busGist.Series[0].Clear;
    {data.}graphFlagBusP := false;
  end
  else
  begin
    {data.}chanelIndexBus := ValueIndex+acumAnalog + acumContact+acumTemp+acumFast;
    {data.}graphFlagBusP := true;
  end;
end;

procedure TForm1.TimerOutToDiaBusTimer(Sender: TObject);
var
iBus:integer;
busArrayLen:Integer;
begin
  form1.busGist.Series[0].Clear;
  //sleep(3);
  busArrayLen:=length({data.}busArray);
  for iBus:=0 to busArrayLen  do
  begin
    form1.busDia.Series[0].AddXY(iBus, {data.}busArray[iBus]);
  end;
  form1.TimerOutToDiaBus.Enabled := false;
end;

procedure TForm1.Timer1Timer(Sender: TObject);
begin
  {if ((form1.upGistFastSize.Enabled)and(form1.downGistFastSize.Enabled)) then
  begin
    form1.upGistFastSize.Enabled:=false;
    form1.downGistFastSize.Enabled:=false;
  end
  else
  begin
    form1.upGistFastSize.Enabled:=true;
    form1.downGistFastSize.Enabled:=true;
  end;}
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  flagTrue:=true;
  //WinExec(PChar('OrbitaMAll.exe'), SW_ShowNormal);
end;

procedure TForm1.tmrForTestOrbSignalTimer(Sender: TObject);
begin
  if orbOkCounter>=40000 then
  begin
    orbOkCounter:=0;
    if (orbOk) then
    begin
      //������ ������
      form1.tmrForTestOrbSignal.Enabled:=false;
    end
    else
    begin
      form1.tmrForTestOrbSignal.Enabled:=false;
      ShowMessage('������ ������ �� ������! ��������� ������!');
      {data.}graphFlagFastP := false;

      //Application.ProcessMessages;
      sleep(50);
      //Application.ProcessMessages;

      if ((form1.tlmWriteB.Enabled)and
          (not form1.startReadTlmB.Enabled)and
          (not form1.propB.Enabled))  then
      begin
        //��������� ������ � ���
        pModule.STOP_ADC();
      end;
      //�������� ��� ���������� �����
      flagEnd:=true;
      wait(20);
      //�������� ���������� �� �����������.
      Application.Terminate;
    end;
  end;
end;

procedure TForm1.Series7Click(Sender: TChartSeries; ValueIndex: Integer;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //�������� ������� � ����. � � ������ �����������
  //���� ������ ��� ����������� � ��������
  //form1.OrbitaAddresMemo.Enabled:= not form1.OrbitaAddresMemo.Enabled;
  //form1.Memo1.Enabled:= not form1.Memo1.Enabled;
  if ({data.}graphFlagTempP) then
  begin
    form1.tempGist.Series[0].Clear;
    {data.}graphFlagTempP := false;
  end
  else
  begin
    {data.}graphFlagTempP := true;
    //form1.dia.Canvas.MoveTo(form1.dia.Width-1051,form1.dia.Height-33);
    {data.}chanelIndexTemp := ValueIndex+ acumAnalog + acumContact;
  end;
end;

procedure TForm1.upGistTempSizeClick(Sender: TObject);
begin
  form1.downGistTempSize.Enabled := true;
  if form1.tempGist.BottomAxis.Maximum <=form1.tempGist.BottomAxis.Minimum + 20 then
  begin
    form1.upGistTempSize.Enabled := false
  end
  else
  begin
    form1.tempGist.BottomAxis.Maximum := form1.tempGist.BottomAxis.Maximum - 10;
  end;
end;

procedure TForm1.downGistTempSizeClick(Sender: TObject);
begin
  form1.upGistTempSize.Enabled := true;
  form1.tempGist.BottomAxis.Maximum := form1.tempGist.BottomAxis.Maximum + 10;
  if form1.tempGist.BottomAxis.Maximum >= 700 then
  begin
    form1.downGistTempSize.Enabled := false;
  end;
end;

procedure TForm1.tmrContTimer(Sender: TObject);
var
  orbAdrCount: integer;
begin
  orbAdrCount := 0;
  //������� ��� �������� ���������� ���������� �������
  {data.}contactAdrCount := 0;
  form1.diaSlowCont.Series[0].Clear;
  while orbAdrCount <= iCountMax - 1 do // iCountMax-1
  begin
    if masElemParam[orbAdrCount].adressType=1 then
    begin
      //���������� ������ ������ � ����������� ��������
      {data.}outToDia(
      masElemParam[orbAdrCount].numOutElemG,
      masElemParam[orbAdrCount].stepOutG,
      masGroupSize,orbAdrCount,
      masElemParam[orbAdrCount].adressType,
      masElemParam[orbAdrCount].bitNumber,
      masElemParam[orbAdrCount].numBusThread,
      masElemParam[orbAdrCount].adrBus,
      masElemParam[orbAdrCount].numOutPoint,
      masElemParam[orbAdrCount].flagGroup,
      masElemParam[orbAdrCount].flagCikl);
    end;
    inc(orbAdrCount);
  end;
  form1.tmrCont.Enabled := false;
end;

procedure TForm1.btnAutoTestClick(Sender: TObject);
begin
end;

//udp ��� �������� ������ �� �������� ������� ����.
end.

