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

  { TfrmProducts }

  TfrmProducts = class(TForm)
    cmbCategory: TComboBox;
    edtProductName: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    sgProductList: TStringGrid;
    procedure FormCreate(Sender: TObject);
    procedure sgProductListClick(Sender: TObject);
  private
    FProduct: TProduct;
    FData: TProductList;
    FMediator: TtiModelMediator;
    FProductMediator: TtiModelMediator;
    procedure SetData(AValue: TProductList);
    procedure SetProduct(AValue: TProduct);
    procedure SetupMediators;
  public
    property Data: TProductList read FData write SetData;
    property Product: TProduct read FProduct write SetProduct;
  end;

var
  frmProducts: TfrmProducts;

procedure ShowProductsForm;

implementation

uses
  inventorymanager
  ;

procedure ShowProductsForm;
var
  F : TfrmProducts;
begin
  F := TfrmProducts.Create(Application);
  try
    F.ShowModal;
  finally
    F.Free;
  end;
end;

{$R *.lfm}

{ TfrmProducts }

procedure TfrmProducts.FormCreate(Sender: TObject);
begin
  RegisterFallBackMediators;
  RegisterFallBackListmediators;
  Data := gInventoryManager.ProductList;
  gInventoryManager.LoadProducts;
  SetupMediators;
  Product := TProduct(FMediator.SelectedObject[sgProductList]);
end;


procedure TfrmProducts.sgProductListClick(Sender: TObject);
begin
  Product := TProduct(FMediator.SelectedObject[sgProductList]);
end;


procedure TfrmProducts.SetData(AValue: TProductList);
begin
  if FData=AValue then Exit;
  FData:=AValue;
end;

procedure TfrmProducts.SetProduct(AValue: TProduct);
begin
  if FProduct=AValue then Exit;
  FProduct:=AValue;
  if not Assigned(FProductMediator) then
  begin
    FProductMediator := TtiModelMediator.Create(Self);
    FProductMediator.Name:= 'ProductMediator';
    FProductMediator.AddProperty('Description', edtProductName);
    FProductMediator.AddProperty('Category',cmbCategory).ValueList := gInventoryManager.ProductCategoryList;
  end;
  FProductMediator.Subject := FProduct;
  FProductMediator.Active:= True;
end;

procedure TfrmProducts.SetupMediators;
begin
  if not assigned(FMediator) then
  begin
    FMediator:= TtiModelMediator.Create(Self);
    FMediator.Name:= 'ProductListMediator';
    FMediator.AddComposite('Description(150,"Description",<);Category.Description(50,"Category")', sgProductList);
  end;
  FMediator.Subject:= gInventoryManager.ProductList;
  FMediator.Active:= True;
end;


end.

