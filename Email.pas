unit Email;

interface

uses
  Winapi.Windows, Winapi.Messages, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.StdCtrls, Vcl.WinXPickers,
  AdvGlowButton, Vcl.Imaging.pngimage, Vcl.ExtCtrls, ACBrBase, ACBrMail,
  Vcl.FileCtrl;

type
  TForm3 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Panel2: TPanel;
    Image1: TImage;
    Panel3: TPanel;
    Panel4: TPanel;
    btnEnviar: TAdvGlowButton;
    Label2: TLabel;
    Panel5: TPanel;
    data: TDatePicker;
    Label3: TLabel;
    Panel6: TPanel;
    textContador: TEdit;
    Label4: TLabel;
    Panel7: TPanel;
    Panel8: TPanel;
    Label5: TLabel;
    radioDezembro: TRadioButton;
    radioNovembro: TRadioButton;
    radioOutubro: TRadioButton;
    radioSetembro: TRadioButton;
    radioAgosto: TRadioButton;
    radioJulho: TRadioButton;
    radioJunho: TRadioButton;
    radioMaio: TRadioButton;
    radioAbril: TRadioButton;
    radioMarço: TRadioButton;
    radioFevereiro: TRadioButton;
    radioJaneiro: TRadioButton;
    Panel9: TPanel;
    Panel10: TPanel;
    Label6: TLabel;
    memo: TMemo;
    ACBrMail1: TACBrMail;
    Button1: TButton;

    procedure btnEnviarClick(Sender: TObject);
    procedure lertxt;
      procedure configemail;
    procedure Button1Click(Sender: TObject);
    procedure conatdor;
    procedure FormCreate(Sender: TObject);
    procedure save;
  private

    { Private declarations }
  public
  var
  globalcaminho:string
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses
  Vcl.Dialogs, System.SysUtils;

{$R *.dfm}

procedure TForm3.btnEnviarClick(Sender: TObject);
begin
configemail;
end;

procedure TForm3.Button1Click(Sender: TObject);
begin
save;
end;

procedure TForm3.conatdor;
var
  FileName: string;
  FileContent: TStringList;
  Line: string;
  Key, Value: string;
begin
  FileName := 'F:\arquivo.txt';

  if FileExists(FileName) then
  begin
    FileContent := TStringList.Create;
    try
      FileContent.LoadFromFile(FileName);

      // Procura pela chave 'Contador' no arquivo
      for Line in FileContent do
      begin
        if Pos(':', Line) > 0 then
        begin
          Key := Trim(Copy(Line, 1, Pos(':', Line) - 1));
          Value := Trim(Copy(Line, Pos(':', Line) + 1, Length(Line)));

          if SameText(Key, 'Contador') then
          begin
            ShowMessage('Email do Contador: ' + Value);
            Exit;
          end;
        end;
      end;

      ShowMessage('Chave "Contador" não encontrada no arquivo.');
    finally
      FileContent.Free;
    end;
  end
  else
    ShowMessage('Arquivo não encontrado!');
end;

procedure TForm3.configemail;
var
Dir,strMSGMAIL: string;
begin

Dir := ExtractFilePath(ParamStr(0));
  // Configurações do servidor SMTP
  ACBrMail1.Host := 'smtp-mail.outlook.com';
  ACBrMail1.Port := '587';
  ACBrMail1.Username := 'MultimacXML@outlook.com';
  ACBrMail1.Password := 'TImultimac# 16';  // Remova espaços extras, se houver
  ACBrMail1.SetTLS := True;  // Use True para TLS, ou False para não usar

  // Configurações do e-mail
  ACBrMail1.From := 'MultimacXML@outlook.com';  // O e-mail remetente
  ACBrMail1.AddAddress('fabiopassos1997@Gmail.com');  // Adicione o destinatário
  ACBrMail1.Subject := 'Assunto do E-mail';
  AcbrMail1.AltBody.Add(globalcaminho);
  try
    ACBrMail1.Send;
    ShowMessage('E-mail enviado com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao enviar e-mail: ' + E.Message);
  end;

end;



procedure TForm3.FormCreate(Sender: TObject);
begin
lertxt;
end;

procedure TForm3.lertxt;
var
  FileName: string;
  StreamReader: TStreamReader;
  FileContent,Dir: string;
  email:string;
  MyClass: TComponent;
  FileContent2:TStringList;
begin

  Dir := IncludeTrailingPathDelimiter(ExtractFilePath(ParamStr(0)));
  FileName := Dir + 'arquivo.txt';





  if FileExists(FileName) then
  begin

  MyClass := TComponent.Create(Self);

  end;
    StreamReader := TStreamReader.Create(FileName);
    try
      FileContent := StreamReader.ReadToEnd;
     globalcaminho:= ('Conteúdo do arquivo: ' + sLineBreak + FileContent);

    finally
      StreamReader.Free;
    end;

    conatdor;




end;
procedure TForm3.save;
var
  FileName: string;
  FileContent: TStringList;
begin
  FileName := 'F:\Email\arquivo2.txt'; // Defina o caminho onde deseja salvar o arquivo

  FileContent := TStringList.Create;
  try
    // Adiciona o conteúdo do TEdit ao TStringList
    FileContent.Add('Contador:' + textContador.Text);

    // Salva o TStringList no arquivo
    FileContent.SaveToFile(FileName);

    ShowMessage('Texto salvo com sucesso!');
  except
    on E: Exception do
      ShowMessage('Erro ao salvar o arquivo: ' + E.Message);
  end;
  FileContent.Free;
end;

end.
