unit inventorymanager;

{$mode objfpc}{$H+}

interface

uses
  product_BOM
  , tiObject
  ;

type

  { TInventoryManager }

  TInventoryManager = class(TtiObject)
  private
    FProductCategoryList: TProductCategoryList;
    FProductList: TProductList;
    procedure LoadCategories;
  protected
  public
    constructor Create; override;
    destructor Destroy; override;
    procedure LoadProducts;
  published
    property ProductList: TProductList read FProductList;
    property ProductCategoryList: TProductCategoryList read FProductCategoryList;
  end;

  //global Singleton
  function gInventoryManager: TInventoryManager;

implementation

var
  uInventoryManager: TInventoryManager;

function gInventoryManager: TInventoryManager;
begin
  if not Assigned(uInventoryManager) then
    uInventoryManager := TInventoryManager.Create;
  Result := uInventoryManager;
end;

{ TInventoryManager }

procedure TInventoryManager.LoadCategories;
var
  C: TProductCategory;
begin
  C:= TProductCategory.Create;
  C.Description:= 'Soft Drinks';
  ProductCategoryList.Add(C);
  C:= TProductCategory.Create;
  C.Description:= 'Alcoholic Drinks';
  ProductCategoryList.Add(C);
  C:= TProductCategory.Create;
  C.Description:= 'Snacks';
  ProductCategoryList.Add(C);

end;

constructor TInventoryManager.Create;
begin
  inherited Create;
  FProductCategoryList := TProductCategoryList.Create;
  FProductList := TProductList.Create;
  FProductCategoryList.Owner := Self;
  FProductList.Owner := Self;
end;

destructor TInventoryManager.Destroy;
begin
  FProductCategoryList.Free;
  FProductList.Free;
  inherited Destroy;
end;

procedure TInventoryManager.LoadProducts;
var
  P: TProduct;
begin
  LoadCategories;

  P := TProduct.Create;
  P.Description:= 'Coca Cola';
  P.Category:= TProductCategory(FProductCategoryList[0]);
  FProductList.Add(P);
  P := TProduct.Create;
  P.Description:= 'San Mig Light';
  P.Category:= TProductCategory(FProductCategoryList[1]);
  FProductList.Add(P);
  P := TProduct.Create;
  P.Description:= 'Chippy';
  P.Category := TProductCategory.Create;
  FProductList.Add(P);
end;

initialization
  uInventoryManager := nil;

finalization
  uInventoryManager.Free;

end.

