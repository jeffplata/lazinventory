unit ProductForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, Grids,
  StdCtrls
  , product_BOM
  , tiModelMediator
  , tiListMediators
  , tiMediators
  ;

type

  { TForm1 }

  TForm1 = class(TForm)
    edtProductName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    sgProductList: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sgProductListClick(Sender: TObject);
  private
    FProduct: TProduct;
    FProductList: TProductList;
    FData: TProductList;
    FMediator: TtiModelMediator;
    FProductMediator: TtiModelMediator;
    procedure SetData(AValue: TProductList);
    procedure SetProduct(AValue: TProduct);

  public
    property Data: TProductList read FData write SetData;
    property Product: TProduct read FProduct write SetProduct;
  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
  lProduct: TProduct;
begin
  FProductList:= TProductList.Create;
  lProduct := TProduct.Create;
  lProduct.Description:= 'test';
  FProductList.Add(lProduct);
  lProduct := TProduct.Create;
  lProduct.Description:= 'tesfsdfsdfst';
  FProductList.Add(lProduct);

  Data := FProductList;

end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  FProductList.Free;
end;

procedure TForm1.sgProductListClick(Sender: TObject);
begin
  Product := TProduct(FMediator.SelectedObject[sgProductList]);
end;


procedure TForm1.SetData(AValue: TProductList);
begin
  if FData=AValue then Exit;
  FData:=AValue;
  if not assigned(FMediator) then
  begin
    FMediator:= TtiModelMediator.Create(Self);
    FMediator.Name:= 'ProductListMediator';
    FMediator.AddComposite('Description(50,"Description",<)', sgProductList);
  end;
  FMediator.Subject:= FProductList;
  FMediator.Active:= True;

end;

procedure TForm1.SetProduct(AValue: TProduct);
begin
  if FProduct=AValue then Exit;
  FProduct:=AValue;

  if not Assigned(FProductMediator) then
  begin
    FProductMediator := TtiModelMediator.Create(Self);
    FProductMediator.Name:= 'ProductMediator';
    FProductMediator.AddProperty('Description', edtProductName);
  end;
  FProductMediator.Subject := FProduct;
  FProductMediator.Active:= True;

end;

initialization
  RegisterFallBackMediators;
  RegisterFallbackListMediators;

end.

