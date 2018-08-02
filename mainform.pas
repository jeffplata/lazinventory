unit mainform;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Menus,
  ActnList, StdActns;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    actProducts: TAction;
    ActionList1: TActionList;
    FileExit1: TFileExit;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    procedure actProductsExecute(Sender: TObject);
  private

  public

  end;

var
  frmMain: TfrmMain;

implementation

uses
  ProductForm
  ;

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.actProductsExecute(Sender: TObject);
begin
  ShowProductsForm;
end;

end.

